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
#import "SODABuildCapable.h"
#import "SODAOrderByClause.h"
#import "SODAExpressionUtils.h"

@class SODALocation;
@class SODAGeoBox;

/**
* Represents expressions that may be used in SODA clauses on a SODA Query e.g. 'a = b'
*/
@interface SODAExpression : NSObject <SODABuildCapable> {
    NSString *_expression;
    BOOL _requiresWrap;
}

#pragma mark - Properties

/**
* The built expressions
*/
@property(nonatomic, copy) NSString *expression;

/**
* Whether this expressions requires to be wrapped in brackets
*/
@property(nonatomic) BOOL requiresWrap;

#pragma mark - Initializers

/**
* Default initializer for unwrapped expressions
*/
- (id)initWithExpression:(NSString *)expression;

/**
* Initializer that optionally indicates that wrapping should be placed around this expression when built
*/
- (id)initWithExpression:(NSString *)expression requiresWrap:(BOOL)requiresWrap;

#pragma mark - Expression builders

/**
* Constructs a simple expression
*/
+ (SODAExpression *)simpleExpression:(NSString *)string;

/**
* Constructs an function expression such as 'not a'
*/
+ (SODAExpression *)infixedFunction:(NSString *)function withArg:(id)expression;

/**
* Constructs an function expression such as 'a is not null'
*/
+ (SODAExpression *)sufixedFunction:(NSString *)function withArg:(id)expression;

/**
*  Joins a left and right expression with an operator e.g. 'a + b'
*/
+ (SODAExpression *)applyOperator:(NSString *)operator toExpressions:(NSArray *)expressions;

/**
*  Constructs a function with a list of arguments e.g. function(a,b,c)
*/
+ (SODAExpression *)function:(NSString *)function withArgs:(NSArray *)args;

/**
*  is not null expression. e.g. 'a is not null'
*/
+ (SODAExpression *)isNotNull:(id)expression;

/**
*  is null expression. e.g. 'a is null'
*/
+ (SODAExpression *)isNull:(id)expression;

/**
*  n expression. e.g. 'not a'
*/
+ (SODAExpression *)not:(id)expression;

/**
*  Joins an array of expression with 'and' e.g. (a and b and c)
*/
+ (SODAExpression *)and:(NSArray *)expressions;

/**
*  Joins an array of expression with 'or' e.g. (a or b or c)
*/
+ (SODAExpression *)or:(NSArray *)expressions;

/**
* Joins a left and right expression with an less than comparison operator e.g. 'a < b'
*/
+ (SODAExpression *)op:(id)left lt:(id)right;

/**
* Joins a left and right expression with an less than or equals comparison operator e.g. 'a <= b'
*/
+ (SODAExpression *)op:(id)left lte:(id)right;

/**
* Joins a left and right expression with an equals comparison operator e.g. 'a = b'
*/
+ (SODAExpression *)op:(id)left eq:(id)right;

/**
* Joins a left and right expression with a not equals comparison operator e.g. 'a != b'
*/
+ (SODAExpression *)op:(id)left neq:(id)right;

/**
* Joins a left and right expression with a greater than comparison operator e.g. 'a > b'
*/
+ (SODAExpression *)op:(id)left gt:(id)right;

/**
* Joins a left and right expression with a greater than or equals comparison operator e.g. 'a >= b'
*/
+ (SODAExpression *)op:(id)left gte:(id)right;

/**
* Wraps an expression with an upper function that would evaluate as uppercase in the server e.g. 'upper(a)'
*/
+ (SODAExpression *)upper:(id)expression;

/**
* Wraps an expression with a lower function that would evaluate as lowercase in the server e.g. 'lower(a)'
*/
+ (SODAExpression *)lower:(id)expression;

/**
* Wraps a left and right expression with a startsWith function e.g. 'starts_with(a, b)'
*/
+ (SODAExpression *)op:(id)left startsWith:(id)right;

