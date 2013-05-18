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
* Represents a 'offset' clause on a SODA Query e.g. 'offset 10'
*/
@interface SODAOffsetClause : NSObject<SODABuildCapable> {
    NSNumber *_offset;
}

#pragma mark - Properties

/**
* The offset
*/
@property(nonatomic, strong) NSNumber *offset;

#pragma mark - Initializers

/**
* Default initializer that creates an offset clause given an number
*/
- (id)initWithOffset:(NSNumber *)offset;

/**
* Factory method
*/
+ (id)offset:(NSNumber *)offset;


@end