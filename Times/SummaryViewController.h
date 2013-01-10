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

typedef enum {
    DisplayByLap,
    DisplayByTimer
} DisplayType;

@class SummaryTableView;
@class TimesViewController;
@interface SummaryViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITabBarDelegate>

@property (nonatomic) SummaryTableView *tableView;

@property (nonatomic) NSMutableArray *timers;
@property (nonatomic) NSMutableArray *timersData;

@property (nonatomic) NSMutableArray *arrayOfLaps;

@property (nonatomic) NSIndexPath *selectedRow;
@property (nonatomic) NSArray *colorArray;
@property (nonatomic) TimesViewController* timesViewController;

@property (nonatomic) DeltaType deltaType;
@property (nonatomic) AVAudioPlayer *audioPlayer;

@property DisplayType displayType;
@property int mostLaps;

- (id)initWithTimers:(NSMutableArray*)timers;

@end
