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
@property NSString *timeString;
@property NSMutableArray *laps;
@property TimerCell *delegate;


-(void)start;
-(void)pause;
-(void)lap;
-(void)stop;
-(void)toggle;

@end
