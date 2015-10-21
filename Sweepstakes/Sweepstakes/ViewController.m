//
//  ViewController.m
//  Sweepstakes
//
//  Created by Mike Henry on 10/21/15.
//  Copyright © 2015 Mike Henry. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import <Parse/Parse.h>

@interface ViewController ()

@property (nonatomic, strong)               AppDelegate     *appDelegate;
@property (nonatomic, weak)     IBOutlet    UITableView     *entriesTableView;

@end

@implementation ViewController

#pragma mark - Table View Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"NRIS");
    NSLog(@"Count:%lu",_appDelegate.entriesArray.count);
    return _appDelegate.entriesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"CFRAIP");
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"entriesCell"];
    PFObject *selectedResult = _appDelegate.entriesArray[indexPath.row];
    cell.textLabel.text = [selectedResult objectForKey:@"firstName"];
    cell.detailTextLabel.text = [[selectedResult objectForKey:@"winner"] stringValue];
    
    return cell;
}


#pragma mark - Parse Methods

- (void)tempAddRecords {
//    PFObject *entry1 = [PFObject objectWithClassName:@"Entries"];
//    entry1[@"firstName"] = @"John";
//    entry1[@"lastName"] = @"Smith";
//    entry1[@"city"] = @"Charleston";
//    entry1[@"state"] = @"SC";
//    entry1[@"email"] = @"testemail@gmail.com";
//    entry1[@"phone"] = @"843-321-4545";
//    entry1[@"winner"] = [NSNumber numberWithInt:0];
//    entry1[@"userID"] = @"System";
//    [entry1 saveInBackground];
    
    PFObject *entry2 = [PFObject objectWithClassName:@"Entries"];
    entry2[@"firstName"] = @"Sally";
    entry2[@"lastName"] = @"Sue";
    entry2[@"city"] = @"Alexandria";
    entry2[@"state"] = @"VA";
    entry2[@"email"] = @"testemail22@gmail.com";
    entry2[@"phone"] = @"805-221-3287";
    entry2[@"winner"] = [NSNumber numberWithInt:0];
    entry2[@"userID"] = @"System";
    [entry2 saveInBackground];
}

- (void)gotEntriesFromServer {
    [_entriesTableView reloadData];
}

#pragma mark - Life Cycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    _appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gotEntriesFromServer) name:@"gotEntriesNotification" object:nil];
    [_appDelegate getEntriesData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
