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

#import "SODACallback.h"


@implementation SODACallback {

}

#pragma mark - Properties

@synthesize result = _result;

#pragma mark - Initializers

+ (SODACallback *)callbackWithResult:(ResultBlock)result  {
    SODACallback *call = [[SODACallback alloc] initWithResult:result];
    return call;
}

- (id)initWithResult:(ResultBlock)result  {
    self = [super init];
    if (self) {
        _result = result;
    }
    return self;
}

@end