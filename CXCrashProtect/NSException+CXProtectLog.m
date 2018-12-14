//
//  NSException+CXProtectLog.m
//  CXProtect
//
//  Created by chuxiao on 2018/5/23.
//  Copyright © 2018年 CXProtect. All rights reserved.
//

#import "NSException+CXProtectLog.h"


@implementation NSException (CXProtectLog)

- (void)print
{
    NSString *exceName = self.name;
    NSString *exceReason = self.reason;
    
    [NSException _printWithName:exceName message:exceReason trackEvent:nil];
}

- (void)printWithTrackEvent:(NSString *)eventName
{
    [NSException _printWithName:self.name message:self.reason trackEvent:eventName];
}

+ (void)printWithMessage:(NSString *)message
{
    [self _printWithName:@"" message:message trackEvent:nil];
}

+ (void)printWithMessage:(NSString *)message trackEvent:(NSString *)eventName
{
    [self _printWithName:nil message:message trackEvent:eventName];
}

+ (void)_printWithName:(NSString *)name message:(NSString *)message trackEvent:(NSString *)eventName
{
    // 堆栈数据
    NSArray *callStackSymbols = [NSThread callStackSymbols];
    
    NSString *callStackSymbol = [NSException _getMainCallStackSymbol:callStackSymbols];
    
    /**
     [Firebase/Analytics][I-ACS013000]....... The maximum supported length is 100
     */
    if (callStackSymbol && callStackSymbol.length > 100) {
        callStackSymbol = [callStackSymbol substringToIndex:100];
    }
    
    /**
     打点
     *新功能：忽略系统方法报错拦截*
     errorMsg 可传入 exceReason，描述更加准确
     */
    if (callStackSymbol) {
        
        NSLog(@">>>>>>>>>>Exception: %@ \n %@<<<<<<<<<<", message, callStackSymbol);
    }
    
}

+ (NSString *)_getMainCallStackSymbol:(NSArray <NSString *>*)callStackSymbols
{
    NSString *mainCallStackSymbol = @"";
    
    /**
     正则匹配：实例方法或者类方法
     匹配 [ ] 使用 \\[和\\] 有点奇怪
     */
    NSString *regular = @"[-+]\\[.*\\]";
    
    // 忽略大小写匹配
    NSRegularExpression *re = [[NSRegularExpression alloc] initWithPattern:regular options:NSRegularExpressionCaseInsensitive error:nil];
    
    int count = 0;
    
    for (NSString *callStackSymbol in callStackSymbols) {
        /**
         NSRangeFromString难道不等同于NSMakeRange？
         */
        NSTextCheckingResult *match = [re firstMatchInString:callStackSymbol options:0 range:NSMakeRange(0, callStackSymbol.length)];
        if (match) {
            // 截获特定的字符串
            NSString *result = [callStackSymbol substringWithRange:match.range];
            if (!result) continue;
                
            NSString *prefixResult = [result componentsSeparatedByString:@" "].firstObject;
            if (!prefixResult) continue;
            
            NSString *className = [prefixResult componentsSeparatedByString:@"["].lastObject;
            if (!className) continue;
            
            // 撇除系统的方法以及防护方法
            if ([NSBundle bundleForClass:NSClassFromString(className)] == [NSBundle mainBundle]) {
                if (![prefixResult hasSuffix:@")"]) {
                    
                    mainCallStackSymbol = [NSString stringWithFormat:@"%@%@",mainCallStackSymbol,result];
                    count ++;
                    
                    if (count == 3) {
                        break;
                    }else {
                        mainCallStackSymbol = [NSString stringWithFormat:@"%@\n",mainCallStackSymbol];
                    }
                }
            }
        }
        
        
        /**
         如下遍历也是可以的
         */
        /**
        [re enumerateMatchesInString:callStackSymbol options:NSMatchingReportProgress range:NSMakeRange(0, callStackSymbol.length) usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {

            if (result) {
                NSString *string = [callStackSymbol substringWithRange:result.range];
                NSLog_G(@"-------%@",string);
                *stop = YES;
            }

        }];
         */
    }
    
    return mainCallStackSymbol;
}



@end
