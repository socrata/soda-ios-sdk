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

#import "SODAPhone.h"


@implementation SODAPhone {
}

#pragma mark - Properties

@synthesize phoneNumber = _phoneNumber;
@synthesize phoneType = _phoneType;

#pragma mark - Initializers

- (id)initWithPhoneNumber:(NSString *)phoneNumber phoneType:(NSString *)phoneType {
    self = [super init];
    if (self) {
        self.phoneNumber = phoneNumber;
        self.phoneType = phoneType;
    }

    return self;
}

+ (id)phoneWithPhoneNumber:(NSString *)phoneNumber phoneType:(NSString *)phoneType {
    return [[self alloc] initWithPhoneNumber:phoneNumber phoneType:phoneType];
}

@end