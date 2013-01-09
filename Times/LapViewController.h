//
//  LapViewController.h
//  Times
//
//  Created by Douglas Black on 12/30/12.
//  Copyright (c) 2012 Doug Black. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <AVFoundation/AVFoundation.h>

@class Timer;
@class TimesTableView;
@interface LapViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) NSInteger numOfLaps;
@property (nonatomic) NSMutableArray *laps;
@property (nonatomic) NSMutableArray *lapStrings;
@property (nonatomic) TimesTableView *timesTableView;
@property (nonatomic) Timer *timer;
@property (nonatomic) UIView *timerHeader;

@property (nonatomic) AVAudioPlayer *audioPlayer;

@end
