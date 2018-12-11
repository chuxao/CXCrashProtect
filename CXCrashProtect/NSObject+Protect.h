//
//  NSObject+Protect.h
//  CXProtect
//
//  Created by chuxiao on 2018/5/21.
//  Copyright © 2018年 CXProtect. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Protect)

/**
 实例方法交换
 
 @param cxClass 被交换的class
 @param originalSel 源方法
 @param swizzledSel 交换方法
 */
+ (void)exchangeInstanceMethod:(Class _Nonnull)cxClass
                   originalSel:(SEL _Nonnull)originalSel
                   swizzledSel:(SEL _Nonnull)swizzledSel;


/**
 类方法替换
 
 @param cxClass class
 @param originalSel 源方法
 @param swizzledSel 替换方法
 */
+ (void)exchangeClassMethod:(Class _Nonnull )cxClass
                originalSel:(SEL _Nonnull )originalSel
                swizzledSel:(SEL _Nonnull )swizzledSel;

@end
