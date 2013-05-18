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
#import <MapKit/MapKit.h>
#import "SODAMapViewController.h"
#import "SODAConsumer.h"
#import "SODAQuery.h"
#import "SODAMapAnnotation.h"
#import "SODAMapAnnotationView.h"
#import "SODACallback.h"
#import "SODAResponse.h"

@implementation SODAMapViewController {
    SODAQuery *query;
    SODAResponse *lastResponse;
}

@synthesize mapView = _mapView;
@synthesize consumer = _consumer;

#pragma mark - Initialization Methods

- (id)init {
    self = [super init];
    if (self) {
        self.mapView = [[MKMapView alloc] initWithFrame:self.view.frame];
        [self.mapView setDelegate:self];
        [self.view addSubview:self.mapView];
    }

    return self;
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self queryData];
}


#pragma mark - MKMapViewDelegate Methods

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    return [self viewForAnnotation:annotation];
}

- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated {

    // The map has moved, fetch new data
    [self queryData];

}

#pragma mark - Query Methods

- (void)queryData {

    // Make sure the consumer is initialized
    assert(self.consumer != nil);

    // Get the bounds of the mapview
    CGPoint nePoint = CGPointMake(self.mapView.bounds.origin.x + self.mapView.bounds.size.width, self.mapView.bounds.origin.y);
    CGPoint swPoint = CGPointMake((self.mapView.bounds.origin.x), (self.mapView.bounds.origin.y + self.mapView.bounds.size.height));

    CLLocationCoordinate2D neCoord = [self.mapView convertPoint:nePoint toCoordinateFromView:self.mapView];
    CLLocationCoordinate2D swCoord = [self.mapView convertPoint:swPoint toCoordinateFromView:self.mapView];

    SODAGeoBox *geoBox = [SODAGeoBox boxWithNorthEastCoordinate:neCoord southWestCoordinate:swCoord];

    // Get the query from the subclass
    query = [self queryForMapWithGeoBox:geoBox];

    // Call the consumer with the query
    [self.consumer getObjectsForTypedQuery:query result:[SODACallback callbackWithResult:^(SODAResponse *response) {

        lastResponse = response;

        // Check for errors
        if(response.error) {

            // TODO: How should we alert the user of errors? or should we provide a way for the caller to handle them?

        } else {
            // Get the data from the response and create annotations for each one
            NSArray *data = response.entity;
            for (int j = 0; j < data.count; j++) {
                SODAMapAnnotation *annotation = [self annotationForObject:[data objectAtIndex:j]];
                if(annotation != nil) {

                    // Make sure we haven't already added this annotation to the map
                    NSUInteger index = [self.mapView.annotations indexOfObjectPassingTest:
                            ^BOOL(SODAMapAnnotation *otherAnnotation, NSUInteger index, BOOL *stop) {
                                return (annotation.coordinate.latitude == otherAnnotation.coordinate.latitude &&
                                        annotation.coordinate.longitude == otherAnnotation.coordinate.longitude);
                            }];
                    if (index == NSNotFound) {
                        [self.mapView addAnnotation:annotation];
                    }


                }

            }


        }

    }]];
}

#pragma mark - Map Annotation View Methods

/**
* Override this method to create your own annotation view
*/
- (SODAMapAnnotationView *)viewForAnnotation:(SODAMapAnnotation *)annotation {

    static NSString *ident = @"SODAMapAnnotationViewPin";

    // Just use the default SODAMapAnnotationView, you can subclass it and use your own if you desire
    SODAMapAnnotationView * annotationView = (SODAMapAnnotationView *) [self.mapView dequeueReusableAnnotationViewWithIdentifier:ident];
    if (annotationView == nil) {
        annotationView = [[SODAMapAnnotationView alloc] initWithAnnotation:annotation
                                                           reuseIdentifier:ident];
    } else {
        annotationView.annotation = annotation;
    }

    annotationView.enabled = YES;
    annotationView.canShowCallout = YES;

    return annotationView;
}


#pragma mark - "Abstract" Methods

- (SODAQuery *)queryForMapWithGeoBox:(SODAGeoBox *)geoBox {
    // We don't do anything here, bail if the user hasn't overridden this method.
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in your subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}

- (SODAMapAnnotation *)annotationForObject:(id)object {
    // We don't do anything here, bail if the user hasn't overridden this method.
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in your subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}

@end