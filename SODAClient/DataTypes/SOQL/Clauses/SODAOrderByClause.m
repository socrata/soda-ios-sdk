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

#import "SODABuildCapable.h"
#import "SODAImmutableClause.h"
#import "SODAOrderByClause.h"


@implementation SODAOrderByClause

#pragma mark - SODABuildCapable Impl

- (NSString *)build {
    NSMutableArray *builtOrders = [NSMutableArray array];
    for (id order in self.expressions) {
        [builtOrders addObject:build(order)];
    }
    return [builtOrders count] == 0 ? @"" : [NSString stringWithFormat:@"order by %@", [builtOrders componentsJoinedByString:@", "]];
}

@end