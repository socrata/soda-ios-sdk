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

#import "SODADataTypeModel.h"
#import "SODADocument.h"
#import "SODALocation.h"
#import "SODAPhone.h"
#import "SODAUrl.h"


@implementation SODADataTypeModel {

}

#pragma mark - Properties

@synthesize percent = _percent;
@synthesize datetimewtimezone = _datetimewtimezone;
@synthesize plaintext = _plaintext;
@synthesize number = _number;
@synthesize linkeddataset = _linkeddataset;
@synthesize formattedtext = _formattedtext;
@synthesize money = _money;
@synthesize datetime = _datetime;
@synthesize phone = _phone;
@synthesize location = _location;
@synthesize star = _star;
@synthesize photo = _photo;
@synthesize url = _url;
@synthesize document = _document;
@synthesize multiplechoice = _multiplechoice;
@synthesize flag = _flag;
@synthesize email = _email;
@end