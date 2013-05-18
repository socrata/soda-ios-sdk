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
* A SODA specific datatype that represents a phone number
*/
@interface SODAPhone : NSObject {
    NSString *_phoneNumber;
    NSString *_phoneType;
}

#pragma mark - Properties

@property(nonatomic, copy) NSString *phoneNumber;
@property(nonatomic, copy) NSString *phoneType;


#pragma mark - Initializers

- (id)initWithPhoneNumber:(NSString *)phoneNumber phoneType:(NSString *)phoneType;

+ (id)phoneWithPhoneNumber:(NSString *)phoneNumber phoneType:(NSString *)phoneType;


@end