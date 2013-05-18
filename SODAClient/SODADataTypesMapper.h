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

/**
 * Service that serializes and maps SODA responses to model classes based on the returned SODA fields and dataTypes headers.
 * The mappings dictionary is composed by NSString keys that match the data types and blocks such as  ^(id value) { return transformedValue; }
 * is in charge of the mapping work transforming the automatic serialized JSON objects to the target NSObject container properties.
 */
@interface SODADataTypesMapper : NSObject {
    NSDictionary *_mappings;
}

#pragma mark - Properties

@property(nonatomic, strong) NSDictionary *mappings;

#pragma mark - Initializers

- (id)initWithMappings:(NSDictionary *)mappings;

+ (id)mapperWithMappings:(NSDictionary *)mappings;

#pragma mark - Mapping and Deserialization

- (NSString *)propertyNameForKey:(NSString *)column inObject:(id)object;

- (void)mapColumns:(NSArray *)columns withTypes:(NSArray *)dataTypes inContainer:(id)JSON toObject:(id)object;


@end