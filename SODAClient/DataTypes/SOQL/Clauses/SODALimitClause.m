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

#import "SODALimitClause.h"


@implementation SODALimitClause {

}

#pragma mark - Properties

@synthesize limit = _limit;

#pragma mark - Initializers

- (id)initWithLimit:(NSNumber *)limit {
    self = [super init];
    if (self) {
        _limit = limit;
    }

    return self;
}

+ (id)limit:(NSNumber *)limit {
    return [[self alloc] initWithLimit:limit];
}

#pragma mark - SODABuildCapable Impl

- (NSString *)build {
    return (self.limit != nil)
            ? [NSString stringWithFormat:@"limit %@", self.limit]
            : @"";
}

@end