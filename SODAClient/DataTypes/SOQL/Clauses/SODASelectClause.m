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

#import "SODASelectClause.h"

@implementation SODASelectClause {
}

#pragma mark - SODABuildCapable Impl

- (NSString *)build {
    NSMutableArray *built = [NSMutableArray array];
    for (SODASelectClause *selectable in self.expressions) {
        [built addObject:build(selectable)];
    }
    return [built count] == 0 ? @"select *" : [NSString stringWithFormat:@"select %@", [built componentsJoinedByString:@", "]];
}

@end

