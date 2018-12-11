//
//  NSArray+CXProtect.h
//  CXProtect
//
//  Created by chuxiao on 2018/5/21.
//  Copyright © 2018年 CXProtect. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (CXProtect)

/**
 设置NSArray的越界防护
 */
+ (void)setupArrayProtect;

@end
