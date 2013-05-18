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
 * Class that encapsulates information about a SODA API response error
 */
@interface SODAError : NSObject {
    NSString *_code;
    NSString *_message;
    NSDictionary *_data;
}

#pragma mark - Properties

@property(nonatomic, copy) NSString *code;
@property(nonatomic, copy) NSString *message;
@property(nonatomic, strong) NSDictionary *data;

#pragma mark - Initializers

- (id)initWithCode:(NSString *)code message:(NSString *)message data:(NSDictionary *)data;

+ (id)errorWithCode:(NSString *)code message:(NSString *)message data:(NSDictionary *)data;

@end