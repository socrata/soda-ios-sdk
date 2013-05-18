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

#import "SODAEarthquake.h"
#import "SODALocation.h"

/**
* Model class where SODA Response results get mapped for each one of the matching earthquakes
*/
@implementation SODAEarthquake {

}

#pragma mark - Properties

@synthesize region = _region;
@synthesize source = _source;
@synthesize location = _location;
@synthesize magnitude = _magnitude;
@synthesize numberOfStations = _numberOfStations;
@synthesize dateTime = _dateTime;
@synthesize earthQuakeId = _earthQuakeId;
@synthesize depth = _depth;
@synthesize version = _version;

#pragma mark - SODAPropertyMapping custom mappings impl

/**
* This custom mapping allows soda response properties to be mapped to object properties with names that do not match those on the
* remote objects
*/
- (NSDictionary *)propertyMappings {
    return @{
            @"region" : @"region",
            @"source" : @"source",
            @"location" : @"location",
            @"magnitude" : @"magnitude",
            @"number_of_stations" : @"numberOfStations",
            @"datetime" : @"dateTime",
            @"earthquake_id" : @"earthquakeId",
            @"depth" : @"depth",
            @"version" : @"version"
    };
}


@end