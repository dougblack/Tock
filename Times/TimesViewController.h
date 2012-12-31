//
//  TimesTable.h
//  Times
//
//  Created by Douglas Black on 12/23/12.
//  Copyright (c) 2012 Doug Black. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#import "TimerCell.h"
#import "NewTimerCell.h"
#import "TimerActionCell.h"
#import "TimesTableView.h"
#import "Timer.h"

@interface TimesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property NSInteger numTimers;
@property NSInteger numSections;
@property NSMutableArray *timers;
@property TimesTableView *tableView;

-(void)newTimer;

@end