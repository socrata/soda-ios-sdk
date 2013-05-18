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
* Protocol implemented by clauses and expressions and anything that can be turned into a NSString when a query is asked to build itself
*/
@protocol SODABuildCapable <NSObject>

/**
* Builds an expression transforming it to a NSString
*/
- (NSString *)build;

@end

