//
//  CXProtectManager.m
//  CXProtect
//
//  Created by chuxiao on 2018/5/21.
//  Copyright © 2018年 CXProtect. All rights reserved.
//

#import "CXProtectManager.h"
#import "NSArray+CXProtect.h"
#import "NSMutableArray+CXProtect.h"
#import "NSDictionary+CXProtect.h"
#import "NSMutableDictionary+CXProtect.h"
#import "NSString+CXProtect.h"
#import "NSMutableString+CXProtect.h"
#import "NSAttributedString+CXProtect.h"
#import "NSObject+SelectorProtect.h"

@implementation CXProtectManager

+ (void)load
{
    [NSArray setupArrayProtect];
    [NSMutableArray setupMutableArrayProtect];
    [NSDictionary setupDictionaryProtect];
    [NSMutableDictionary setupMutableDictionaryProtect];
    [NSString setupStringProtect];
    [NSMutableString setupMutableStringProtect];
    [NSAttributedString setupAttributedStringProtect];
    [NSObject setupSelectorProtect];
}


@end
