//
//  CXProtectDemoTests.m
//  CXProtectDemoTests
//
//  Created by chuxiao on 2018/12/11.
//  Copyright © 2018年 chuxiao. All rights reserved.
//

#import <XCTest/XCTest.h>
#define SuppressPerformSelectorLeakWarning(Stuff) \
    do { \
        _Pragma("clang diagnostic push") \
        _Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
        Stuff; \
        _Pragma("clang diagnostic pop") \
    } while (0)


@interface CXProtectDemoTests : XCTestCase

@end

@implementation CXProtectDemoTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

/**
 array 防护
 */
- (void)testArrayProtect
{
    NSArray *array = @[];
    
    array[3];
    [array objectAtIndex:7];
}

/**
 MutableArray 防护
 */
- (void)testMutableArrayProtect
{
    NSString *string = nil;
    
    NSMutableArray *marray = @[@"a", @"b"].mutableCopy;
    NSMutableArray *marray2 = [NSMutableArray arrayWithObjects:string, nil];
    
    marray[3];
    [marray objectAtIndex:7];
    [marray addObject:string];
    [marray removeObjectAtIndex:7];
    [marray removeObject:@"c"];
    [marray insertObject:@"c" atIndex:7];
    [marray replaceObjectAtIndex:9 withObject:@"c"];
}

/**
 Dictionary 防护
 */
- (void)testDictionaryProtect
{
    NSString *string = nil;
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:string, string, nil];
    
    [dictionary objectForKey:string];
}

/**
 MutableDictionary 防护
 */
- (void)testMutableDictionaryProtect
{
    NSString *string = nil;
    
    NSMutableDictionary *mdictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:string, string, nil];
    
    [mdictionary objectForKey:string];
    [mdictionary setObject:string forKey:string];
    mdictionary[string] = string;
    [mdictionary removeObjectForKey:string];
}

/**
 String 防护
 */
- (void)testStringProtect
{
    NSString *string = @"chuxiao";
    
    [string rangeOfString:@"abc"];
    
    [string substringFromIndex:8];
    [string substringToIndex:8];
    [string substringWithRange:NSMakeRange(8, 8)];
}

/**
 MutableString 防护
 */
- (void)testMutableStringProtect
{
    NSString *string = @"chuxiao";
    
    [string rangeOfString:@"abc"];
    
    [string substringFromIndex:8];
    [string substringToIndex:8];
    [string substringWithRange:NSMakeRange(8, 8)];
}

- (void)testAttributedStringProtect
{
    NSString *string = nil;
    
    [[NSAttributedString alloc] initWithString:string];
    [[NSAttributedString alloc] initWithString:string attributes:nil];
}

/**
 unrecognized selector 防护
 
 包含实例方法以及类方法的防护
 */
- (void)testSelectorProtect
{
    SuppressPerformSelectorLeakWarning(
        [self performSelector:NSSelectorFromString(@"nonSelector")];
        [[self class] performSelector:NSSelectorFromString(@"nonSelector")];
    );
}

@end
