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

@class SODACallback;
@class SODAQuery;
@class AFHTTPClient;
@class SODADataTypesMapper;

/**
 * Consumer Client to the SODA API
 */
@interface SODAConsumer : NSObject {
    NSString *_domain;
    NSString *_token;
    SODADataTypesMapper *_dataTypeMapper;
}

#pragma mark - Properties

/**
* Domain this consumer is fetching data from
*/
@property(nonatomic, copy) NSString *domain;

/**
* The SODA API token for request authentication
*/
@property(nonatomic, copy) NSString *token;

/**
* A type mapper that will be used upon response serialization.
* Override or replace to provide your custom mappings
*/
@property(nonatomic, strong) SODADataTypesMapper *dataTypeMapper;

#pragma mark - Initializers

- (id)initWithDomain:(NSString *)domain token:(NSString *)token;

+ (id)consumerWithDomain:(NSString *)domain token:(NSString *)token;

#pragma mark - Async API Methods

/**
* Asynchronously fetches a single object from a remote dataset optionally mapping it to an object
*/
- (void)getObjectInDataset:(NSString *)dataset withId:(NSString *)id mappingTo:(Class)mapping result:(SODACallback *)callback;

/**
* Asynchronously fetches all remote dataset objects optionally mapping them to a resulting array where each element corresponds to the mapping result
*/
- (void)getObjectsInDataset:(NSString *)dataset mappingTo:(Class)mapping result:(SODACallback *)callback;

/**
* Asynchronously fetches all remote dataset objects matching a SOQL query expressed as a NSString optionally
* mapping the results to an array where each element corresponds to the mapping result parameter
*/
- (void)getObjectsInDataset:(NSString *)dataset forQuery:(NSString *)query mappingTo :(Class)mapping result:(SODACallback *)callback;

/**
* Asynchronously fetches all remote dataset objects matching a SOQL query expressed as a SODAQuery
* mapping the results to an array where each element corresponds to the mapping result parameter
*/
- (void)getObjectsForTypedQuery:(SODAQuery *)query result:(SODACallback *)callback;

/**
* Asynchronously fetches all remote dataset objects matching a full text query expressed as a NSString
* mapping the results to an array where each element corresponds to the mapping result parameter
*/
- (void)searchObjectsInDataset:(NSString *)dataset withKeywords:(NSString *) keywords mappingTo:(Class)mapping result:(SODACallback *)callback;

@end