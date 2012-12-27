//
//  TimerCellContentView.h
//  Times
//
//  Created by Douglas Black on 12/25/12.
//  Copyright (c) 2012 Doug Black. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TimerCell.h"

@class TimerCell;
@interface TimerCellContentView : UIView

@property NSString *time;
@property NSString *lapNumber;
@property NSString *lastLapTime;
@property UIImage *thumb;
@property BOOL *running;
@property BOOL *stopped;
@property BOOL *lapped;
@property BOOL *thumbSelected;
@property BOOL *timeSelected;
@property BOOL *lapSelected;
@property TimerCell *timerCell;

-(id)initWithFrame:(CGRect)rect andStartTime:(NSString *)time andStartLap:(NSString *)lap andTimerCell:(TimerCell *)cell;

@end
