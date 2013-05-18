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

#import "SODAExpression.h"
#import "SODALocation.h"
#import "SODAGeoBox.h"


@implementation SODAExpression {

}

#pragma mark - Properties

@synthesize expression = _expression;

@synthesize requiresWrap = _requiresWrap;

#pragma mark - Initializers

- (id)initWithExpression:(NSString *)expression {
    return [self initWithExpression:expression requiresWrap:NO];
}

- (id)initWithExpression:(NSString *)expression requiresWrap:(BOOL)requiresWrap {
    self = [super init];
    if (self) {
        self.expression = expression;
        self.requiresWrap = requiresWrap;
    }
    return self;
}

#pragma mark - Helpers


+ (SODAExpression *)simpleExpression:(NSString *)string {
    return [[SODAExpression alloc] initWithExpression:string];
}

+ (SODAExpression *)infixedFunction:(NSString *)function withArg:(id)expression {
    return [[SODAExpression alloc] initWithExpression:[NSString stringWithFormat:@"%@ %@", function, build(expression)]];
}

+ (SODAExpression *)sufixedFunction:(NSString *)function withArg:(id)expression {
    return [[SODAExpression alloc] initWithExpression:[NSString stringWithFormat:@"%@ %@", build(expression), function]];
}

+ (SODAExpression *)applyOperator:(NSString *)operator toExpressions:(NSArray *)expressions {
    NSMutableArray *built = [NSMutableArray array];
    for (id ob in expressions) {
        [built addObject:build(ob)];
    }
    return [[SODAExpression alloc] initWithExpression:[NSString stringWithFormat:@"%@", [built componentsJoinedByString:[NSString stringWithFormat:@" %@ ", operator]]]];
}

+ (SODAExpression *)function:(NSString *)function withArgs:(NSArray *)args {
    NSMutableArray *built = [NSMutableArray array];
    for (id ob in args) {
        [built addObject:build(ob)];
    }
    return [[SODAExpression alloc] initWithExpression:[NSString stringWithFormat:@"%@(%@)", function, [built componentsJoinedByString:@", "]]];
}

#pragma mark - Expression Builders

+ (SODAExpression *)isNotNull:(id)expression {
    return [SODAExpression sufixedFunction:@"is not null" withArg:expression];
}

+ (SODAExpression *)isNull:(id)expression {
    return [SODAExpression sufixedFunction:@"is null" withArg:expression];
}

+ (SODAExpression *)not:(id)expression {
    return [SODAExpression infixedFunction:@"not" withArg:expression];
}

+ (SODAExpression *)and:(NSArray *)expressions {
    return [SODAExpression applyOperator:@"and" toExpressions:expressions];
}

+ (SODAExpression *)or:(NSArray *)expressions {
    return [SODAExpression applyOperator:@"or" toExpressions:expressions];
}

+ (SODAExpression *)op:(id)left lte:(id)right {
    return [SODAExpression applyOperator:@"<=" toExpressions:@[left, right]];
}

+ (SODAExpression *)op:(id)left lt:(id)right {
    return [SODAExpression applyOperator:@"<" toExpressions:@[left, right]];
}

+ (SODAExpression *)op:(id)left eq:(id)right {
    return [SODAExpression applyOperator:@"=" toExpressions:@[left, right]];
}

+ (SODAExpression *)op:(id)left neq:(id)right {
    return [SODAExpression applyOperator:@"!=" toExpressions:@[left, right]];
}

+ (SODAExpression *)op:(id)left gt:(id)right {
    return [SODAExpression applyOperator:@">" toExpressions:@[left, right]];
}

+ (SODAExpression *)op:(id)left gte:(id)right {
    return [SODAExpression applyOperator:@">=" toExpressions:@[left, right]];
}

+ (SODAExpression *)upper:(id)expression {
    return [SODAExpression function:@"upper" withArgs:@[expression]];
}

+ (SODAExpression *)lower:(id)expression {
    return [SODAExpression function:@"lower" withArgs:@[expression]];
}

