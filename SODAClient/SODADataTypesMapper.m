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

#import "SODADataTypesMapper.h"
#import "SODAPropertyMapping.h"


@implementation SODADataTypesMapper {

}

#pragma mark - Properties

@synthesize mappings = _mappings;

#pragma mark - Initializers

- (id)initWithMappings:(NSDictionary *)mappings {
    self = [super init];
    if (self) {
        self.mappings = mappings;
    }

    return self;
}

+ (id)mapperWithMappings:(NSDictionary *)mappings {
    return [[self alloc] initWithMappings:mappings];
}

#pragma mark - Mapping and Deserialization

- (void) mapColumns:(NSArray *) columns withTypes:(NSArray *) dataTypes inContainer:(id) JSON toObject:(id) object {
    NSDictionary *columnMappings = [NSDictionary dictionaryWithObjects:dataTypes forKeys:columns];
    for (id column in columns) {
        id dataType = [columnMappings objectForKey:column];
        id (^mappingBlock)(id) = [self.mappings objectForKey:dataType];
        id rawValue = [JSON objectForKey:column];
        id finalValue = (rawValue != nil && mappingBlock != nil) ? mappingBlock(rawValue) : rawValue;
        id targetProperty = [self propertyNameForKey:column inObject:object];
        if (targetProperty && [object respondsToSelector:NSSelectorFromString(targetProperty)])  {
            [object setValue:finalValue forKey:[self propertyNameForKey:column inObject:object]];
        }
    }
}

- (NSString *)propertyNameForKey:(NSString *)column inObject:(id)object {
    NSString *targetProperty = column;
    if ([object conformsToProtocol:@protocol(SODAPropertyMapping)]) {
        NSDictionary *mappings = [object performSelector:@selector(propertyMappings)];
        targetProperty = [mappings objectForKey:column];
    }
    return targetProperty;
}

@end