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
#import "SODATableViewController.h"
#import "SODAConsumer.h"
#import "SODAQuery.h"
#import "SODAResponse.h"
#import "SODACallback.h"


@implementation SODATableViewController {
    SODAQuery *query;
    SODAResponse *lastResponse;
    NSMutableArray *data;
    NSInteger offset; // The current offset
    UIActivityIndicatorView *spinner;
}

@synthesize consumer = _consumer;


#pragma mark - Initialization Methods

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    offset = 0;

    [self queryData];
}

#pragma mark - Query Methods

- (void)queryData {

    // Make sure the consumer is initialized
    assert(self.consumer != nil);

    query = [self queryForTable];

    // Add paging if enabled
    if(self.paginationEnabled) {
        [query setOffset:[NSNumber numberWithInteger:offset]];
        [query setLimit:[NSNumber numberWithInteger:self.recordsPerPage]];
    }

    // Call the consumer with the query
    [self.consumer getObjectsForTypedQuery:query result:[SODACallback callbackWithResult:^(SODAResponse *response) {

        lastResponse = response;

        // Check for errors
        if(response.error) {

            // TODO: How should we alert the user of errors? or should we provide a way for the caller to handle them?

        } else {
            // Get the data from the response and reload the table
            if(!self.paginationEnabled || offset == 0) {
                data = response.entity;
                [self.tableView reloadData];
            } else {
                // If we are loading more results, append them to the bottom instead of resetting them
                NSArray *newItems = response.entity;
                NSMutableArray *indexPaths = [[NSMutableArray alloc] init];

                for (int j = 0; j < newItems.count; j++) {
                    [indexPaths addObject:[NSIndexPath indexPathForRow:data.count+j inSection:0]];
                }

                [data addObjectsFromArray:newItems];
                [self.tableView beginUpdates];
                [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationBottom];
                [self.tableView endUpdates];
                [spinner stopAnimating];
            }
        }

    }]];
}

#pragma mark - UITableViewDataSource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger rows = data.count;

    // If we have paging enabled then we have an extra cell at the bottom to load more results
    if(self.paginationEnabled && data.count > 0) {
        rows++;
    }

    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;

    // If we are paging and this is the bottom cell then it should be the load more cell
    if(self.paginationEnabled && indexPath.row == data.count) {

        static NSString *cellIdent = @"SODALoadMoreCell";

        cell = [tableView dequeueReusableCellWithIdentifier:cellIdent];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdent];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            spinner.frame = CGRectMake(0, 0, 24, 24);
            cell.accessoryView = spinner;

            [cell.textLabel setTextColor:[UIColor lightGrayColor]];
            [cell.textLabel setFont:[UIFont boldSystemFontOfSize:14]];
            [cell.textLabel setTextAlignment:NSTextAlignmentCenter];
        }

        cell.textLabel.text = [NSString stringWithFormat:@"Load %i more results", self.recordsPerPage];

    } else {
        // Get the correct object from the data and pass it to the subclass
        id object = data[indexPath.row];

        cell = [self tableView:tableView cellForRowAtIndexPath:indexPath object:object];
    }

    return cell;
}

#pragma mark - UITableViewDelegate Methods


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // If this is the load more row then load more
    if(self.paginationEnabled && indexPath.row == data.count) {

        // Update the offset
        offset += self.recordsPerPage;
        [spinner startAnimating];

        [self queryData];

        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}



#pragma mark - "Abstract" Methods

- (SODAQuery *)queryForTable {
    // We don't do anything here, bail if the user hasn't overridden this method.
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in your subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(id)object {
    // We don't do anything here, bail if the user hasn't overridden this method.
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in your subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];

}


@end