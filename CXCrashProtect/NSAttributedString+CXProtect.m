//
//  NSAttributedString+CXProtect.m
//  防护Test
//
//  Created by chuxiao on 2018/12/14.
//  Copyright © 2018年 chuxiao. All rights reserved.
//

#import "NSAttributedString+CXProtect.h"
#import <objc/runtime.h>
#import "NSObject+Protect.h"
#import "NSException+CXProtectLog.h"

@implementation NSAttributedString (CXProtect)

+ (void)setupAttributedStringProtect
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class __NSConcreteAttributedString = objc_getClass("NSConcreteAttributedString");

        [self exchangeInstanceMethod:__NSConcreteAttributedString originalSel:@selector(initWithString:) swizzledSel:@selector(cx_initWithString:)];
        
        [self exchangeInstanceMethod:__NSConcreteAttributedString originalSel:@selector(initWithString:attributes:) swizzledSel:@selector(cx_initWithString:attributes:)];
        
    });
}

#pragma mark - new Methods

- (instancetype)cx_initWithString:(NSString *)str{
    
    id instance = nil;
    @try {
        instance = [self cx_initWithString:str];
    }
    @catch (NSException *exception) {
        
        [exception print];
    }
    @finally {
        return instance;
    }
}

- (instancetype)cx_initWithString:(NSString *)str attributes:(nullable NSDictionary<NSAttributedStringKey, id> *)attrs{
    
    id instance = nil;
    @try {
        instance = [self cx_initWithString:str attributes:attrs];
    }
    @catch (NSException *exception) {
        
        [exception print];
    }
    @finally {
        return instance;
    }
}

@end
