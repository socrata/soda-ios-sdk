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
#import <CoreLocation/CoreLocation.h>

/**
* A SODA specific client side datatype that represents a bounding box of coordinates NE, SW
*/
@interface SODAGeoBox : NSObject {
    NSNumber *_north;
    NSNumber *_east;
    NSNumber *_south;
    NSNumber *_west;
}

#pragma mark - Properties

@property(nonatomic, strong) NSNumber *north;
@property(nonatomic, strong) NSNumber *east;
@property(nonatomic, strong) NSNumber *south;
@property(nonatomic, strong) NSNumber *west;

#pragma mark - Initializers

- (id)initWithNorth:(NSNumber *)north east:(NSNumber *)east south:(NSNumber *)south west:(NSNumber *)west;

+ (SODAGeoBox *)boxWithNorth:(NSNumber *)north east:(NSNumber *)east south:(NSNumber *)south west:(NSNumber *)west;

+ (SODAGeoBox *)boxWithNorthEastCoordinate:(CLLocationCoordinate2D)neCoordinate southWestCoordinate:(CLLocationCoordinate2D)swCoordinate;


@end