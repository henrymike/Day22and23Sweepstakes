//
//  ViewController.m
//  Sweepstakes
//
//  Created by Mike Henry on 10/21/15.
//  Copyright © 2015 Mike Henry. All rights reserved.
//

#import "ViewController.h"
#import <Parse/Parse.h>

@interface ViewController ()

@end

@implementation ViewController

#pragma mark - Parse Methods

- (void)tempAddRecords {
    PFObject *entry1 = [PFObject objectWithClassName:@"Entries"];
    entry1[@"firstName"] = @"John";
    entry1[@"lastName"] = @"Smith";
    entry1[@"city"] = @"Charleston";
    entry1[@"state"] = @"SC";
    entry1[@"email"] = @"testemail@gmail.com";
    entry1[@"phone"] = @"843-321-4545";
    entry1[@"winner"] = [NSNumber numberWithBool:false];
    entry1[@"userID"] = @"System";
    [entry1 saveInBackground];
}


#pragma mark - Life Cycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
//    PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
//    testObject[@"foo"] = @"bar";
//    [testObject saveInBackground];
    
    [self tempAddRecords];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
