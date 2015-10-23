//
//  ViewController.m
//  Sweepstakes
//
//  Created by Mike Henry on 10/21/15.
//  Copyright © 2015 Mike Henry. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "EntriesTableViewCell.h"
#import <Parse/Parse.h>

@interface ViewController ()

@property (nonatomic, strong)               AppDelegate         *appDelegate;
@property (nonatomic, weak)     IBOutlet    UITableView         *entriesTableView;
@property (nonatomic, weak)     IBOutlet    UIDatePicker        *minDatePicker;
@property (nonatomic, weak)     IBOutlet    UIDatePicker        *maxDatePicker;
@property (nonatomic, weak)     IBOutlet    UIBarButtonItem     *winnersBarButtonItem;
@property (nonatomic, weak)     IBOutlet    UISegmentedControl  *sortSegmentedControl;

@end

@implementation ViewController

//#pragma mark - Variables
//
//NSDate *minDate = 0;
//NSDate *maxDate = 0;


#pragma mark - Interactivity Methods

- (IBAction)generateWinnerButtonPressed:(UIBarButtonItem *)button {
    int randomWinner = arc4random_uniform((uint32_t)_appDelegate.entriesArray.count);
    NSLog(@"Random Winner:%i",randomWinner);
    PFObject *winner = [_appDelegate.entriesArray objectAtIndex:randomWinner];
    NSLog(@"Winner Name is:%@",[NSString stringWithFormat:@"%@",[winner objectForKey:@"firstName"]]);
    int winCount = [[winner objectForKey:@"winner"] intValue] + 1;
    NSLog(@"%@ Win Count:%i",[winner objectForKey:@"firstName"],winCount);
    
    winner[@"winner"] = [NSNumber numberWithInt:winCount];
    winner[@"winnerDate"] = [NSDate date];
    [winner saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        [_entriesTableView reloadData];
    }];

}

- (IBAction)sortOrderChanged:(UISegmentedControl *)sortOrder {
//    NSString *value = [_sortSegmentedControl titleForSegmentAtIndex:sortOrder.selectedSegmentIndex];
//    NSLog(@"Sort order %@",value);
    if ((sortOrder.selectedSegmentIndex = 0)) {
        _appDelegate.sortString = @"firstName";
    } else if ((sortOrder.selectedSegmentIndex = 1)) {
        _appDelegate.sortString = @"lastName";
    } else if ((sortOrder.selectedSegmentIndex = 2)) {
        _appDelegate.sortString = @"state";
    }
    NSLog(@"Print %@",_appDelegate.sortString);
//    _appDelegate.sortString = value;
    
}


#pragma mark - Table View Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    NSLog(@"NRIS");
//    NSLog(@"Count:%lu",_appDelegate.entriesArray.count);
    return _appDelegate.entriesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"CFRAIP");
    EntriesTableViewCell *cell = (EntriesTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"entriesCell"];
    PFObject *entrant = _appDelegate.entriesArray[indexPath.row];
    cell.fullNameLabel.text = [NSString stringWithFormat:@"%@ %@",[entrant objectForKey:@"firstName"],[entrant objectForKey:@"lastName"]];
    cell.cityStateLabel.text = [NSString stringWithFormat:@"%@, %@",[entrant objectForKey:@"city"],[entrant objectForKey:@"state"]];
    cell.emailLabel.text = [entrant objectForKey:@"email"];
    cell.phoneLabel.text = [entrant objectForKey:@"phone"];
    cell.winCountLabel.text =[NSString stringWithFormat:@"Win Count: %@",[[entrant objectForKey:@"winner"] stringValue]];
    cell.regDateLabel.text = [NSString stringWithFormat:@"%@", entrant.createdAt];
    
    // check for winner and highlight cell if true
    if ([[entrant objectForKey:@"winner"] integerValue] >= 1) {
        cell.backgroundColor = [UIColor greenColor];
    } else {
        cell.backgroundColor = [UIColor whiteColor];
    }
    
    return cell;
}

- (PFQuery *)filterWinnersByDate {
    NSLog(@"Date Filter pressed");
    PFQuery *dateSearch = [PFQuery queryWithClassName:@"Entries"];
//    [winnerSearch whereKey:@"winner" greaterThan:@0];
//    NSLog(@"%@",winnerSearch);
    
    [dateSearch whereKey:@"createdAt" greaterThanOrEqualTo:_minDatePicker.date];
    [dateSearch whereKey:@"createdAt" lessThanOrEqualTo:_maxDatePicker.date];
    [dateSearch addAscendingOrder:@"createdAt"];
    [dateSearch findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
//        for (PFObject *entry in objects) {
//            NSLog(@"Name query:%@",entry[@"firstName"]);
            _appDelegate.entriesArray = objects;
            [_entriesTableView reloadData];
//        }
    }];
    
    return 0;
}

- (IBAction)filterDatePressed:(id)sender {
    [self filterWinnersByDate];
//    NSLog(@"min:%@, max:%@",minDate, maxDate);
}

- (IBAction)filerWinnersPressed:(id)sender {
    if (([_winnersBarButtonItem.title isEqualToString:@"Show Winners"])) {
        NSLog(@"Winners filter");
        PFQuery *winnerSearch = [PFQuery queryWithClassName:@"Entries"];
        [winnerSearch whereKey:@"winner" greaterThan:@0];
        [winnerSearch addAscendingOrder:@"firstName"];
        [winnerSearch findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
            _winnersBarButtonItem.title = @"Show All";
            _appDelegate.entriesArray = objects;
            [_entriesTableView reloadData];
        }];
    } else {
        NSLog(@"Else filter");
        PFQuery *allSearch = [PFQuery queryWithClassName:@"Entries"];
        [allSearch addAscendingOrder:@"firstName"];
        [allSearch findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
            _appDelegate.entriesArray = objects;
            _winnersBarButtonItem.title = @"Show Winners";
            [_entriesTableView reloadData];
        }];
    }
}


#pragma mark - Date Picker View Methods

- (IBAction)minDateSelected:(UIDatePicker *)minDatePicker {
//    NSLog(@"%@",minDatePicker.date);
//    minDate = minDatePicker.date;
}

- (IBAction)maxDateSelected:(UIDatePicker *)maxDatePicker {
//    NSLog(@"%@",maxDatePicker.date);
//    maxDate = maxDatePicker.date;
    
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
