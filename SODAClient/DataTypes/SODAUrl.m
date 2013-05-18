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

#import "SODAUrl.h"


@implementation SODAUrl {

}
#pragma mark - Properties

@synthesize url = _url;
@synthesize description = _description;

#pragma mark - Initializers

- (id)initWithUrl:(NSString *)url {
    self = [super init];
    if (self) {
        self.url = url;
    }

    return self;
}

+ (id)urlWithUrl:(NSString *)url {
    return [[self alloc] initWithUrl:url];
}

@end