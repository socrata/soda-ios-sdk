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
#import "SODAImmutableClause.h"

/**
* Represents a 'select' clause on a SODA Query e.g. 'select a, b, c'
*/
@interface SODASelectClause : SODAImmutableClause <SODABuildCapable>
@end






