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
#import "SODAImmutableClause.h"

/**
* Type definition for 'asc' or 'desc' order
*/
typedef enum {
    kAscending,
    kDescending
} OrderDirection;

/**
* Represents a 'order' clause on a SODA Query e.g. 'order a desc, b asc'
*/
@interface SODAOrderByClause : SODAImmutableClause <SODABuildCapable>
@end