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

/**
* Internal Utility to build NSArray instances of out of Varargs in query macros
*/
@interface SODANSArrayUtils : NSObject

/**
* Given a variable list of arguments stuff them on a NSArray. useful for macro composition
*/
+ (NSArray *) fromVarArgs:(id) firstObject, ... NS_REQUIRES_NIL_TERMINATION;

@end