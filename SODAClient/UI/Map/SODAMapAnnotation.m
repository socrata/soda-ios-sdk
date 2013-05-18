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

#import "SODAMapAnnotation.h"
#import "SODALocation.h"


@implementation SODAMapAnnotation {

}

#pragma mark - Properties

@synthesize title = _title;
@synthesize subtitle = _subtitle;
@synthesize coordinate = _coordinate;
@synthesize location = _location;
@synthesize object = _object;

#pragma mark - Initializers

- (id)initWithObject:(id)object atLocation:(SODALocation *)location {
    self = [super init];
    if (self) {
        self.object = object;
        self.location = location;

        double latitude = [self.location.latitude doubleValue];
        double longitude = [self.location.longitude doubleValue];

        self.coordinate = CLLocationCoordinate2DMake(latitude, longitude);
    }

    return self;
}

+ (id)annotationWithObject:(id)object atLocation:(SODALocation *)location {
    return [[self alloc] initWithObject:object atLocation:location];
}


@end