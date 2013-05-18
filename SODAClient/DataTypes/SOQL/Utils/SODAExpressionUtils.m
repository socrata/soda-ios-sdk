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

#import "SODAExpressionUtils.h"
#import "SODABuildCapable.h"


@implementation SODAExpressionUtils {

}

+ (NSString *)build:(id) expression {
    return [expression conformsToProtocol:@protocol(SODABuildCapable)]
            ? [expression performSelector:@selector(build)]
            : [expression description];
}


@end