/**
* Wraps a left and right expression with a contains function e.g. 'contains(a, b)'
*/
+ (SODAExpression *)op:(id)left contains:(id)right;

/**
* Joins a left and right expression with a multiply operator e.g. 'a * b'
*/
+ (SODAExpression *)op:(id)left multipliedBy:(id)right;

/**
* Joins a left and right expression with a divide operator e.g. 'a / b'
*/
+ (SODAExpression *)op:(id)left dividedBy:(id)right;

/**
* Joins a left and right expression with an add operator e.g. 'a + b'
*/
+ (SODAExpression *)op:(id)left add:(id)right;

/**
* Joins a left and right expression with an subtract operator e.g. 'a - b'
*/
+ (SODAExpression *)op:(id)left subtract:(id)right;

/**
* Wraps an expression with an to_string function that would evaluate as a string cast in the server e.g. 'to_string(a)'
*/
+ (SODAExpression *)toString:(id)expression;

/**
* Wraps an expression with an to_number function that would evaluate as a number cast in the server e.g. 'to_number(a)'
*/
+ (SODAExpression *)toNumber:(id)expression;

/**
* Wraps a left and right expression with a to_location function e.g. 'to_location(lat, lng)'
*/
+ (SODAExpression *)toLocationWithLat:(id)lat lng:(id)lng;

/**
* Wraps an expression with an to_boolean function that would evaluate as a number cast in the server e.g. 'to_boolean(a)'
*/
+ (SODAExpression *)toBoolean:(id)expression;


/**
* Wraps an expression with an to_fixed_timestamp function that would evaluate as a to fixed timestamp conversion in the server e.g. 'to_fixed_timestamp(a)'
*/
+ (SODAExpression *)toFixedTimestamp:(id)expression;

/**
* Wraps an expression with an to_floating_timestamp function that would evaluate as a to floating timestamp conversion in the server e.g. 'to_floating_timestamp(a)'
*/
+ (SODAExpression *)toFloatingTimestamp:(id)expression;

/**
* Wraps an expression with a sum function that would evaluate as and aggregated sum in the server e.g. 'sum(a)'
*/
+ (SODAExpression *)sum:(id)expression;

/**
* Wraps an expression with a count function that would evaluate as and aggregated count in the server e.g. 'count(a)'
*/
+ (SODAExpression *)count:(id)expression;

/**
* Wraps an expression with a avg function that would evaluate as and aggregated avg in the server e.g. 'avg(a)'
*/
+ (SODAExpression *)avg:(id)expression;

/**
* Wraps an expression with a min function that would evaluate as a min value for an expression in the server e.g. 'min(a)'
*/
+ (SODAExpression *)min:(id)expression;

/**
* Wraps an expression with a max function that would evaluate as a max value for an expression in the server e.g. 'max(a)'
*/
+ (SODAExpression *)max:(id)expression;

/**
* Wraps an expression as an alias that can be further used in the query for other things such as aggregated calculation e.g. 'a as aliasOfA'
*/
+ (SODAExpression *)alias:(id)expression as:(NSString *)alias;

/**
* Represents a column in a clause e.g. 'a'
*/
+ (SODAExpression *)column:(id)expression;

/**
* Single quotes an expression for literal comparison eg. " a = 'something'  "
*/
+ (SODAExpression *)quoted:(id)expression;

/**
* Adds order direction to an aexpression e.g. 'a desc'
*/
+ (SODAExpression *)order:(id)expression direction:(OrderDirection)direction;

/**
* Wraps an array of expressions in parentheses e.g. '(a)'
*/
+ (SODAExpression *)parentheses:(NSArray *)expressions;

/**
* Wraps an expression with a within_box function to look up location based properties in bounding box represented by ne and sw coordinates
*/
+ (SODAExpression *)location:(id) location withinBox:(SODAGeoBox *)geoBox;

@end