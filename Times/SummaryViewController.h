//
//  SummaryViewController.h
//  Times
//
//  Created by Douglas Black on 1/3/13.
//  Copyright (c) 2013 Doug Black. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SummaryTableView;
@interface SummaryViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property SummaryTableView *tableView;

@property NSMutableArray *timerLaps;

@property NSIndexPath *selectedRow;

@end
