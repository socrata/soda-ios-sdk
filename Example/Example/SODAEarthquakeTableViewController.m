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


#import "SODAQuery.h"
#import "SODAEarthquakeTableViewController.h"
#import "SODAConsumer.h"
#import "SODAEarthquake.h"

/**
* Sample View controller that displays earthquake information on a Table using the iOS SODA client SDK
*/
@implementation SODAEarthquakeTableViewController {

}


- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        self.navigationItem.title = @"Earthquake Table View";

        self.consumer = [SODAConsumer consumerWithDomain:@"demo.socrata.com" token:nil];
        self.paginationEnabled = YES;
        self.recordsPerPage = 10;
    }

    return self;
}

/**
* Invoked upon table initialization offset and limit are automatically added by the superclass
*/
- (SODAQuery *)queryForTable {
    SODAQuery *query = [SODAQuery queryWithDataset:@"earthquakes" mapping:[SODAEarthquake class]];
    [query where:@"magnitude" greatherThan:@2];
    return query;
}

/**
* Invoked for each serialized object on the SODA response
*/
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(SODAEarthquake *)earthquake {
    static NSString *cellIdent = @"EarthquakeCell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdent];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdent];
    }

    cell.textLabel.text = earthquake.region;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Magnitude: %.2f, Depth: %.2f", [earthquake.magnitude doubleValue], [earthquake.depth doubleValue]];

    return cell;
}

@end