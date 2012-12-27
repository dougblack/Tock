//
//  TimerCell.h
//  Times
//
//  Created by Douglas Black on 12/23/12.
//  Copyright (c) 2012 Doug Black. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Timer.h"
#import "TimerCellContentView.h"
#import "TimesTableViewController.h"

@class TimerCellContentView;
@class TimesTableViewController;
@class Timer;
@interface TimerCell : UITableViewCell <UIImagePickerControllerDelegate>

@property TimesTableViewController *timesTable;
@property TimerCellContentView *timerCellContentView;
@property UIImagePickerController* imagePickerController;
@property UIView *thumb;
@property NSString *currentTime;
@property NSString *lapNumber;
@property Timer *timer;
@property BOOL running;

-(void) tick:(NSString*)time withLap:(NSInteger*)lapNumber;
-(void) lastLapTimeChanged:(NSString*)lastLap;
-(void) stop;
-(void) reset;
-(void) getThumb;

@end
