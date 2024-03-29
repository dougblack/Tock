//
//  SummaryCell.h
//  Times
//
//  Created by Douglas Black on 1/3/13.
//  Copyright (c) 2013 Doug Black. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    DeltaIsRed,
    DeltaIsGreen,
    DeltaIsGray
} DeltaColor;

typedef enum {
    DisplayLap,
    DisplayTime
} StringDisplayType;

@class DropDownTableView;
@class SummaryViewController;
@class Timer;

@interface SummaryCell : UITableViewCell

@property (nonatomic) NSInteger lapNumber;
@property (nonatomic) NSTimeInterval lapTime;
@property (nonatomic) NSString *lapTimeString;
@property (nonatomic) NSString *lapDelta;
@property (nonatomic) NSString *timeAtLapString;
@property (nonatomic) NSTimeInterval deltaFromPrevious;
@property (nonatomic) NSTimeInterval deltaFromAverage;
@property (nonatomic) NSTimeInterval deltaFromGoal;

@property (nonatomic) NSInteger timerNumber;

@property (nonatomic) Timer* timer;

@property (nonatomic) UILabel *lapDeltaLabel;
@property (nonatomic) DeltaColor deltaColor;
@property (nonatomic) StringDisplayType stringDisplayType;

@property (nonatomic) SummaryViewController *controller;

-(void)refresh;

@end
