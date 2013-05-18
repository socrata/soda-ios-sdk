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
#import "SODAGroupByClause.h"

@implementation SODAGroupByClause

#pragma mark - SODABuildCapable Impl

- (NSString *)build {
    return (self.expressions == nil || [self.expressions count] == 0)
            ? @""
            : [NSString stringWithFormat:@"group %@", [self.expressions componentsJoinedByString:@", "]];
}

@end