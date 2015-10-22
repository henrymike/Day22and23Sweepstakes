//
//  EntriesTableViewCell.h
//  Sweepstakes
//
//  Created by Mike Henry on 10/21/15.
//  Copyright © 2015 Mike Henry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EntriesTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *fullNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *cityStateLabel;
@property (nonatomic, weak) IBOutlet UILabel *emailLabel;
@property (nonatomic, weak) IBOutlet UILabel *phoneLabel;
@property (nonatomic, weak) IBOutlet UILabel *winCountLabel;
@property (nonatomic, weak) IBOutlet UILabel *regDateLabel;

@end
