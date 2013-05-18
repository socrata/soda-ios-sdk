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
* A SODA specific datatype that represents a location for geo queries
*/
@interface SODALocation : NSObject {
    BOOL _needsRecoding;
    NSNumber *_latitude;
    NSNumber *_longitude;
    NSString *_humanAddress;
}

#pragma mark - Properties

@property(nonatomic) BOOL needsRecoding;
@property(nonatomic, strong) NSNumber *latitude;
@property(nonatomic, strong) NSNumber *longitude;
@property(nonatomic, copy) NSString *humanAddress;

#pragma mark - Initializers

- (id)initWithLatitude:(NSNumber *)latitude longitude:(NSNumber *)longitude;

+ (id)locationWithLatitude:(NSNumber *)latitude longitude:(NSNumber *)longitude;


@end