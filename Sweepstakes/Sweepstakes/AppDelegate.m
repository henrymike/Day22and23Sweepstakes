//
//  AppDelegate.m
//  Sweepstakes
//
//  Created by Mike Henry on 10/21/15.
//  Copyright © 2015 Mike Henry. All rights reserved.
//

#import "AppDelegate.h"
#import <Parse/Parse.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


#pragma mark - Parse Data Methods

- (void)getEntriesData {
    NSLog(@"Get data");
    PFQuery *data = [PFQuery queryWithClassName:@"Entries"];
    [data addAscendingOrder:@"firstName"];
//    if ([_sortString isEqualToString:@""]) {
//        [data addAscendingOrder:@"firstName"];
//    } else {
////        [data addAscendingOrder:@[NSString stringWithFormat:@"\"%@\"",_sortString]];
////        [data addAscendingOrder:@"%@",_sortString];
//    }

    [data findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        // could reload the view here when it's done getting items
        _entriesArray = objects;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"gotEntriesNotification" object:nil];
//        NSLog(@"ADArray:%@",_entriesArray);
//        NSLog(@"Got: %li",objects.count);
//        NSLog(@"LDArrayCount:%li",_entriesArray.count);
//        for (PFObject *logItem in objects) {
//            NSLog(@"Name:%@ Email:%@",[logItem objectForKey:@"firstName"],[logItem objectForKey:@"email"]);
//        }
    }];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Initialize Parse.
    [Parse setApplicationId:@"lkLnKy2XReXkPAhQpqIviuoR3YeYJkEehs8Xgfny"
                  clientKey:@"mlrjgnNxE7312stYxK0bP8rIBfX1NaTa2t8XgO1F"];
    
    // [Optional] Track statistics around application opens.
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    _entriesArray = [[NSArray alloc] init];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
