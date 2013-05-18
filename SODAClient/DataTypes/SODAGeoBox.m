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

#import <CoreLocation/CoreLocation.h>
#import "SODAGeoBox.h"


@implementation SODAGeoBox {

}

#pragma mark - Properties

@synthesize north = _north;
@synthesize east = _east;
@synthesize west = _west;
@synthesize south = _south;

#pragma mark - Initializers

- (id)initWithNorth:(NSNumber *)north east:(NSNumber *)east south:(NSNumber *)south west:(NSNumber *)west {
    self = [super init];
    if (self) {
        self.north = north;
        self.east = east;
        self.south = south;
        self.west = west;
    }

    return self;
}

+ (SODAGeoBox *) boxWithNorth:(NSNumber *)north east:(NSNumber *)east south:(NSNumber *)south west:(NSNumber *)west {
    return [[self alloc] initWithNorth:north east:east south:south west:west];
}

+ (SODAGeoBox *)boxWithNorthEastCoordinate:(CLLocationCoordinate2D)neCoordinate southWestCoordinate:(CLLocationCoordinate2D)swCoordinate {
    return [SODAGeoBox boxWithNorth:@(neCoordinate.latitude)
                               east:@(neCoordinate.longitude)
                              south:@(swCoordinate.latitude)
                               west:@(swCoordinate.longitude)];
}


@end