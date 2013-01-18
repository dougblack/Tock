//
//  Timer.h
//  Times
//
//  Created by Douglas Black on 12/24/12.
//  Copyright (c) 2012 Doug Black. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

typedef enum {
    FlagTypeNone,
    FlagTypeGreen,
    FlagTypeRed
} FlagType;

@class TimerCell;
@interface Timer : NSObject <NSCopying>

@property (nonatomic) BOOL running;

@property (nonatomic) NSTimeInterval goalLap;
@property (nonatomic) NSTimeInterval avgLap;
@property (nonatomic) NSTimeInterval lapSum;

@property (nonatomic) NSInteger lapNumber;
@property (nonatomic) NSInteger row;

@property (nonatomic) NSString *timeString;
@property (nonatomic) NSString *lastLapString;
@property (nonatomic) NSString *name;

@property (nonatomic) NSMutableArray *laps;
@property (nonatomic) NSMutableArray *lapStrings;
@property (nonatomic) NSMutableArray *timeOfLapStrings;

@property (nonatomic) TimerCell *delegate;

@property (nonatomic) UIColor *thumb;
 
@property (nonatomic) FlagType flagType;
@property (nonatomic) AVAudioPlayer *timerClick;

+(NSString*)stringFromTimeInterval:(NSTimeInterval)timeInterval;

-(void)calculateGoalPaceFromMinutes:(NSInteger)minutes andSeconds:(NSInteger)seconds andTenths:(NSInteger)tenths;

-(void)toggle;
-(void)start;
-(void)lap;
-(void)stop;
-(void)reset;

@end
