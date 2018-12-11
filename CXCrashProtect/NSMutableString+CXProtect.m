//
//  NSMutableString+CXProtect.m
//  CXProtect
//
//  Created by chuxiao on 2018/7/6.
//  Copyright © 2018年 CXProtect. All rights reserved.
//

#import "NSMutableString+CXProtect.h"
#import "NSObject+Protect.h"
#import "NSException+CXProtectLog.h"

@implementation NSMutableString (CXProtect)

+ (void)setupMutableStringProtect
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class __NSCFString = NSClassFromString(@"__NSCFString");
        
        [self exchangeInstanceMethod:__NSCFString originalSel:@selector(rangeOfString:options:range:locale:) swizzledSel:@selector(cx_rangeOfString:options:range:locale:)];
        
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

@end
