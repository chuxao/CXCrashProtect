//
//  NSMutableArray+Protect.m
//  CXProtect
//
//  Created by chuxiao on 2018/5/21.
//  Copyright © 2018年 CXProtect. All rights reserved.
//

#import "NSMutableArray+CXProtect.h"
#import "NSObject+Protect.h"
#import "NSException+CXProtectLog.h"

@implementation NSMutableArray (CXProtect)

+ (void)setupMutableArrayProtect
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
    
//        Class __NSArray = objc_getClass("NSArray");
        Class __NSArrayM = NSClassFromString(@"__NSArrayM");
//        Class __NSPlaceholderArray = objc_getClass("__NSPlaceholderArray");
        
        // objectAtIndex:
        [self exchangeInstanceMethod:__NSArrayM originalSel:@selector(objectAtIndex:) swizzledSel:@selector(cx_objectAtIndex:)];
        
        // @[]
        [self exchangeInstanceMethod:__NSArrayM originalSel:@selector(objectAtIndexedSubscript:) swizzledSel:@selector(cx_objectAtIndexedSubscript:)];
        
        // insert
        [self exchangeInstanceMethod:__NSArrayM originalSel:@selector(insertObject:atIndex:) swizzledSel:@selector(cx_insertObject:atIndex:)];
        
        // remove
        [self exchangeInstanceMethod:__NSArrayM originalSel:@selector(removeObjectAtIndex:) swizzledSel:@selector(cx_removeObjectAtIndex:)];
        
        // setObject
        [self exchangeInstanceMethod:__NSArrayM originalSel:@selector(setObject:atIndexedSubscript:) swizzledSel:@selector(cx_setObject:atIndexedSubscript:)];
        
        // getObjects:range:防护
        [self exchangeInstanceMethod:__NSArrayM originalSel:@selector(getObjects:range:) swizzledSel:@selector(cx_getObjects:range:)];
        
        // replace
        [self exchangeInstanceMethod:__NSArrayM originalSel:@selector(replaceObjectAtIndex:withObject:) swizzledSel:@selector(cx_replaceObjectAtIndex:withObject:)];
        
    });
}

#pragma mark - new methonds

- (id)cx_objectAtIndex:(NSUInteger)index {
    id object = nil;
    @try {
        object = [self cx_objectAtIndex:index];
    }
    @catch (NSException *exception) {
        [exception print];
    }
    @finally {
        return object;
    }
}

- (id)cx_objectAtIndexedSubscript:(NSUInteger)index {
    id object = nil;
    @try {
        object = [self cx_objectAtIndex:index];
    }
    @catch (NSException *exception) {
        [exception print];
    }
    @finally {
        return object;
    }
}

- (void)cx_insertObject:(id)anObject atIndex:(NSUInteger)index {
    @try {
        [self cx_insertObject:anObject atIndex:index];
    }
    @catch (NSException *exception) {
        [exception print];
    }
    @finally {
    }
}

- (void)cx_removeObjectAtIndex:(NSUInteger)index {
    @try {
        [self cx_removeObjectAtIndex:index];
    }
    @catch (NSException *exception) {
        [exception print];
    }
    @finally {
    }
}

- (void)cx_setObject:(id)obj atIndexedSubscript:(NSUInteger)idx {
    @try {
        [self cx_setObject:obj atIndexedSubscript:idx];
    }
    @catch (NSException *exception) {
        [exception print];
    }
    @finally {
    }
}

- (void)cx_getObjects:(__unsafe_unretained id  _Nonnull *)objects range:(NSRange)range {
    @try {
        [self cx_getObjects:objects range:range];
    } @catch (NSException *exception) {
        [exception print];
    } @finally {
    }
}

- (void)cx_replaceObjectAtIndex:(NSUInteger)index withObject:(id)obj {
    @try {
        [self cx_replaceObjectAtIndex:index withObject:obj];
    } @catch (NSException *exception) {
        [exception print];
    } @finally {
    }
}

@end
