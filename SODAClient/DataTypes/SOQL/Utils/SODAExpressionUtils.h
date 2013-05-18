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

#define build(exp) [SODAExpressionUtils build:exp]

/**
* Internal Utility to build any object that be part of a query.
* Usually intended for NSString and SODABuildCapable implementers
*/
@interface SODAExpressionUtils : NSObject

/**
* Pass in any object to build it for a query
*/
+ (NSString *) build : (id) expression;

@end