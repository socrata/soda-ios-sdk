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

#import "SODAClientTest.h"
#import "SODAConsumer.h"
#import "SODACallback.h"
#import "SODAResponse.h"
#import "SODADataTypeModel.h"

@interface SODAClientTest ()
@property (nonatomic, retain) NSDate *loopUntil;
@property (nonatomic, assign) BOOL notified;
@property (nonatomic, assign) SenAsyncTestCaseStatus notifiedStatus;
@property (nonatomic, assign) SenAsyncTestCaseStatus expectedStatus;
@end


@implementation SODAClientTest

@synthesize loopUntil = _loopUntil;
@synthesize notified = _notified;
@synthesize notifiedStatus = _notifiedStatus;
@synthesize expectedStatus = _expectedStatus;

#pragma mark - Async test helpers


- (void)waitForStatus:(SenAsyncTestCaseStatus)status timeout:(NSTimeInterval)timeout
{
    self.notified = NO;
    self.expectedStatus = status;
    self.loopUntil = [NSDate dateWithTimeIntervalSinceNow:timeout];
    
    NSDate *dt = [NSDate dateWithTimeIntervalSinceNow:0.1];
    while (!self.notified && [self.loopUntil timeIntervalSinceNow] > 0) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode
                                 beforeDate:dt];
        dt = [NSDate dateWithTimeIntervalSinceNow:0.1];
    }
    
    // Only assert when notified. Do not assert when timed out
    // Fail if not notified
    if (self.notified) {
        STAssertEquals(self.notifiedStatus, self.expectedStatus, @"Notified status does not match the expected status.");
    } else {
        STFail(@"Async test timed out.");
    }
}

- (void)waitForTimeout:(NSTimeInterval)timeout
{
    self.notified = NO;
    self.expectedStatus = SenAsyncTestCaseStatusUnknown;
    self.loopUntil = [NSDate dateWithTimeIntervalSinceNow:timeout];
    
    NSDate *dt = [NSDate dateWithTimeIntervalSinceNow:0.1];
    while (!self.notified && [self.loopUntil timeIntervalSinceNow] > 0) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode
                                 beforeDate:dt];
        dt = [NSDate dateWithTimeIntervalSinceNow:0.1];
    }
}

- (void)notify:(SenAsyncTestCaseStatus)status
{
    self.notifiedStatus = status;
    // self.notified must be set at the last of this method
    self.notified = YES;
}

#pragma mark - Setup & Teardown stubs

