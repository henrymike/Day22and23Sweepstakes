//
//  AppDelegate.h
//  Sweepstakes
//
//  Created by Mike Henry on 10/21/15.
//  Copyright © 2015 Mike Henry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow  *window;
@property (nonatomic, strong) NSArray   *entriesArray;
@property (nonatomic, strong) NSString  *sortString;


- (void)getEntriesData;

@end

