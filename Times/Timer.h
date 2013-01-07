//
//  Timer.h
//  Times
//
//  Created by Douglas Black on 12/24/12.
//  Copyright (c) 2012 Doug Black. All rights reserved.
//

#import <Foundation/Foundation.h>


@class TimerCell;
@interface Timer : NSObject <NSCopying>

@property BOOL running;
@property BOOL started;
@property BOOL stopped;
@property BOOL recentlyStopped;

@property NSTimeInterval startTime;
@property NSTimeInterval lastLapTime;
@property NSTimeInterval currentTime;
@property NSTimeInterval timeDelta;
@property NSTimeInterval currentLapDelta;
@property NSTimeInterval timeOfLastStop;
@property NSTimeInterval goalLap;
@property NSTimeInterval avgLap;

@property NSInteger lapNumber;
@property NSInteger row;

@property NSString *timeString;
@property NSString *lastLapString;

@property NSMutableArray *laps;
@property NSMutableArray *lapStrings;
@property NSMutableArray *timesAtLaps;

@property TimerCell *delegate;
@property UIColor *thumb;
@property UIColor *miniThumb;

+(NSString*)stringFromTimeInterval:(NSTimeInterval)timeInterval;

-(void)toggle;
-(void)start;
-(void)lap;
-(void)stop;
-(void)reset;

@end