- (void)setUp {
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown {
    // Tear-down code here.
    
    [super tearDown];
}

#pragma mark - Clauses Test

/* Immutable Clauses */

- (void)testSelect {
    SODAssertExpression(@"select a, b", select(@"a", @"b"));
}

- (void)testWhere {
    SODAssertExpression(@"where a = b and b = c", where(and(eq(@"a", @"b"), eq(@"b", @"c"))));
    SODAssertExpression(@"where a = b and b = c", where(eq(@"a", @"b"), eq(@"b", @"c")));
}

- (void)testOrderBy {
    SODAssertExpression(@"order a desc", orderBy(order(@"a", kDescending)));
}

- (void)testGroupBy {
    SODAssertExpression(@"group a, b", groupBy(@"a", @"b"));
}

- (void)testOffset {
    SODAssertExpression(@"offset 1", offset(@1));
}

- (void)testLimit {
    SODAssertExpression(@"limit 1", limit(@1));
}

#pragma mark - Expressions Test

- (void)testWrapped {
    SODAssertExpression(@"(a)", wrapped(@"a"));
}

- (void)testIsNotNull {
    SODAssertExpression(@"a is not null", isNotNull(@"a"));
}

- (void)testIsNull {
    SODAssertExpression(@"a is null", isNull(@"a"));
}

- (void)testAnd {
    SODAssertExpression(@"a and b and c and (c = d)", and(@"a", @"b", @"c", wrapped(eq(@"c", @"d"))));
}

- (void)testOr {
    SODAssertExpression(@"a or b or c or (c = d)", or(@"a", @"b", @"c", wrapped(eq(@"c", @"d"))));
}

- (void)testNot {
    SODAssertExpression(@"not a", not(@"a"));
}

- (void)testCol {
    SODAssertExpression(@"a", col(@"a"));
}

- (void)testAlias {
    SODAssertExpression(@"a as aliasA", alias(@"a", @"aliasA"));
}

- (void)testSum {
    SODAssertExpression(@"sum(a)", sum(@"a"));
}

- (void)testCount {
    SODAssertExpression(@"count(a)", count(@"a"));
}

- (void)testAvg {
    SODAssertExpression(@"avg(a)", avg(@"a"));
}

- (void)testMin {
    SODAssertExpression(@"min(a)", min(@"a"));
}

- (void)testMax {
    SODAssertExpression(@"max(a)", max(@"a"));
}

- (void)testLt {
    SODAssertExpression(@"a < b", lt(@"a", @"b"));
}

- (void)testLte {
    SODAssertExpression(@"a <= b", lte(@"a", @"b"));
}

- (void)testEq {
    SODAssertExpression(@"a = b", eq(@"a", @"b"));
}

- (void)testNeq {
    SODAssertExpression(@"a != b", neq(@"a", @"b"));
}

- (void)testGt {
    SODAssertExpression(@"a > b", gt(@"a", @"b"));
}

- (void)testGte {
    SODAssertExpression(@"a >= b", gte(@"a", @"b"));
}

- (void)testUpper {
    SODAssertExpression(@"upper(a)", upper(@"a"));
}

- (void)testLower {
    SODAssertExpression(@"lower(a)", lower(@"a"));
}

- (void)testStartsWith {
    SODAssertExpression(@"starts_with(a, b)", startsWith(@"a", @"b"));
}

- (void)testContains {
    SODAssertExpression(@"contains(a, 'b')", contains(@"a", quoted(@"b")));
}

- (void)testMultipliedBy {
    SODAssertExpression(@"a * b", multipliedBy(@"a", @"b"));
}

- (void)testDividedBy {
    SODAssertExpression(@"a / b", dividedBy(@"a", @"b"));
}

- (void)testAdd {
    SODAssertExpression(@"a + b", add(@"a", @"b"));
}

- (void)testSubtract {
    SODAssertExpression(@"a - b", subtract(@"a", @"b"));
}

- (void)testToString {
    SODAssertExpression(@"to_string(a)", toString(@"a"));
}

- (void)testToNumber {
    SODAssertExpression(@"to_number(a)", toNumber(@"a"));
}

- (void)testToBoolean {
    SODAssertExpression(@"to_boolean(a)", toBoolean(@"a"));
}

- (void)testToLocation {
    SODAssertExpression(@"to_location(a, b)", toLocation(@"a", @"b"));
}

- (void)testToFixedTimestamp {
    SODAssertExpression(@"to_fixed_timestamp(a)", toFixedTimestamp(@"a"));
}

- (void)testToFloatingTimestamp {
    SODAssertExpression(@"to_floating_timestamp(a)", toFloatingTimestamp(@"a"));
}

- (void)testLocationWithinGeoBox {
    NSNumber *north = @47.712585;
    NSNumber *east = @-122.464676;
    NSNumber *south = @47.510759;
    NSNumber *west = @-122.249756;
    SODAssertExpression(@"within_box(location, 47.712585, -122.464676, 47.510759, -122.249756)", withinBox(@"location", geoBox(north, east, south, west)));
}

- (void)testOrder {
    SODAssertExpression(@"a desc", order(@"a", kDescending));
    SODAssertExpression(@"a asc", order(@"a", kAscending));
}

#pragma mark - Query Test

- (void)testQueryBuilding {
    SODAQuery *query = query(@"a", [NSObject class]);
    [query addWhere:@[and(eq(@"a", @"b"))]];
    [query addWhere:@[and(neq(@"c", @"d"))]];
    SODAssertExpression(@"select * where a = b and c != d",
                        query
                        );
}

- (void)testWithinQuery {
    SODAQuery *query = query(@"a", [NSObject class]);
    NSNumber *north = @47.712585;
    NSNumber *east = @-122.464676;
    NSNumber *south = @47.510759;
    NSNumber *west = @-122.249756;
    [query where:@"location" withinBox:geoBox(north, east, south, west)];
    SODAssertExpression(@"select * where within_box(location, 47.712585, -122.464676, 47.510759, -122.249756)",
                        query
                        );
}

- (void)testComplexQueryBuilding {
    SODAQuery *query = query(@"a", [NSObject class]);
    [query addSelect:@[@"a", @"b", @"c", alias(@"sum(d)", @"aliasD"), alias(count(@"e"), @"eCountAlias")]];
    [query addWhere:@[and(eq(@"a", @"b"))]];
    [query addWhere:@[and(neq(@"c", @"d"))]];
    [query addGroup:@[@"eCountAlias", @"aliasD"]];
    [query addOrder:@[order(@"a", kDescending), order(@"b", kAscending)]];
    [query setOffset:@30];
    [query setLimit:@200];
    SODAssertExpression(@"select a, b, c, sum(d) as aliasD, count(e) as eCountAlias where a = b and c != d group eCountAlias, aliasD order a desc, b asc offset 30 limit 200",
                        query
                        );
}

- (void)testAddIndividualConstrains {
    SODAQuery *query = query(@"a", [NSObject class]);
    [query addWhereExpression:eq(@"a", @"b")];
    [query addWhereExpression:neq(@"b", @"c")];
    [query addWhereExpression:or(eq(@"b", @"c"), neq(@"x", @"y"))];
    SODAssertExpression(@"select * where a = b and b != c and b = c or x != y",
                        query
                        );
}

#pragma mark - Async API Tests

- (void)testDataTypesDatasetSerialization
{
    SODAConsumer *consumer = [SODAConsumer consumerWithDomain:@"sandbox.demo.socrata.com" token:nil];
    [consumer getObjectsInDataset:@"dataTypeTest" mappingTo:[SODADataTypeModel class] result:[SODACallback callbackWithResult:^(SODAResponse *response) {
        if (response.hasError || !response.hasEntity) {
            [self notify:SenAsyncTestCaseStatusFailed];
        } else {
            STAssertEqualObjects(response.status, @200, @"");
            NSArray *results = response.entity;
            STAssertTrue([[results objectAtIndex:0] isKindOfClass:[SODADataTypeModel class]], @"");
            [self notify:SenAsyncTestCaseStatusSucceeded];
        }
        NSLog(@"Request Finished!");
    }]];
    [self waitForStatus:SenAsyncTestCaseStatusSucceeded timeout:10.0];
    NSLog(@"Test Finished!");
}


@end
