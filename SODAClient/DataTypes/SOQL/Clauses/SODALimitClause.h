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

#import <Foundation/Foundation.h>
#import "SODABuildCapable.h"

/**
* Represents a 'limit' clause on a SODA Query e.g. 'limit 10'
*/
@interface SODALimitClause : NSObject<SODABuildCapable> {
    NSNumber *_limit;
}

#pragma mark - Properties

/**
* The limit
*/
@property(nonatomic, strong) NSNumber *limit;

#pragma mark - Initializers

/**
* Default initializer with a number
*/
- (id)initWithLimit:(NSNumber *)limit;

/**
* Factory method
*/
+ (id)limit:(NSNumber *)limit;

@end