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
#import "SODAGeoBox.h"
#import "SODAExpression.h"
#import "SODAExpressionUtils.h"
#import "SODASelectClause.h"
#import "SODAWhereClause.h"
#import "SODAGroupByClause.h"
#import "SODAOrderByClause.h"
#import "SODAOffsetClause.h"
#import "SODALimitClause.h"
#import "SODANSArrayUtils.h"


#pragma mark - Query Building Macros

#pragma mark -- Utils

/**
* Turns a variable list of argument into a NSArray
*/
#define array(...)    [SODANSArrayUtils fromVarArgs:__VA_ARGS__, nil]

#pragma mark -- Query

/**
* @see SODAQuery:queryWithDataset
*/
#define query(d, m) ((SODAQuery *)[SODAQuery queryWithDataset:d mapping:m])

#pragma mark -- Clauses

/**
* @see SODASelectClause:clauseWithExpressions
*/
#define select(...)    ([SODASelectClause clauseWithExpressions:array(__VA_ARGS__)])

/**
* @see SODAWhereClause:clauseWithExpressions
*/
#define where(...)    ([SODAWhereClause clauseWithExpressions:array(__VA_ARGS__)])

/**
* @see SODAOrderByClause:clauseWithExpressions
*/
#define orderBy(...)  ([SODAOrderByClause clauseWithExpressions:array(__VA_ARGS__)])

/**
* @see SODAGroupByClause:clauseWithExpressions
*/
#define groupBy(...)  ([SODAGroupByClause clauseWithExpressions:array(__VA_ARGS__)])

/**
* @see SODAOffsetClause:offset
*/
#define offset(start)    [SODAOffsetClause offset:start]

/**
* @see SODALimitClause:limit
*/
#define limit(max)    [SODALimitClause limit:max]

#pragma mark -- Expressions

/**
* @see SODAExpression:quoted
*/
#define quoted(e)  [SODAExpression quoted:e]

/**
* @see SODAExpression:parentheses
*/
#define wrapped(...) ([SODAExpression parentheses:array(__VA_ARGS__)])

/**
* @see SODAExpression:isNotNull
*/
#define isNotNull(e)  [SODAExpression isNotNull:e]

/**
* @see SODAExpression:isNull
*/
#define isNull(e)  [SODAExpression isNull:e]

/**
* @see SODAExpression:and
*/
#define and(...) ([SODAExpression and:array(__VA_ARGS__)])

/**
* @see SODAExpression:or
*/
#define or(...)    ([SODAExpression or:array(__VA_ARGS__)])

/**
* @see SODAExpression:not
*/
#define not(e)  [SODAExpression not:e]

/**
* @see SODAExpression:column
*/
#define col(name)    [SODAExpression column:name]

/**
* @see SODAExpression:alias:as
*/
#define alias(e, name)    [SODAExpression alias:e as:name]

/**
* @see SODAExpression:sum
*/
#define sum(e)    [SODAExpression sum:e]

/**
* @see SODAExpression:count
*/
#define count(e)    [SODAExpression count:e]

/**
* @see SODAExpression:avg
*/
#define avg(e)    [SODAExpression avg:e]

/**
* @see SODAExpression:min
*/
#define min(e)    [SODAExpression min:e]

/**
* @see SODAExpression:max
*/
#define max(e)    [SODAExpression max:e]

/**
* @see SODAExpression:op:lt
*/
#define lt(l, r) [SODAExpression op:l lt:r]

/**
* @see SODAExpression:op:lte
*/
#define lte(l, r) [SODAExpression op:l lte:r]

/**
* @see SODAExpression:op:eq
*/
#define eq(l, r) [SODAExpression op:l eq:r]

/**
* @see SODAExpression:op:neq
*/
#define neq(l, r) [SODAExpression op:l neq:r]

/**
* @see SODAExpression:op:gt
*/
#define gt(l, r) [SODAExpression op:l gt:r]

/**
* @see SODAExpression:op:gte
*/
#define gte(l, r) [SODAExpression op:l gte:r]

/**
* @see SODAExpression:upper
*/
#define upper(e) [SODAExpression upper:e]

/**
* @see SODAExpression:lower
*/
#define lower(e) [SODAExpression lower:e]

/**
* @see SODAExpression:startsWith
*/
#define startsWith(l, r) [SODAExpression op:l startsWith:r]

/**
* @see SODAExpression:op:contains
*/
#define contains(l, r) [SODAExpression op:l contains:r]

/**
* @see SODAExpression:op:multipliedBy
*/
#define multipliedBy(l, r) [SODAExpression op:l multipliedBy:r]

/**
* @see SODAExpression:op:dividedBy
*/
#define dividedBy(l, r) [SODAExpression op:l dividedBy:r]

/**
* @see SODAExpression:op:add
*/
#define add(l, r) [SODAExpression op:l add:r]

/**
* @see SODAExpression:op:subtract
*/
#define subtract(l, r) [SODAExpression op:l subtract:r]

/**
* @see SODAExpression:toString
*/
#define toString(e) [SODAExpression toString:e]

/**
* @see SODAExpression:toNumber
*/
#define toNumber(e) [SODAExpression toNumber:e]

