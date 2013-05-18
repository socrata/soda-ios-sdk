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
#import <MapKit/MKAnnotation.h>
#import <CoreLocation/CLLocation.h>

@class SODALocation;

/**
* A Map view annotation for SODA serialized objects responses
*/
@interface SODAMapAnnotation : NSObject<MKAnnotation>

#pragma mark - Properties

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic, strong) id object;
@property (nonatomic, strong) SODALocation *location;

#pragma mark - Initializers

- (id)initWithObject:(id)object atLocation:(SODALocation *)location;

+ (id)annotationWithObject:(id)object atLocation:(SODALocation *)location;


@end