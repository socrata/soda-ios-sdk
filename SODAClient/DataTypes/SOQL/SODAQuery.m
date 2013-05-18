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

#import "SODAQuery.h"


@implementation SODAQuery {
}

#pragma mark - Properties

@synthesize select = _select;
@synthesize where = _where;
@synthesize groupBy = _groupBy;
@synthesize orderBy = _orderBy;
@synthesize offset = _offset;
@synthesize limit = _limit;
@synthesize dataset = _dataset;
@synthesize mapping;

#pragma mark - Initializers


- (id)init {
    self = [super init];
    if (self) {
        self.select = [SODASelectClause clauseWithExpressions:@[]];
        self.where = [SODAWhereClause clauseWithExpressions:@[]];
        self.groupBy = [SODAGroupByClause clauseWithExpressions:@[]];
        self.orderBy = [SODAOrderByClause clauseWithExpressions:@[]];
        self.offset = nil;
        self.limit = nil;
    }

    return self;
}

- (id)initWithDataset:(NSString *)dataset mapping:(Class)responseMapping {
    self = [self init];
    if (self) {
        self.dataset = dataset;
        self.mapping = responseMapping;
    }

    return self;
}

+ (id)queryWithDataset:(NSString *)dataset mapping:(Class)responseMapping {
    return [[self alloc] initWithDataset:dataset mapping:responseMapping];
}


+ (id)query {
    return [[self alloc] init];
}

#pragma mark - Syntactic Sugar Builders

- (void)addSelect:(NSArray *)expressions {
    self.select = [self.select append:expressions];
}

- (void)addWhere:(NSArray *)expressions {
    self.where = [self.where append:expressions];
}

- (void)addWhereExpression:(id)expression {
    [self addWhere:@[expression]];
}

- (void)whereIsNotNull:(id)expression {
    [self addWhereExpression:isNotNull(expression)];
}

- (void)whereIsNull:(id)expression {
    [self addWhereExpression:isNull(expression)];
}

- (void)where:(id)left greatherThan:(id)right {
    [self addWhereExpression:gt(left, right)];
}

- (void)where:(id)left greatherThanOrEquals:(id)right {
    [self addWhereExpression:gte(left, right)];
}

- (void)where:(id)left lessThan:(id)right {
    [self addWhereExpression:lt(left, right)];
}

- (void)where:(id)left lessThanOrEquals:(id)right {
    [self addWhereExpression:lte(left, right)];
}

- (void)where:(id)left equals:(id)right {
    [self addWhereExpression:eq(left, right)];
}

- (void)where:(id)left notEquals:(id)right {
    [self addWhereExpression:neq(left, right)];
}

- (void)where:(id)left startsWith:(id)right {
    [self addWhereExpression:startsWith(left, right)];
}

- (void)where:(id)left contains:(id)right {
    [self addWhereExpression:contains(left, right)];
}

- (void)where:(id)location withinBox:(SODAGeoBox *)geoBox {
    [self addWhereExpression:withinBox(location, geoBox)];
}


- (void)addGroup:(NSArray *)expressions {
    self.groupBy = [self.groupBy append:expressions];
}

- (void)addOrder:(NSArray *)expressions {
    self.orderBy = [self.orderBy append:expressions];
}

#pragma mark - SODABuildCapable Impl

- (NSString *)build {
    NSArray *parts = @[self.select, self.where, self.groupBy, self.orderBy, [SODAOffsetClause offset:self.offset], [SODALimitClause limit:self.limit]];
    NSMutableArray *built = [NSMutableArray array];
    for (id part in parts) {
        if (part) {
            NSString *builtPart = build(part);
            NSString *trimmedPart = [builtPart stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            if (![@"" isEqualToString:trimmedPart]) {
                [built addObject:trimmedPart];
            }
        }
    }
    return [built componentsJoinedByString:@" "];
}


@end