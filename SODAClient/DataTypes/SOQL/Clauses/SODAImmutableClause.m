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

@implementation SODAImmutableClause {

}

#pragma mark - Properties

@synthesize expressions = _expressions;

#pragma mark - Initializers

- (id)initWithExpressions:(NSArray *)expressions {
    self = [super init];
    if (self) {
        self.expressions = expressions;
    }

    return self;
}

+ (id)clauseWithExpressions:(NSArray *)expressions {
    return [[self alloc] initWithExpressions:expressions];
}

#pragma mark - Builders

- (id)append:(NSArray *)expressions {
    return [self initWithExpressions:[self.expressions arrayByAddingObjectsFromArray:expressions]];
}

@end