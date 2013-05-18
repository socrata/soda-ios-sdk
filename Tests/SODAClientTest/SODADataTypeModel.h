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

@class SODADocument;
@class SODALocation;
@class SODAPhone;
@class SODAUrl;

/**
* Test mapping object that contains all the known SODA custom datatypes
*/
@interface SODADataTypeModel : NSObject {
    NSNumber *_percent;
    NSDate *_datetimewtimezone;
    NSString *_plaintext;
    NSNumber *_number;
    NSNumber *_linkeddataset;
    NSString *_formattedtext;
    NSNumber *_money;
    NSDate *_datetime;
    SODAPhone *_phone;
    SODALocation *_location;
    NSNumber *_star;
    NSString *_photo;
    SODAUrl *_url;
    SODADocument *_document;
    NSString *_multiplechoice;
    NSString *_flag;
    NSString *_email;
}

#pragma mark - Properties

@property(nonatomic, strong) NSNumber *percent;
@property(nonatomic, strong) NSDate *datetimewtimezone;
@property(nonatomic, copy) NSString *plaintext;
@property(nonatomic, strong) NSNumber *number;
@property(nonatomic, strong) NSNumber *linkeddataset;
@property(nonatomic, copy) NSString *formattedtext;
@property(nonatomic, strong) NSNumber *money;
@property(nonatomic, strong) NSDate *datetime;
@property(nonatomic, strong) SODAPhone *phone;
@property(nonatomic, strong) SODALocation *location;
@property(nonatomic, strong) NSNumber *star;
@property(nonatomic, copy) NSString *photo;
@property(nonatomic, strong) SODAUrl *url;
@property(nonatomic, strong) SODADocument *document;
@property(nonatomic, copy) NSString *multiplechoice;
@property(nonatomic, copy) NSString *flag;
@property(nonatomic, copy) NSString *email;


@end