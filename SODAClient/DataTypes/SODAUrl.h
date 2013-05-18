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
* A SODA specific datatype that represents a url
*/
@interface SODAUrl : NSObject {
    NSString *_url;
    NSString *_description;
}

#pragma mark - Properties

@property(nonatomic, copy) NSString *url;
@property(nonatomic, copy) NSString *description;

#pragma mark - Initializers

- (id)initWithUrl:(NSString *)url;

+ (id)urlWithUrl:(NSString *)url;


@end