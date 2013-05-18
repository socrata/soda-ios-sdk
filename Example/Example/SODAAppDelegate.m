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

#import "SODAAppDelegate.h"

#import "SODAEarthquakeTableViewController.h"
#import "SODAEarthquakeMapViewController.h"

@implementation SODAAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    SODAEarthquakeTableViewController *earthquakeTableViewController = [[SODAEarthquakeTableViewController alloc] initWithStyle:UITableViewStylePlain];
    SODAEarthquakeMapViewController *earthquakeMapViewController = [[SODAEarthquakeMapViewController alloc] init];

    UINavigationController *tableNavigationController = [[UINavigationController alloc] initWithRootViewController:earthquakeTableViewController];
    tableNavigationController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Table View" image:[UIImage imageNamed:@"179-notepad"] tag:0];
    UINavigationController *mapNavigationController = [[UINavigationController alloc] initWithRootViewController:earthquakeMapViewController];
    mapNavigationController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Map View" image:[UIImage imageNamed:@"103-map"] tag:1];

    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    tabBarController.viewControllers = @[tableNavigationController, mapNavigationController];

    [self.window setRootViewController:tabBarController];


    [self.window makeKeyAndVisible];
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
}


@end
