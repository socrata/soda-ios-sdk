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

#import "SODAWhereClause.h"
#import "SODAExpression.h"


@implementation SODAWhereClause

#pragma mark - SODABuildCapable Impl

- (NSString *)build {
    NSMutableArray *built = [NSMutableArray array];
    for (id<SODABuildCapable> ob in self.expressions) {
        [built addObject:build(ob)];
    }
    return ([built count] == 0)
            ? @""
            : [NSString stringWithFormat:@"where %@", build([SODAExpression and:built])];
}


@end