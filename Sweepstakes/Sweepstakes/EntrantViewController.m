//
//  EntrantViewController.m
//  Sweepstakes
//
//  Created by Mike Henry on 10/23/15.
//  Copyright © 2015 Mike Henry. All rights reserved.
//

#import "AppDelegate.h"
#import <Parse/Parse.h>
#import "EntrantViewController.h"

@interface EntrantViewController ()

@property (nonatomic, weak) IBOutlet UITextField    *firstNameTextField;
@property (nonatomic, weak) IBOutlet UITextField    *lastNameTextField;
@property (nonatomic, weak) IBOutlet UITextField    *cityTextField;
@property (nonatomic, weak) IBOutlet UITextField    *stateTextField;
@property (nonatomic, weak) IBOutlet UITextField    *emailTextField;
@property (nonatomic, weak) IBOutlet UITextField    *phoneTextField;
@property (nonatomic, weak) IBOutlet UIButton       *submitButton;

@end

@implementation EntrantViewController

#pragma mark - Interactivity Methods

- (IBAction)submitButtonPressed:(id)sender {
    NSLog(@"Submit pressed");
    [self addNewEntry];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == _firstNameTextField) {
        [_lastNameTextField becomeFirstResponder];
    } else if (textField == _lastNameTextField) {
            [_cityTextField becomeFirstResponder];
    } else if (textField == _cityTextField) {
        [_stateTextField becomeFirstResponder];
    } else if (textField == _stateTextField) {
        [_emailTextField becomeFirstResponder];
    } else if (textField == _emailTextField) {
        [_phoneTextField becomeFirstResponder];
    } else {
        [textField resignFirstResponder];
    }
    return true;
}


#pragma mark - Parse Methods

- (void)addNewEntry {
    PFObject *newEntry = [PFObject objectWithClassName:@"Entries"];
    newEntry[@"firstName"] = _firstNameTextField.text;
    newEntry[@"lastName"] = _lastNameTextField.text;
    newEntry[@"city"] = _cityTextField.text;
    newEntry[@"state"] = _stateTextField.text;
    newEntry[@"email"] = _emailTextField.text;
    newEntry[@"phone"] = _phoneTextField.text;
    newEntry[@"winner"] = [NSNumber numberWithInt:0];
    newEntry[@"userID"] = @"App";
    [newEntry saveInBackground];
}

#pragma mark - Life Cycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
