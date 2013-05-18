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

#import "SODAMapViewController.h"
#import "SODAEarthquakeMapViewController.h"
#import "SODAQuery.h"
#import "SODAMapAnnotation.h"
#import "SODAEarthquake.h"
#import "SODAConsumer.h"

/**
* Sample View controller that displays earthquake information on a Map using the iOS SODA client SDK
*/
@implementation SODAEarthquakeMapViewController {

}

- (id)init {
    self = [super init];
    if (self) {
        self.navigationItem.title = @"Earthquake Map View";

        self.consumer = [SODAConsumer consumerWithDomain:@"demo.socrata.com" token:nil];
    }
    return self;
}

/**
* Invoked each time the maps moves around
*/
- (SODAQuery *)queryForMapWithGeoBox:(SODAGeoBox *)geoBox{

    SODAQuery *query = [[SODAQuery alloc] initWithDataset:@"earthquakes" mapping:[SODAEarthquake class]];
    [query where:@"magnitude" greatherThan:@2];
//    [query where:@"location" withinBox:geoBox];

    return query;
}

/**
* Invoked for each serialized object on a SODA response
*/
- (SODAMapAnnotation *)annotationForObject:(SODAEarthquake *) earthquake {

    SODAMapAnnotation *annotation = [SODAMapAnnotation annotationWithObject:earthquake atLocation:earthquake.location];
    annotation.title = earthquake.region;
    annotation.subtitle = [NSString stringWithFormat:@"Magnitude: %.2f, Depth: %.2f", [earthquake.magnitude doubleValue], [earthquake.depth doubleValue]];

    return annotation;
}

@end