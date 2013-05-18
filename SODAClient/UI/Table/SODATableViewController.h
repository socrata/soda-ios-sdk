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

@class SODAConsumer;
@class SODAQuery;
@class SODAResponse;


@interface SODATableViewController : UITableViewController

#pragma mark - Properties

@property (strong, nonatomic) SODAConsumer *consumer;
@property (nonatomic, assign) BOOL paginationEnabled;
@property (nonatomic, assign) NSInteger recordsPerPage;

#pragma mark - "Abstract" Methods

- (SODAQuery *)queryForTable;

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(id) object;

@end