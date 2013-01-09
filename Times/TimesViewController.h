//
//  TimesTable.h
//  Times
//
//  Created by Douglas Black on 12/23/12.
//  Copyright (c) 2012 Doug Black. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <AVFoundation/AVFoundation.h>

@class BottomActionView;
@class TimesTableView;
@class GoalPickerView;
@class Timer;
@interface TimesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) NSInteger numTimers;
@property (nonatomic) NSInteger numSections;
@property (nonatomic) NSMutableArray *timers;
@property (nonatomic) TimesTableView *tableView;
@property (nonatomic) BottomActionView *bottomActionView;
@property (nonatomic) NSArray *colors;
@property (nonatomic) NSInteger colorIndex;

@property (nonatomic) BOOL isShowingGoalPicker;

@property (nonatomic) GoalPickerView *goalPickerView;

@property (nonatomic) AVAudioPlayer *audioPlayer;

-(void)newTimer;
-(void)startAll;
-(void)checkTimers;
-(void)showPickerViewForTimer:(Timer*)timer;
-(void)hidePickerView;

@end
