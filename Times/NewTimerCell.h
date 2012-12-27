//
//  NewTimerCell.h
//  Times
//
//  Created by Douglas Black on 12/25/12.
//  Copyright (c) 2012 Doug Black. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NewTimerCellContentView.h"
#import "TimesTableViewController.h"

@class TimesTableViewController;
@class NewTimerCellContentView;
@interface NewTimerCell : UITableViewCell

@property NewTimerCellContentView *content;
@property TimesTableViewController *timesTable;

-(void)setTimesTable:(TimesTableViewController*)timesTable;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andTimesTable:(TimesTableViewController*)timesTable;

@end
