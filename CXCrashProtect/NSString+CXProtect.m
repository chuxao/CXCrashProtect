//
//  NSString+CXProtect.m
//  CXProtect
//
//  Created by chuxiao on 2018/7/6.
//  Copyright © 2018年 CXProtect. All rights reserved.
//

#import "NSString+CXProtect.h"
#import "NSObject+Protect.h"
#import "NSException+CXProtectLog.h"

@implementation NSString (CXProtect)

+ (void)setupStringProtect
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class __NSCFConstantString = NSClassFromString(@"__NSCFConstantString");
        
        /**
         这里可以防护`rangeOfString:`这个方法
         `rangeOfString:`底层调用为`rangeOfString:options:range:locale:`
         */
        [self exchangeInstanceMethod:__NSCFConstantString originalSel:@selector(rangeOfString:options:range:locale:) swizzledSel:@selector(cx_rangeOfString:options:range:locale:)];
        
        /**
         下面几个方法同样作用于NSMutableString
         */
        [self exchangeInstanceMethod:__NSCFConstantString originalSel:@selector(substringToIndex:) swizzledSel:@selector(cx_substringToIndex:)];
        
        [self exchangeInstanceMethod:__NSCFConstantString originalSel:@selector(substringFromIndex:) swizzledSel:@selector(cx_substringFromIndex:)];
        
        //substringWithRange:
        [self exchangeInstanceMethod:__NSCFConstantString originalSel:@selector(substringWithRange:) swizzledSel:@selector(cx_substringWithRange:)];
        
    });
}

- (NSRange)cx_rangeOfString:(NSString *)aString
               options:(NSStringCompareOptions)mask
                 range:(NSRange)searchRange
                locale:(NSLocale *)locale
{
    
    NSRange range;
    @try {
        range = [self cx_rangeOfString:aString options:mask range:searchRange locale:locale];
    }
    @catch (NSException *exception) {
        
        [exception print];
    }
    @finally {
        return range;
    }
}

- (NSString *)cx_substringFromIndex:(NSUInteger)index {
    
    NSString *subString = nil;
    
    @try {
        subString = [self cx_substringFromIndex:index];
    }
    @catch (NSException *exception) {
        [exception print];
    }
    @finally {
        return subString;
    }
}

- (NSString *)cx_substringToIndex:(NSUInteger)index {
    
    NSString *subString = nil;
    
    @try {
        subString = [self cx_substringToIndex:index];
    }
    @catch (NSException *exception) {
        [exception print];
    }
    @finally {
        return subString;
    }
}

- (NSString *)cx_substringWithRange:(NSRange)range {
    
    NSString *subString = nil;
    
    @try {
        subString = [self cx_substringWithRange:range];
    }
    @catch (NSException *exception) {
        [exception print];
    }
    @finally {
        return subString;
    }
}


@end
