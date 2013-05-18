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
 * Protocol to be implemented by model classes whose properties do not match the same names as the ones returned by SODA
 * response results
 */
@protocol SODAPropertyMapping <NSObject>

- (NSDictionary *) propertyMappings;

@end