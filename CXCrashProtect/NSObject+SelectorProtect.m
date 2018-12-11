//
//  NSObject+SelectorProtect.m
//  CXProtect
//
//  Created by chuxiao on 2018/6/13.
//  Copyright © 2018年 CXProtect. All rights reserved.
//

#import "NSObject+SelectorProtect.h"
#import <objc/runtime.h>
#import "NSObject+Protect.h"
#import "NSException+CXProtectLog.h"

@interface CXSelectorProtectObject ()


@end


@implementation CXSelectorProtectObject

id virtualMethod(id self, SEL _cmd) {
    // 进行打点操作
    NSLog(@"*********** unrecognized selector ***********  %@",NSStringFromSelector(_cmd));
    
    [NSException printWithMessage:@"cx_Selector_InstanceMethod_Protect"];
    
    return 0;
}

id virtualClassMethod(id self, SEL _cmd) {
    // 进行打点操作
    NSLog(@"class *********** unrecognized selector ***********  %@",NSStringFromSelector(_cmd));
    
    [NSException printWithMessage:@"cx_Selector_ClassMethod_Protect"];
    
    return 0;
}

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    class_addMethod([self class], sel, (IMP)virtualMethod, "@@:@");
    
    return YES;
}

+ (BOOL)resolveClassMethod:(SEL)sel
{
    // 获取 MetaClass
    Class predicateMetaClass = objc_getMetaClass([NSStringFromClass(self) UTF8String]);
    
    // 动态添加类方法
    class_addMethod(predicateMetaClass, sel, (IMP)virtualClassMethod, "@@:@");
    
    return YES;
}

@end



@implementation NSObject (SelectorProtect)

+ (void)setupSelectorProtect
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [NSObject exchangeInstanceMethod:[self class] originalSel:@selector(forwardingTargetForSelector:) swizzledSel:@selector(cx_forwardingTargetForSelector:)];
        
        [NSObject exchangeClassMethod:[self class] originalSel:@selector(forwardingTargetForSelector:) swizzledSel:@selector(cx_forwardingTargetForSelector:)];
    });
}

- (id)cx_forwardingTargetForSelector:(SEL)aSelector {
    
    /**
     由于forwardingTargetForSelector发生在消息转发的第二步，如果某个类本来实现了forwardInvocation，由于在这个方法里crash被防护掉，导致原有的forwardInvocation实现逻辑形同虚设，故这里需要进行判断
     当然，如果forwardInvocation不多的话，可以将对应的逻辑转移到其他地方。
     */
    if ([self respondsToSelector:@selector(forwardInvocation:)]) {
        
        IMP impObj = class_getMethodImplementation([NSObject class], @selector(forwardInvocation:));
        IMP impOverride = class_getMethodImplementation([self class], @selector(forwardInvocation:));
        if (impObj != impOverride) { // 类重写了forwardInvocation,不进行防护
            return nil;
        }
    }
    
    CXSelectorProtectObject *selectorObj = [CXSelectorProtectObject new];
    selectorObj.obj = self;
    
    return selectorObj;
}


+ (id)cx_forwardingTargetForSelector:(SEL)aSelector
{
    NSLog(@"*************** 类方法防护 *************** %@", self);
    
    if ([self respondsToSelector:@selector(forwardInvocation:)]) {
        
        /**
         TODO: 类重写了forwardInvocation，得到的方法指针和NSObject的将是不一样的，如此可以进行判断
         
         直接通过类只能获取到实例的方法指针，类的方法指针存储在类的meta类中
         */
        Class metaKlassObj = objc_getMetaClass(NSStringFromClass([NSObject class]).UTF8String);
        Class metaKlass = objc_getMetaClass(NSStringFromClass([self class]).UTF8String);
        
        // class_getMethodImplementation_stret不支持arm64
        IMP impObj = class_getMethodImplementation(metaKlassObj, @selector(forwardInvocation:));
        IMP impOverride = class_getMethodImplementation(metaKlass, @selector(forwardInvocation:));
        
        
        
        if (impObj != impOverride) {
            return nil;
        }
    }
    
    // 转发类方法对应返回类对象
    return [CXSelectorProtectObject class];
}

@end








