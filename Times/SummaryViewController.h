//
//  SummaryViewController.h
//  Times
//
//  Created by Douglas Black on 1/3/13.
//  Copyright (c) 2013 Doug Black. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

typedef enum {
    DeltaFromPreviousLap,
    DeltaFromAverageLap,
    DeltaFromGoalLap,
    None
} DeltaType;

@class SummaryTableView;
@class TimesViewController;
@interface SummaryViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property SummaryTableView *tableView;

@property NSMutableArray *timers;
@property NSMutableArray *timersData;

@property NSIndexPath *selectedRow;
@property NSArray *colorArray;
@property TimesViewController* timesViewController;

@property DeltaType deltaType;
@property AVAudioPlayer *audioPlayer;


- (id)initWithTimers:(NSMutableArray*)timers;

@end
