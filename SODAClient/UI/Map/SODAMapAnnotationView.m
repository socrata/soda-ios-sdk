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

#import <MapKit/MapKit.h>
#import "SODAMapAnnotationView.h"


@implementation SODAMapAnnotationView {


}

#pragma mark - Initializers

- (id)initWithAnnotation:(id <MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImage *pinImage = [UIImage imageNamed:@"icn-default-marker"];
        if(pinImage) {
            self.image = pinImage;
        } else {
            self = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
        }
    }
    return self;
}

@end