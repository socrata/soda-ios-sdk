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

#import "SODALocation.h"


@implementation SODALocation {

}

#pragma mark - Properties

@synthesize needsRecoding = _needsRecoding;
@synthesize latitude = _latitude;
@synthesize longitude = _longitude;
@synthesize humanAddress = _humanAddress;

#pragma mark - Initializers

- (id)initWithLatitude:(NSNumber *)latitude longitude:(NSNumber *)longitude {
    self = [super init];
    if (self) {
        self.latitude = latitude;
        self.longitude = longitude;
    }

    return self;
}

+ (id)locationWithLatitude:(NSNumber *)latitude longitude:(NSNumber *)longitude {
    return [[self alloc] initWithLatitude:latitude longitude:longitude];
}

@end