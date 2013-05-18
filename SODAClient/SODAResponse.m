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

#import "SODAResponse.h"
#import "SODAError.h"


@implementation SODAResponse {

}

#pragma mark - Properties

@synthesize status = _status;
@synthesize headers = _headers;
@synthesize hasEntity = _hasEntity;
@synthesize entity = _entity;
@synthesize error = _error;
@synthesize hasError = _hasError;
@synthesize json = _json;

@end