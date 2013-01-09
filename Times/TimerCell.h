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

@property (nonatomic) TimesViewController *timesTable;
@property (nonatomic) Timer *timer;

@property (nonatomic) UIColor *thumb;
@property (nonatomic) NSString *time;
@property (nonatomic) NSString *lapNumber;

@property (nonatomic) NSInteger row;
@property (nonatomic) NSMutableArray *movableViews;

-(void) tick:(NSString*)time withLap:(NSInteger)lapNumber;
-(void) lastLapTimeChanged:(NSString*)lastLap;
-(void) refresh;
-(void) showFlash:(NSString*)flashString;

@end