+ (SODAExpression *)op:(id)left startsWith:(id)right {
    return [SODAExpression function:@"starts_with" withArgs:@[left, right]];
}

+ (SODAExpression *)op:(id)left contains:(id)right {
    return [SODAExpression function:@"contains" withArgs:@[left, right]];
}

+ (SODAExpression *)op:(id)left multipliedBy:(id)right {
    return [SODAExpression applyOperator:@"*" toExpressions:@[left, right]];
}

+ (SODAExpression *)op:(id)left dividedBy:(id)right {
    return [SODAExpression applyOperator:@"/" toExpressions:@[left, right]];
}

+ (SODAExpression *)op:(id)left add:(id)right {
    return [SODAExpression applyOperator:@"+" toExpressions:@[left, right]];
}

+ (SODAExpression *)op:(id)left subtract:(id)right {
    return [SODAExpression applyOperator:@"-" toExpressions:@[left, right]];
}

+ (SODAExpression *)toString:(id)expression {
    return [SODAExpression function:@"to_string" withArgs:@[expression]];
}

+ (SODAExpression *)toNumber:(id)expression {
    return [SODAExpression function:@"to_number" withArgs:@[expression]];
}

+ (SODAExpression *)toLocationWithLat:(id)lat lng:(id)lng {
    return [SODAExpression function:@"to_location" withArgs:@[lat, lng]];
}

+ (SODAExpression *)toBoolean:(id)expression {
    return [SODAExpression function:@"to_boolean" withArgs:@[expression]];
}

+ (SODAExpression *)toFixedTimestamp:(id)expression {
    return [SODAExpression function:@"to_fixed_timestamp" withArgs:@[expression]];
}

+ (SODAExpression *)toFloatingTimestamp:(id)expression {
    return [SODAExpression function:@"to_floating_timestamp" withArgs:@[expression]];
}

+ (SODAExpression *)sum:(id)expression {
    return [SODAExpression function:@"sum" withArgs:@[expression]];
}

+ (SODAExpression *)count:(id)expression {
    return [SODAExpression function:@"count" withArgs:@[expression]];
}

+ (SODAExpression *)avg:(id)expression {
    return [SODAExpression function:@"avg" withArgs:@[expression]];
}

+ (SODAExpression *)min:(id)expression {
    return [SODAExpression function:@"min" withArgs:@[expression]];
}

+ (SODAExpression *)max:(id)expression {
    return [SODAExpression function:@"max" withArgs:@[expression]];
}

+ (SODAExpression *)alias:(id) expression as:(NSString *) alias {
    return [SODAExpression simpleExpression:[NSString stringWithFormat:@"%@ as %@", build(expression), alias]];
}

+ (SODAExpression *)column:(id) expression {
    return [SODAExpression simpleExpression:build(expression)];
}

+ (SODAExpression *)quoted:(id) expression {
    return [SODAExpression simpleExpression:[NSString stringWithFormat:@"'%@'", build(expression)]];
}

+ (SODAExpression *)order:(id) expression direction:(OrderDirection) direction {
    return [SODAExpression simpleExpression:[NSString stringWithFormat:@"%@ %@", build(expression), kDescending == direction ? @"desc" : @"asc"]];
}

+ (SODAExpression *)parentheses:(NSArray *) expressions {
    NSMutableArray *built = [NSMutableArray array];
    for (id ob in expressions) {
        [built addObject:build(ob)];
    }
    return [[SODAExpression alloc] initWithExpression:[built componentsJoinedByString:@" "] requiresWrap:YES];
}

+ (SODAExpression *)location:(id)location withinBox:(SODAGeoBox *)geoBox {
    return [SODAExpression function:@"within_box" withArgs:@[location, geoBox.north, geoBox.east, geoBox.south, geoBox.west]];
}

#pragma mark - SODABuildCapable Impl

- (NSString *)build {
    return self.requiresWrap ? [NSString stringWithFormat:@"(%@)", self.expression] : self.expression;
}


@end