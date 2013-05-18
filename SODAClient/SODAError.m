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

#import "SODAError.h"


@implementation SODAError {

}

#pragma mark - Properties

@synthesize code = _code;
@synthesize message = _message;
@synthesize data = _data;

#pragma mark - Initializers

- (id)initWithCode:(NSString *)code message:(NSString *)message data:(NSDictionary *)data {
    self = [super init];
    if (self) {
        self.code = code;
        self.message = message;
        self.data = data;
    }

    return self;
}

+ (id)errorWithCode:(NSString *)code message:(NSString *)message data:(NSDictionary *)data {
    return [[self alloc] initWithCode:code message:message data:data];
}

@end