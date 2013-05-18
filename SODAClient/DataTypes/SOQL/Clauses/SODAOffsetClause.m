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

#import "SODAOffsetClause.h"


@implementation SODAOffsetClause {

}

#pragma mark - Properties

@synthesize offset = _offset;

#pragma mark - Initializers

- (id)initWithOffset:(NSNumber *)offset {
    self = [super init];
    if (self) {
        self.offset = offset;
    }

    return self;
}

+ (id)offset:(NSNumber *)offset {
    return [[self alloc] initWithOffset:offset];
}

#pragma mark - SODABuildCapable Impl

- (NSString *)build {
    return (self.offset != nil)
            ? [NSString stringWithFormat:@"offset %@", self.offset]
            : @"";
}


@end