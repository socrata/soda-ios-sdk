# SODA iOS SDK

## Overview

This is the iOS SDK for the Socrata Open Data API (SODA). Please refer to the developer site (http://dev.socrata.com/) for a deeper discussion of the underlying protocol.

## Distribution

You can add the SODA Client to your project as a CocoaPods dependency, static library or simply copying the client sources and adding the dependent frameworks.

### CocoaPods dependency

    pod 'SODAClient', '1.0.0'

### Include the static library

[libSODAClient.a]()

### Sources

    [SODAClient]()

### SODAClient requires you link against these system frameworks

    CFNetwork.framework
    CoreLocation.framework
    Foundation.framework
    MapKit.framework
    MobileCoreServices.framework
    Security.framework
    SystemConfiguration.framework
    UIKit.framework

## SODA

## Consumer

### Initialization

The SODAConsumer is the main interface to communicate with the SODA consumer API. A SODA consumer is created and initialized with the domain and token provided by Socrata.
If you are just getting started with the SODA API please take a look at the [Getting Started Guide](http://dev.socrata.com/consumers/getting-started)

```objective-c
SODAConsumer *consumer = [SODAConsumer consumerWithDomain:@"soda.demo.socrata.com" token:@"YOUR_TOKEN"];
```
Instances of a consumer can be held in memory for requests to datasets in the same domain.

### Getting Data

All requests to the SODA API are non blocking and performed asynchronously in a background thread. A callback style interface ensures that responses are delivered in the callback back to the caller in the Main thread where it is is safe to update the user interface.

You can lookup records by IDs or query with a SQL style language as defined in (http://dev.socrata.com/docs/queries).

#### Get by ID

Get by ID returns a single result 

```objective-c
// The request runs asynchronously in the background
[consumer getObjectInDataset:dataset withId:objectId
            mappingTo:[MyObject class]
            result:[SODACallback callbackWithResult:^(SODAResponse *response) {

    // The results are notified in a callback block that runs on the main thread
    if (response.hasError) {
        NSLog(@"Error ", response.error.message);
    } else {
    // Upon success the response entity is deserialized and mapped to objects based on the mappingTo param.
    // e.g. MyObject
        MyObject *myObject = response.entity;
        NSLog(@"Result : %@", myObject);
    }

}]];

```

#### Querying

The SODAConsumer accepts both NSString* queries and SODAQuery objects that once executed against the SODA Consumer API will return a subset of records constrained by the criteria specified in the query.

##### Query By String

SODAConsumer accepts raw SoQL strings as input to the getObjectsInDataset:forQuery: method. You can use any standard SoQL query passed to this method as defined in (http://dev.socrata.com/docs/queries).

```objective-c
// Retrieves the last 5 Earthquakes
[consumer getObjectsInDataset:@"earthquakes" forQuery:@"select * where magnitude > 3"
        mappingTo:[Earthquake class]
        result:[SODACallback callbackWithResult:^(SODAResponse *response) {
            NSLog(@"json response : %@", response.json);
            if (response.hasError) {
                NSLog(@"Error : %@", response.error.message);
            } else {
                NSArray *earthquakes = response.entity;
                NSLog(@"Result : %@", earthquakes);
        }
}]];
```

##### SODAQuery

You can build queries based on simple or complex criteria.
The SODA iOS Clients provides both a simple query interface where you can append expressions to a query and macros for each one of the available expressions.

Query Example to get Earthquakes with magnitude > 2

```objective-c
SODAQuery *query = [SODAQuery queryWithDataset:@"earthquakes" mapping:[SODAEarthquake class]];
[query where:@"magnitude" greatherThan:@2];

[consumer getObjectsForTypedQuery:query
    mappingTo:[MyObject class]
    result:[SODACallback callbackWithResult:^(SODAResponse *response) {
         NSLog(@"json response : %@", response.json);
         if (response.hasError) {
             NSLog(@"Error : %@", response.error.message);
         } else {
             NSArray *myObjects = response.entity;
             NSLog(@"Result : %@", myObjects);
         }
    }
]];
```

Query Example using macros to get Earthquakes with magnitude > 2 and magnitude < 5

```objective-c
SODAQuery *query = [SODAQuery queryWithDataset:@"earthquakes" mapping:[SODAEarthquake class]];
[query addWhereExpression:and(gt(@"magnitude", @2), lt(@"magnitude", @5))];

[consumer getObjectsForTypedQuery:query
    mappingTo:[MyObject class]
    result:[SODACallback callbackWithResult:^(SODAResponse *response) {
         NSLog(@"json response : %@", response.json);
         if (response.hasError) {
             NSLog(@"Error : %@", response.error.message);
         } else {
             NSArray *myObjects = response.entity;
             NSLog(@"Result : %@", myObjects);
         }
    }
]];
```

###### Geo Queries

The SODA iOS SDK supports geo queries by including a where:location withinBox:geoBox where clause that takes a dataset location property and a geo bounding box with the NE, SW coordinates.

```objective-c
SODAQuery *query = query(@"a", [SODAEarthquake class]);
NSNumber *north = @47.712585;
NSNumber *east = @-122.464676;
NSNumber *south = @47.510759;
NSNumber *west = @-122.249756;
[query where:@"location" withinBox:geoBox(north, east, south, west)];
```

## User Interface

The SODA SDK provides several user interface components that help speed the development of iOS apps that access the SODA API.

### SODATableViewController

Is a subclass of the UITableViewController that abstracts out much of the work involved in wiring up data from the SODA API to a table view. SODATableViewController includes pagination out of the box.

Creating a SODATableViewController is much like creating a typical UITableViewController.

1. Create a subclass of SODATableViewController and customize it as needed.
2. Set the consumer property to indicate which SODAConsumer object is used to query the data.
3. Override the queryForTable method to create a custom SODAQuery to fetch the data required.
4. Optionally set the paginationEnabled and recordsPerPage properties for pagination support.
5. Override the tableView:cellForRowAtIndexPath:object: method that is used to construct a custom table view cell for each object.
6. Implement your own custom cell that inherits from UITableViewCell as needed or use the standard UITableViewCells.

When the view loads the SODAQuery is automatically executed and the results are loaded into the table.

```objective-c

@interface EarthquakesTableViewController : SODATableViewController
@end

@implementation EarthquakesTableViewController

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        self.consumer = [SODAConsumer consumerWithDomain:@"soda.demo.socrata.com" token: @"token"];
        self.paginationEnabled = YES;
        self.recordsPerPage = 15;
    }
    return self;
}

- (SODAQuery *)queryForTable {

    // Limit and offset are added automatically when paging is enabled
   SODAQuery *query = [SODAQuery queryWithDataset:@"earthquakes" mapping:[SODAEarthquake class]];
   [query where:@"magnitude" greatherThan:@2];
   return query;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
                        object:(SODAEarthquake *)earthquake {

    static NSString *cellIdent = @"EarthquakeCell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdent];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:cellIdent];
    }

   	cell.textLabel.text = earthquake.region;
	cell.detailTextLabel.text = [NSString stringWithFormat:@"Magnitude: %.2f, Depth: %.2f", 
			[earthquake.magnitude doubleValue], [earthquake.depth doubleValue]];

    return cell;
}

@end

```

### SODAMapViewController

The SODA iOS SDK includes several components to simplify creating a map of data from the SODA API.

The SODAMapViewController is simply a UIViewController with a single MKMapView subview. SODAMapViewController implements the MKMapViewDelegate protocol with the addition of several methods which you need to override in order to customize.

1. Subclass the SODAMapViewController and customize as needed. The mapView property will automatically have it's delegate property set to the SODAMapViewController instance.
2. Set the consumer property to indicate which SODAConsumer object is used to query the data.
3. Override the queryForMapWithGeoBox method to create a custom SODAQuery to fetch the data required. The geo box for the map will be passed to this method if you wish to filter the results based on the current map view.
4. Override the annotationForObject: method that returns a SODAMapAnnotaion (or custom subclass) for the given object.
5. (Optionally) Override the viewForAnnotation: method that returns a SODAMapAnnotationView (or custom subclass) for the given SODAAnnotation. If not overridden the default SODAMapAnnotation view will be used. 

#### SODAMapAnnotation

The SODAMapAnnotation maintains a link to the response object for the annotation and adhears to the MKMapAnnotation protocol to provide a title, subtitle and coordinate. You would set the location to the appropriate SODALocation field from your SODAObject response and it will be turned into a coordinate.

#### SODAMapAnnotationView

The SODAMapAnnotationView is a subclass of MKAnnotationView and presents the annotation on the map using the default SODA pin image. You can subclass this to provide your own look and feel for the map annotations. Or simply set the image property to only override the pin image.

```objective-c

@interface EarthquakesMapViewController : SODAMapViewController
@end

@implementation EarthquakesTableViewController

- (id)init {
    self = [super init];
    if (self) {
        self.consumer = [SODAConsumer consumerWithDomain:@"soda.demo.socrata.com" token: @"token"];
    }
    return self;
}

- (SODAQuery *)queryForMapWithGeoBox:(SODAGeoBox *)geoBox{

    SODAQuery *query = [[SODAQuery alloc] initWithDataset:@"earthquakes" mapping:[SODAEarthquake class]];
    [query where:@"magnitude" greatherThan:@2];
	[query where:@"location" withinBox:geoBox]; // This is the current geobox for the map view

    return query;
}

- (SODAMapAnnotation *)annotationForObject:(SODAEarthquake *) earthquake {

    SODAMapAnnotation *annotation = [SODAMapAnnotation annotationWithObject:earthquake atLocation:earthquake.location];
    annotation.title = earthquake.region;
    annotation.subtitle = [NSString stringWithFormat:@"Magnitude: %.2f, Depth: %.2f", [earthquake.magnitude doubleValue], [earthquake.depth doubleValue]];

    return annotation;
}

	// This method is optional, if you don't override the default pin will be used
- (SODAMapAnnotationView *)viewForAnnotation:(SODAMapAnnotation *)annotation {
	static NSString *ident = @"SODAMapAnnotationViewPin";
	
	// Just use the default SODAMapAnnotationView, you can subclass it and use your own if you desire
	SODAMapAnnotationView * annotationView = (SODAMapAnnotationView *) [self.mapView dequeueReusableAnnotationViewWithIdentifier:ident];
	if (annotationView == nil) {
	    annotationView = [[SODAMapAnnotationView alloc] initWithAnnotation:annotation
	                                                           reuseIdentifier:ident];
	} else {
	    annotationView.annotation = annotation;
	}

	annotationView.enabled = YES;
	annotationView.canShowCallout = YES;

	return annotationView;
}

@end

```

## Advanced Usage

### Macros

Macros help you build complex or simple queries with a friendly syntax by wrapping most of the common operations available in the client.
A list of the currently available macros is shown below.

```Objective-C

#define query(d, m) ((SODAQuery *)[SODAQuery queryWithDataset:d mapping:m])

#define select(...)    ([SODASelectClause clauseWithExpressions:array(__VA_ARGS__)])
#define where(...)    ([SODAWhereClause clauseWithExpressions:array(__VA_ARGS__)])
#define orderBy(...)  ([SODAOrderByClause clauseWithExpressions:array(__VA_ARGS__)])
#define groupBy(...)  ([SODAGroupByClause clauseWithExpressions:array(__VA_ARGS__)])
#define offset(start)    [SODAOffsetClause offset:start]
#define limit(max)    [SODALimitClause limit:max]

#define quoted(e)  [SODAExpression quoted:e]
#define wrapped(...) ([SODAExpression parentheses:array(__VA_ARGS__)])
#define isNotNull(e)  [SODAExpression isNotNull:e]
#define isNull(e)  [SODAExpression isNull:e]
#define and(...) ([SODAExpression and:array(__VA_ARGS__)])
#define or(...)    ([SODAExpression or:array(__VA_ARGS__)])
#define not(e)  [SODAExpression not:e]
#define col(name)    [SODAExpression column:name]
#define alias(e, name)    [SODAExpression alias:e as:name]
#define sum(e)    [SODAExpression sum:e]
#define count(e)    [SODAExpression count:e]
#define avg(e)    [SODAExpression avg:e]
#define min(e)    [SODAExpression min:e]
#define max(e)    [SODAExpression max:e]
#define lt(l, r) [SODAExpression op:l lt:r]
#define lte(l, r) [SODAExpression op:l lte:r]
#define eq(l, r) [SODAExpression op:l eq:r]
#define neq(l, r) [SODAExpression op:l neq:r]
#define gt(l, r) [SODAExpression op:l gt:r]
#define gte(l, r) [SODAExpression op:l gte:r]
#define upper(e) [SODAExpression upper:e]
#define lower(e) [SODAExpression lower:e]
#define startsWith(l, r) [SODAExpression op:l startsWith:r]
#define contains(l, r) [SODAExpression op:l contains:r]
#define multipliedBy(l, r) [SODAExpression op:l multipliedBy:r]
#define dividedBy(l, r) [SODAExpression op:l dividedBy:r]
#define add(l, r) [SODAExpression op:l add:r]
#define subtract(l, r) [SODAExpression op:l subtract:r]
#define toString(e) [SODAExpression toString:e]
#define toNumber(e) [SODAExpression toNumber:e]
#define toBoolean(e) [SODAExpression toBoolean:e]
#define toLocation(latitude, longitude) [SODAExpression toLocationWithLat:latitude lng:longitude]
#define toFixedTimestamp(e) [SODAExpression toFixedTimestamp:e]
#define toFloatingTimestamp(e) [SODAExpression toFloatingTimestamp:e]
#define order(e, dir)  [SODAExpression order:e direction:dir]
#define geoBox(n, e, s, w)  [SODAGeoBox boxWithNorth:n east:e south:s west:w]
#define geoBoxWithCoordinates(ne, sw)  [SODAGeoBox boxWithNorthEastCoordinate:ne southWestCoordinate:sw]
#define withinBox(l, b)  [SODAExpression location:l withinBox:b]

```
