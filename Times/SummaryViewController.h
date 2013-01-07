//
//  SummaryViewController.h
//  Times
//
//  Created by Douglas Black on 1/3/13.
//  Copyright (c) 2013 Doug Black. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    DeltaFromPreviousLap,
    DeltaFromAverageLap,
    DeltaFromGoalLap,
    None
} DeltaType;

@class SummaryTableView;
@interface SummaryViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property SummaryTableView *tableView;

@property NSMutableArray *timers;
@property NSMutableArray *timersData;

@property NSIndexPath *selectedRow;
@property NSArray *colorArray;

@property DeltaType deltaType;

- (id)initWithTimers:(NSMutableArray*)timers;

@end