/**
* @see SODAExpression:toBoolean
*/
#define toBoolean(e) [SODAExpression toBoolean:e]

/**
* @see SODAExpression:toLocation
*/
#define toLocation(latitude, longitude) [SODAExpression toLocationWithLat:latitude lng:longitude]

/**
* @see SODAExpression:toFixedTimestamp
*/
#define toFixedTimestamp(e) [SODAExpression toFixedTimestamp:e]

/**
* @see SODAExpression:toFloatingTimestamp
*/
#define toFloatingTimestamp(e) [SODAExpression toFloatingTimestamp:e]

/**
* @see SODAExpression:order:direction
*/
#define order(e, dir)  [SODAExpression order:e direction:dir]

/**
* @see SODAExpression:boxWithNorth:east:south:west
*/
#define geoBox(n, e, s, w)  [SODAGeoBox boxWithNorth:n east:e south:s west:w]

/**
* @see SODAExpression:boxWithNorthEastCoordinate:southWestCoordinate
*/
#define geoBoxWithCoordinates(ne, sw)  [SODAGeoBox boxWithNorthEastCoordinate:ne southWestCoordinate:sw]

/**
* @see SODAExpression:location:withinBox
*/
#define withinBox(l, b)  [SODAExpression location:l withinBox:b]

#pragma mark - Query Object

/**
 * Main entry point to construct simple and complex query that can be used to query the Socrata API
 * This class provides utility methods to append expressions to clauses and default values for empty clauses
 */
@interface SODAQuery : NSObject <SODABuildCapable> {
    NSString *_dataset;
    SODASelectClause *_select;
    SODAWhereClause *_where;
    SODAGroupByClause *_groupBy;
    SODAOrderByClause *_orderBy;
    NSNumber *_offset;
    NSNumber *_limit;
}

#pragma mark - Properties

/**
* The select clause
*/
@property(nonatomic, strong) SODASelectClause *select;

/**
* The where clause
*/
@property(nonatomic, strong) SODAWhereClause *where;

/**
* The group by clause
*/
@property(nonatomic, strong) SODAGroupByClause *groupBy;

/**
* The order by clause
*/
@property(nonatomic, strong) SODAOrderByClause *orderBy;

/**
* The query offset for pagination purposes
*/
@property(nonatomic, strong) NSNumber *offset;

/**
* The query results limit for pagination purposes
*/
@property(nonatomic, strong) NSNumber *limit;

/**
* The dataset this query refers to
*/
@property(nonatomic, copy) NSString *dataset;

/**
* The class to which query results wil be mapped to
*/
@property(nonatomic) Class mapping;


#pragma mark - Initializers

/**
* Initializes a query given a dataset and mapping
*/
- (id)initWithDataset:(NSString *)dataset mapping:(Class)mapping;

/**
* Factory method
*/
+ (id)queryWithDataset:(NSString *)dataset mapping:(Class)mapping;


#pragma mark - Syntactic sugar Builders

/// Methods added for convenience to the most common use cases with simple where constraints.
/// Internal query structure is replaced to mantain clause and expressions immutability

/**
* Adds expressions to the 'select' clause
*/
- (void)addSelect:(NSArray *)expressions;

/**
* Adds expressions to the 'where' clause
*/
- (void)addWhere:(NSArray *)expressions;

/**
* Adds a single expression to the 'where' clause
*/
- (void)addWhereExpression:(id)expression;

/**
* Adds a 'a is not null' expression to the 'where' clause
*/
- (void)whereIsNotNull:(id)expression;

/**
* Adds a 'is null' expression to the 'where' clause
*/
- (void)whereIsNull:(id)expression;

/**
* Adds a 'a > b' expression to the 'where' clause
*/
- (void)where:(id)left greatherThan:(id)right;

/**
* Adds a 'a >= b' expression to the 'where' clause
*/
- (void)where:(id)left greatherThanOrEquals:(id)right;

/**
* Adds a 'a < b' expression to the 'where' clause
*/
- (void)where:(id)left lessThan:(id)right;

/**
* Adds a 'a <= b' expression to the 'where' clause
*/
- (void)where:(id)left lessThanOrEquals:(id)right;

/**
* Adds a 'a >= b' expression to the 'where' clause
*/
- (void)where:(id)left equals:(id)right;

/**
* Adds a 'a != b' expression to the 'where' clause
*/
- (void)where:(id)left notEquals:(id)right;

/**
* Adds a 'starts_with(a, b)' expression to the 'where' clause
*/
- (void)where:(id)left startsWith:(id)right;

/**
* Adds a 'contains(a, b)' expression to the 'where' clause
*/
- (void)where:(id)left contains:(id)right;

/**
* Adds a 'whitin_box(location, n, e, s, w)' expression to the 'where' clause
* to constrain results to a bounding box where the 'location' is a property of type location
*/
- (void)where:(id)location withinBox:(SODAGeoBox *)geoBox;

/**
* Adds a group clause to retrieve aggregated results e.g. 'group a, b'
*/
- (void)addGroup:(NSArray *)expressions;

/**
* Adds an order clause to retrieve results in a specif order e.g. 'order a desc, b asc'
*/
- (void)addOrder:(NSArray *)expressions;

@end