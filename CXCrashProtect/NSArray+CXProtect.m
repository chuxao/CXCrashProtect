//
//  NSArray+CXProtect.m
//  CXProtect
//
//  Created by chuxiao on 2018/5/21.
//  Copyright © 2018年 CXProtect. All rights reserved.
//

#import "NSArray+CXProtect.h"
#import <objc/runtime.h>
#import "NSObject+Protect.h"
#import "NSException+CXProtectLog.h"

@implementation NSArray (CXProtect)


/**
 这里使用单例的方式，提高启动速度
 */
+ (void)setupArrayProtect {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        /**
         获取所有可能存在的class
         
         __NSArray0等这些都是私有类，继承自NSArray，属于NSArray的类簇
         */
        Class __NSArray = objc_getClass("NSArray");
        Class __NSArray0 = objc_getClass("__NSArray0");
        Class __NSArrayI = objc_getClass("__NSArrayI");
        Class __NSSingleObjectArrayI = objc_getClass("__NSSingleObjectArrayI");
//        Class __NSPlaceholderArray = objc_getClass("__NSPlaceholderArray");
        
        /**
         objectatindex防护
         */
        
        // count == 0
        [self exchangeInstanceMethod:__NSArray0 originalSel:@selector(objectAtIndex:) swizzledSel:@selector(cx_objectAtIndex_0:)];
        
        // count == 1
        [self exchangeInstanceMethod:__NSSingleObjectArrayI originalSel:@selector(objectAtIndex:) swizzledSel:@selector(cx_objectAtIndex_1:)];
        
        // count >= 2
        [self exchangeInstanceMethod:__NSArrayI originalSel:@selector(objectAtIndex:) swizzledSel:@selector(cx_objectAtIndex:)];
        
        /**
         @[]防护
         */
        [self exchangeInstanceMethod:__NSArrayI originalSel:@selector(objectAtIndexedSubscript:) swizzledSel:@selector(cx_objectAtIndexedSubscript:)];

        /**
         @[]生成对象
         这里并非__NSPlaceholderArray调用`initWithObjects:count:`这个方法，而是`NSArray`调用`arrayWithObjects:count:`这个方法
         */
//        [self exchangeInstanceMethod:__NSPlaceholderArray originalSel:@selector(initWithObjects:count:) swizzledSel:@selector(cx_initWithObjects:count:)];
        
        [self exchangeClassMethod:__NSArray originalSel:@selector(arrayWithObjects:count:) swizzledSel:@selector(cx_arrayWithObjects:count:)];
        
        /**
         getObjects:range:防护
         */
        [self exchangeInstanceMethod:__NSArray originalSel:@selector(getObjects:range:) swizzledSel:@selector(cx_getObjects_array:range:)];
        
        [self exchangeInstanceMethod:__NSArrayI originalSel:@selector(getObjects:range:) swizzledSel:@selector(cx_getObjects_arrayI:range:)];
        
        [self exchangeInstanceMethod:__NSSingleObjectArrayI originalSel:@selector(getObjects:range:) swizzledSel:@selector(cx_getObjects_single:range:)];
        
    });
}

#pragma mark - NSArray new method
+ (instancetype)cx_arrayWithObjects:(const id  _Nonnull __unsafe_unretained *)objects count:(NSUInteger)cnt {
    
    id instance = nil;
    
    @try {
        instance = [self cx_arrayWithObjects:objects count:cnt];
    }
    @catch (NSException *exception) {
        [exception print];
    }
    @finally {
        return instance;
    }
}


- (id)cx_objectAtIndex:(NSUInteger)index {
    
    id object = nil;
    @try {
        object = [self cx_objectAtIndex:index];
    }
    @catch (NSException *exception) {
        /**
         firebase 打点处理
         */
        
        
        [exception print];
    }
    @finally {
        return object;
    }
}

- (id)cx_objectAtIndex_0:(NSUInteger)index {
    id object = nil;
    @try {
        object = [self cx_objectAtIndex_0:index];
    }
    @catch (NSException *exception) {
        [exception print];
    }
    @finally {
        return object;
    }
}

- (id)cx_objectAtIndex_1:(NSUInteger)index {
    id object = nil;
    @try {
        object = [self cx_objectAtIndex_1:index];
    }
    @catch (NSException *exception) {
        [exception print];
    }
    @finally {
        return object;
    }
}

- (id)cx_objectAtIndexedSubscript:(NSUInteger)index {
    id object = nil;
    @try {
        object = [self cx_objectAtIndexedSubscript:index];
    }
    @catch (NSException *exception) {
        [exception print];
    }
    @finally {
        return object;
    }
}

- (id)cx_initWithObjects:(const id  _Nonnull __unsafe_unretained *)objects count:(NSUInteger)count
{
    id object = nil;
    
    @try {
        object = [self cx_initWithObjects:objects count:count];
    }
    @catch (NSException *exception) {
        [exception print];
    }
    @finally {
        return object;
    }
}

- (void)cx_getObjects_single:(__unsafe_unretained id  _Nonnull [])objects range:(NSRange)range
{
    @try {
        [self cx_getObjects_single:objects range:range];
    }
    @catch (NSException *exception) {
        [exception print];
    }
    @finally {
        
    }
}

- (void)cx_getObjects_array:(__unsafe_unretained id  _Nonnull [])objects range:(NSRange)range
{
    @try {
        [self cx_getObjects_array:objects range:range];
    }
    @catch (NSException *exception) {
        [exception print];
    }
    @finally {
        
    }
}

- (void)cx_getObjects_arrayI:(__unsafe_unretained id  _Nonnull [])objects range:(NSRange)range
{
    @try {
        [self cx_getObjects_arrayI:objects range:range];
    }
    @catch (NSException *exception) {
        [exception print];
    }
    @finally {
        
    }
}

@end
