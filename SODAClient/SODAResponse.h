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

@class SODAError;

/**
 * Encapsulates all information available in the SODA API Response including
 * status, errors, json response, headers and serialized model entities.
 */
@interface SODAResponse : NSObject {
    NSNumber *_status;
    NSDictionary *_headers;
    BOOL _hasEntity;
    BOOL _hasError;
    id _entity;
    SODAError *_error;
    id _json;
}

#pragma mark - Properties

@property(nonatomic, strong) NSNumber *status;
@property(nonatomic, strong) NSDictionary *headers;
@property(nonatomic) BOOL hasEntity;
@property(nonatomic, strong) id entity;
@property(nonatomic) BOOL hasError;
@property(nonatomic, strong) SODAError *error;
@property(nonatomic, strong) id json;

@end