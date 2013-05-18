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
#import <MapKit/MKMapView.h>

@class SODAConsumer;
@class SODAQuery;
@class SODAMapAnnotation;
@class SODAMapAnnotationView;
@class SODAGeoBox;


@interface SODAMapViewController : UIViewController<MKMapViewDelegate>

@property (strong, nonatomic) MKMapView *mapView;
@property (strong, nonatomic) SODAConsumer *consumer;

#pragma mark - "Abstract" Methods

- (SODAQuery *)queryForMapWithGeoBox:(SODAGeoBox *)geoBox;

- (SODAMapAnnotation *)annotationForObject:(id)object;

#pragma mark - Map Annotation View Methods

- (SODAMapAnnotationView *)viewForAnnotation:(SODAMapAnnotation *)annotation;

@end