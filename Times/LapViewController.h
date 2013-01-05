//
//  LapViewController.h
//  Times
//
//  Created by Douglas Black on 12/30/12.
//  Copyright (c) 2012 Doug Black. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@class Timer;
@class TimesTableView;
@interface LapViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property NSInteger numOfLaps;
@property NSMutableArray *laps;
@property NSMutableArray *lapStrings;
@property TimesTableView *timesTableView;
@property Timer *timer;
@property UIView *timerHeader;

@end
