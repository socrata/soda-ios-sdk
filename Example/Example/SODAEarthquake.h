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
#import "SODAPropertyMapping.h"

@class SODALocation;

/**
* Model class where SODA Response results get mapped for each one of the matching earthquakes
*/
@interface SODAEarthquake : NSObject<SODAPropertyMapping> {
    NSString *_region;
    NSString *_source;
    SODALocation *_location;
    NSNumber *_magnitude;
    NSNumber *_numberOfStations;
    NSDate *_dateTime;
    NSString *_earthQuakeId;
    NSNumber *_depth;
    NSString *_version;
}

#pragma mark - Properties

@property(nonatomic, copy) NSString *region;
@property(nonatomic, copy) NSString *source;
@property(nonatomic, strong) SODALocation *location;
@property(nonatomic, strong) NSNumber *magnitude;
@property(nonatomic, strong) NSNumber *numberOfStations;
@property(nonatomic, strong) NSDate *dateTime;
@property(nonatomic, copy) NSString *earthQuakeId;
@property(nonatomic, strong) NSNumber *depth;
@property(nonatomic, copy) NSString *version;


@end