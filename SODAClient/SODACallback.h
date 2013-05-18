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

@class SODAResponse;


typedef void (^ResultBlock)(SODAResponse *);

/**
 * Async callback that receives SODA API responses
 */
@interface SODACallback : NSObject {
    ResultBlock _result;
}

#pragma mark - Properties

@property(nonatomic, readonly) ResultBlock result;

#pragma mark - Initializers

+ (SODACallback *)callbackWithResult:(ResultBlock)result;

- (id)initWithResult:(ResultBlock)result;


@end