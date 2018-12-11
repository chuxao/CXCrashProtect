//
//  NSDictionary+CXProtect.m
//  CXProtect
//
//  Created by chuxiao on 2018/5/22.
//  Copyright © 2018年 CXProtect. All rights reserved.
//

#import "NSDictionary+CXProtect.h"
#import <objc/runtime.h>
#import "NSObject+Protect.h"
#import "NSException+CXProtectLog.h"

@implementation NSDictionary (CXProtect)

+ (void)setupDictionaryProtect
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class __NSDictionary = objc_getClass("NSDictionary");
//        Class __NSPlaceholderDictionary  = NSClassFromString(@"__NSPlaceholderDictionary");
//        Class __NSDictionaryM = NSClassFromString(@"__NSDictionaryM");

        /**
         @{}生成对象
         */
        
        [self exchangeClassMethod:__NSDictionary originalSel:@selector(dictionaryWithObjects:forKeys:count:) swizzledSel:@selector(cx_dictionaryWithObjects:forKeys:count:)];
        
    });
}

#pragma mark - new Methods
+ (instancetype)cx_dictionaryWithObjects:(const id  _Nonnull __unsafe_unretained *)objects forKeys:(const id<NSCopying>  _Nonnull __unsafe_unretained *)keys count:(NSUInteger)count {
    
    id instance = nil;
    @try {
        instance = [self cx_dictionaryWithObjects:objects forKeys:keys count:count];
    }
    @catch (NSException *exception) {
        
        [exception print];
    }
    @finally {
        return instance;
    }
}


@end
