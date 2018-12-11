//
//  NSException+CXProtectLog.h
//  CXProtect
//
//  Created by chuxiao on 2018/5/23.
//  Copyright © 2018年 CXProtect. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSException (CXProtectLog)

/**
 直接输出
 */
- (void)print;

/**
 连带打点输出

 @param eventName 打点名称
 */
- (void)printWithTrackEvent:(NSString *)eventName;

/**
 输出指定内容
 */
+ (void)printWithMessage:(NSString *)message;

/**
 输出指定内容并打点

 @param message 输出内容
 @param eventName 打点名称
 */
+ (void)printWithMessage:(NSString *)message trackEvent:(NSString *)eventName;

@end
