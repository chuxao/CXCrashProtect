//
//  NSObject+SelectorProtect.h
//  CXProtect
//
//  Created by chuxiao on 2018/6/13.
//  Copyright © 2018年 CXProtect. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 方法最终承接类
 */
@interface CXSelectorProtectObject : NSObject

@property (weak, nonatomic) NSObject *obj;

@end

@interface NSObject (SelectorProtect)

/**
 针对`unrecognized selector sent to instance`的防护
 
 📎本防护针对实例方法，不支持类方法的防护
 📎
 */
+ (void)setupSelectorProtect;

@end
