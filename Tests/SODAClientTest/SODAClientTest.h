//
//  SODA iOS SDK - Socrata, Inc
//
//  Copyright (C) 2013 Socrata, Inc
//  All rights reserved.
//
//  Developed for Socrata, Inc by:
//  47 Degrees, LLC
//  http://47deg.com
//  hello@47deg.com
//

#import <SenTestingKit/SenTestingKit.h>
#import "SODAQuery.h"

#define SODAssertExpression(v, e) STAssertEqualObjects(v, build(e), @"Malformed expression")

enum {
    SenAsyncTestCaseStatusUnknown = 0,
    SenAsyncTestCaseStatusWaiting,
    SenAsyncTestCaseStatusSucceeded,
    SenAsyncTestCaseStatusFailed,
    SenAsyncTestCaseStatusCancelled,
};

typedef NSUInteger SenAsyncTestCaseStatus;

/**
* SODA Query building and main test with async callback support
*/
@interface SODAClientTest : SenTestCase

#pragma mark - Async test helpers

- (void)waitForStatus:(SenAsyncTestCaseStatus)status timeout:(NSTimeInterval)timeout;
- (void)waitForTimeout:(NSTimeInterval)timeout;
- (void)notify:(SenAsyncTestCaseStatus)status;

@end
