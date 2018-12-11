//
//  NSMutableDictionary+CXProtect.m
//  CXProtect
//
//  Created by chuxiao on 2018/5/22.
//  Copyright © 2018年 CXProtect. All rights reserved.
//

#import "NSMutableDictionary+CXProtect.h"
#import "NSObject+Protect.h"
#import "NSException+CXProtectLog.h"

@implementation NSMutableDictionary (CXProtect)

+ (void)setupMutableDictionaryProtect
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class __NSDictionaryM = NSClassFromString(@"__NSDictionaryM");
//        Class __NSPlaceholderDictionary  = NSClassFromString(@"__NSPlaceholderDictionary");
        
        //setObject:forKey:
        [self exchangeInstanceMethod:__NSDictionaryM originalSel:@selector(setObject:forKey:) swizzledSel:@selector(cx_setObject:forKey:)];
        
        // @[]
        [self exchangeInstanceMethod:__NSDictionaryM originalSel:@selector(setObject:forKeyedSubscript:) swizzledSel:@selector(cx_setObject:forKeyedSubscript:)];
        
        //removeObjectForKey:
        [self exchangeInstanceMethod:__NSDictionaryM originalSel:@selector(removeObjectForKey:) swizzledSel:@selector(cx_removeObjectForKey:)];
        
        /**
         @{}生成对象
         */
//        [self exchangeInstanceMethod:__NSPlaceholderDictionary originalSel:@selector(initWithObjects:forKeys:) swizzledSel:@selector(cx_initWithObjects:forKeys:)];
        
    });
}


- (void)cx_setObject:(id)obj forKey:(id<NSCopying>)key {
    
    @try {
        [self cx_setObject:obj forKey:key];
    }
    @catch (NSException *exception) {
        [exception print];
    }
    @finally {
    }
}

- (void)cx_setObject:(id)obj forKeyedSubscript:(id<NSCopying>)key {
    
    @try {
        [self cx_setObject:obj forKey:key];
    }
    @catch (NSException *exception) {
        [exception print];
    }
    @finally {
        
    }
}

- (void)cx_removeObjectForKey:(id)key {
    
    @try {
        [self cx_removeObjectForKey:key];
    }
    @catch (NSException *exception) {
        [exception print];
    }
    @finally {
    }
}

- (id)cx_initWithObjects:(NSArray * _Nonnull )objects forKeys:(NSArray * _Nonnull)keys {
    id object = nil;
    
    @try {
        object = [self cx_initWithObjects:objects forKeys:keys];
    }
    @catch (NSException *exception) {
        [exception print];
    }
    @finally {
        return object;
    }
}

@end
