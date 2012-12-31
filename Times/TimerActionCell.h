//
//  TimerActionCell.h
//  Times
//
//  Created by Douglas Black on 12/29/12.
//  Copyright (c) 2012 Doug Black. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TimesViewController.h"

@interface TimerActionCell : UITableViewCell

@property TimesViewController *timesController;
@property BOOL shouldShowStartAll;

@end
