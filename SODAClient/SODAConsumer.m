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

#import "SODAConsumer.h"
#import "SODACallback.h"
#import "SODAQuery.h"
#import "SODAResponse.h"
#import "AFHTTPClient.h"
#import "AFJSONRequestOperation.h"
#import "SODADataTypesMapper.h"
#import "SODAError.h"
#import "SODAPhone.h"
#import "SODALocation.h"
#import "SODAUrl.h"
#import "SODADocument.h"

#pragma mark - Private

@interface SODAConsumer ()

- (void)performRequestForUrl:(NSString *)relativePath responseMapping:(Class)mapping resultCallback:(SODACallback *)callback;

- (SODAResponse *)parseResponse:(NSHTTPURLResponse *)response request:(NSURLRequest *)request json:(id)JSON responseMapping:(Class)mapping;

@end

#pragma mark - Impl

@implementation SODAConsumer {
    AFHTTPClient *_httpCLient;
}

#pragma mark - Properties

@synthesize domain = _domain;
@synthesize token = _token;
@synthesize dataTypeMapper = _dataTypeMapper;

#pragma mark - Initializers

- (id)initWithDomain:(NSString *)domain token:(NSString *)token {
    self = [super init];
    if (self) {
        self.domain = domain;
        self.token = token;
        _httpCLient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://%@", self.domain]]];
        [_httpCLient setParameterEncoding:AFJSONParameterEncoding];
        self.dataTypeMapper = [SODADataTypesMapper mapperWithMappings:@{
                @"percent" : ^(id value) {
                    return [[[NSNumberFormatter alloc] init] numberFromString:value];
                },
                @"datetimewtimezone" : ^(id value) {
                    return [NSDate dateWithTimeIntervalSince1970:[value doubleValue]];
                },
                @"plaintext" : ^(id value) {
                    return [value description];
                },
                @"number" : ^(id value) {
                    return [[[NSNumberFormatter alloc] init] numberFromString:value];
                },
                @"linkeddataset" : ^(id value) {
                    return [[[NSNumberFormatter alloc] init] numberFromString:value];
                },
                @"formattedtext" : ^(id value) {
                    return [value description];
                },
                @"money" : ^(id value) {
                    return [[[NSNumberFormatter alloc] init] numberFromString:value];
                },
                @"datetime" : ^(id value) {
                    NSDateFormatter *dateReader = [[NSDateFormatter alloc] init];
                    [dateReader setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
                    return [dateReader dateFromString:[value description]];
                },
                @"phone" : ^(id value) {
                    return [SODAPhone phoneWithPhoneNumber:[value objectForKey:@"phone_number"]
                                                 phoneType:[value objectForKey:@"phone_type"]];
                },
                @"location" : ^(id value) {
                    NSNumber *latitude = [[[NSNumberFormatter alloc] init] numberFromString:[value objectForKey:@"latitude"]];
                    NSNumber *longitude = [[[NSNumberFormatter alloc] init] numberFromString:[value objectForKey:@"longitude"]];
                    SODALocation *location = [SODALocation locationWithLatitude:latitude longitude:longitude];
                    location.humanAddress = [value objectForKey:@"human_address"];
                    location.needsRecoding = [value objectForKey:@"needs_recoding"] != nil ? [[value objectForKey:@"needs_recoding"] boolValue] : NO;
                    return location;
                },
                @"start" : ^(id value) {
                    return value;
                },
                @"photo" : ^(id value) {
                    return [value description];
                },
                @"url" : ^(id value) {
                    SODAUrl *url = [SODAUrl urlWithUrl:[value objectForKey:@"url"]];
                    url.description = [value objectForKey:@"description"];
                    return url;
                },
                @"document" : ^(id value) {
                    return  [SODADocument documentWithFileId:[value objectForKey:@"file_id"] fileName:[value objectForKey:@"filename"]];
                },
                @"multiplechoice" : ^(id value) {
                    return [value description];
                },
                @"flag" : ^(id value) {
                    return [value description];
                },
                @"checkbox" : ^(id value) {
                    return value;
                },
                @"__defaultMapping__" : ^(id value) {
                    return value;
                }
        }];
    }

    return self;
}

+ (id)consumerWithDomain:(NSString *)domain token:(NSString *)token {
    return [[self alloc] initWithDomain:domain token:token];
}

#pragma mark - Async API Methods

- (void)getObjectInDataset:(NSString *)dataset withId:(NSString *)id mappingTo:(Class)mapping result:(SODACallback *)callback {
    [self performRequestForUrl:[NSString stringWithFormat:@"resource/%@/%@.json", dataset, id] responseMapping:mapping resultCallback:callback];
}

- (void)getObjectsInDataset:(NSString *)dataset mappingTo:(Class)mapping result:(SODACallback *)callback {
    [self performRequestForUrl:[NSString stringWithFormat:@"resource/%@.json", dataset] responseMapping:mapping resultCallback:callback];
}

- (void)getObjectsInDataset:(NSString *)dataset forQuery:(NSString *)query mappingTo:(Class)mapping result:(SODACallback *)callback {
    [self performRequestForUrl:[NSString stringWithFormat:@"resource/%@.json?$query=%@", dataset, [query stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] responseMapping:mapping resultCallback:callback];
}

- (void)getObjectsForTypedQuery:(SODAQuery *)query result:(SODACallback *)callback {
    [self getObjectsInDataset:query.dataset forQuery:[query build] mappingTo:query.mapping result:callback];
}

- (void)searchObjectsInDataset:(NSString *)dataset withKeywords:(NSString *)keywords mappingTo:(Class)mapping result:(SODACallback *)callback {
    [self performRequestForUrl:[NSString stringWithFormat:@"resource/%@.json$q=%@", dataset, [keywords stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] responseMapping:mapping resultCallback:callback];
}


#pragma mark - Helpers

- (void)performRequestForUrl:(NSString *)relativePath responseMapping:(Class)mapping resultCallback:(SODACallback *)callback {
    NSMutableURLRequest *request = [_httpCLient requestWithMethod:@"GET" path:relativePath parameters:nil];
    if (self.token != nil) {
        [request setValue:self.token forHTTPHeaderField:@"X-App-Token"];
    }
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *successRequest, NSHTTPURLResponse *response, id JSON) {
        SODAResponse *sodResponse = [self parseResponse:response request:successRequest json:JSON responseMapping:mapping];
        callback.result(sodResponse);
    } failure:^(NSURLRequest *failedRequest, NSHTTPURLResponse *response, NSError *error, id JSON) {
        SODAResponse *sodResponse = [self parseResponse:response request:failedRequest json:JSON responseMapping:mapping];
        callback.result(sodResponse);
    }];
    [operation start];
}

- (SODAResponse *)parseResponse:(NSHTTPURLResponse *)response request:(NSURLRequest *)request json :(id)JSON responseMapping:(Class)mapping {
    SODAResponse *sodResponse = [[SODAResponse alloc] init];
    sodResponse.status = [NSNumber numberWithInteger:response.statusCode];
    sodResponse.json = JSON;
    sodResponse.headers = response.allHeaderFields;
    if (mapping != nil && [sodResponse.status isEqualToNumber:@200]) {
        id object = nil;
        NSString *columnsJson = [sodResponse.headers objectForKey:@"X-SODA2-Fields"];
        NSString *datatypesJson = [sodResponse.headers objectForKey:@"X-SODA2-Types"];
        NSArray *columns = [NSJSONSerialization JSONObjectWithData:[columnsJson dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
        NSArray *dataTypes = [NSJSONSerialization JSONObjectWithData:[datatypesJson dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
        BOOL isArray = [JSON isKindOfClass:[NSArray class]];
        if (isArray) {
            NSMutableArray *results = [NSMutableArray array];
            for (id record in JSON) {
                id result = [[mapping alloc] init];
                [self.dataTypeMapper mapColumns:columns withTypes:dataTypes inContainer:record toObject:result];
                [results addObject:result];
            }
            object = results;
        } else {
            object = [[mapping alloc] init];
            [self.dataTypeMapper mapColumns:columns withTypes:dataTypes inContainer:JSON toObject:object];

        }
        sodResponse.entity = object;
    }
    if (!(response.statusCode >= 200 && response.statusCode < 300)) {
        sodResponse.error = [SODAError errorWithCode:[JSON objectForKey:@"code"]
                                             message:[JSON objectForKey:@"message"]
                                                data:[JSON objectForKey:@"data"]];
    }
    sodResponse.hasEntity = sodResponse.entity != nil;
    sodResponse.hasError = sodResponse.error != nil;
    return sodResponse;
}


@end