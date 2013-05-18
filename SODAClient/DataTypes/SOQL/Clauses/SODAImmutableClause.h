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
#import "SODAExpressionUtils.h"
#import "SODABuildCapable.h"

/**
* Super class for immutable query clauses.
* append: will return a new immutable instance of the same type with the appended expression
*/
@interface SODAImmutableClause : NSObject {
    NSArray *_expressions;
}

#pragma mark - Properties

/**
* All of the expressions in order that conform this immutable clause
*/
@property(nonatomic, strong) NSArray *expressions;

#pragma mark - Initializers

/**
* Default initializer that creates a clause given a list of expressions
*/
- (id)initWithExpressions:(NSArray *)expressions;

/**
* Factory method to obtain a clause given a list of expressions
*/
+ (id)clauseWithExpressions:(NSArray *)expressions;

#pragma mark - Builders

/**
* Appends an expression to this clause and returns a new clause
*/
- (id) append:(NSArray *)expressions;

@end




