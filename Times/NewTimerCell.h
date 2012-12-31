//
//  NewTimerCell.h
//  Times
//
//  Created by Douglas Black on 12/25/12.
//  Copyright (c) 2012 Doug Black. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TimesViewController.h"
#import "CommonCLUtility.h"

@class TimesViewController;
@class NewTimerCellContentView;
@interface NewTimerCell : UITableViewCell

@property TimesViewController *timesTable;

-(void)setTimesTable:(TimesViewController*)timesTable;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andTimesTable:(TimesViewController*)timesTable;

@end
