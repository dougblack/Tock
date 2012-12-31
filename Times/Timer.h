//
//  Timer.h
//  Times
//
//  Created by Douglas Black on 12/24/12.
//  Copyright (c) 2012 Doug Black. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TimerCell.h"

@class TimerCell;
@interface Timer : NSObject

@property NSTimeInterval startTime;
@property NSTimeInterval lastLapTime;
@property NSInteger lapNumber;
@property BOOL running;
@property BOOL started;
@property BOOL stopped;
@property NSString *timeString;
@property NSTimeInterval currentTime;
@property NSString *lastLapString;
@property NSMutableArray *laps;
@property TimerCell *delegate;
@property NSInteger row;
@property UIColor *thumb;
@property NSTimeInterval timeDelta;


-(void)start;
-(void)lap;
-(void)stop;
-(void)toggle;
-(void)reset;

@end
