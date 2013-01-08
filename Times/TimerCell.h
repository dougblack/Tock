//
//  TimerCell.h
//  Times
//
//  Created by Douglas Black on 12/23/12.
//  Copyright (c) 2012 Doug Black. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@class TimerCellContentView;
@class TimesViewController;
@class Timer;
@class TimerSettingViewController;
@interface TimerCell : UITableViewCell <UINavigationControllerDelegate, UITextFieldDelegate>

@property TimesViewController *timesTable;
@property Timer *timer;

@property UIColor *thumb;
@property NSString *time;
@property NSString *lapNumber;

@property NSInteger row;
@property NSMutableArray *movableViews;

@property AVAudioPlayer *audioPlayer;


-(void) tick:(NSString*)time withLap:(NSInteger)lapNumber;
-(void) lastLapTimeChanged:(NSString*)lastLap;
-(void) refresh;

@end
