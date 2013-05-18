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

#import "SODANSArrayUtils.h"


@implementation SODANSArrayUtils

+ (NSArray *)fromVarArgs:(id)firstObject, ... {
    NSMutableArray *result = [NSMutableArray array];
    id eachObject;
    va_list argumentList;
    if (firstObject) {
        [result addObject:firstObject];
        va_start(argumentList, firstObject);
        while ((eachObject = va_arg(argumentList, id)))
            [result addObject:eachObject];
        va_end(argumentList);
    }
    return result;
}

@end