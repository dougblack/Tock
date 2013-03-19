//
//  Timer.m
//  Times
//
//  Created by Douglas Black on 12/24/12.
//  Copyright (c) 2012 Doug Black. All rights reserved.
//

#import "Timer.h"
#import "TimerCell.h"
#import "TockSoundPlayer.h"

@interface Timer ()

@property BOOL recentlyStopped;

@property NSTimeInterval startTime;
@property NSTimeInterval lastLapTime;
@property NSTimeInterval currentTime;
@property NSTimeInterval timeDelta;
@property NSTimeInterval currentLapDelta;
@property NSTimeInterval timeOfLastStop;

@property BOOL started;
@property BOOL stopped;

@end

@implementation Timer

-(id) init
{
    self = [super init];
    if (self)
    {
        self.running = NO;
        self.lapNumber = 1;
        self.timeDelta = 0;
        self.currentLapDelta = 0;
        self.recentlyStopped = NO;
        self.avgLap = 0;
        self.flagType = FlagTypeNone;
        self.timeString = @"00:00.0";
        self.lastLapString = @"--:--.-";
        self.name = @"TIMER";
        self.goalLap = -1;
    }
    return self;
}

#pragma mark - Time methods

/* Called to start the timer. Sets correct state then calls updateTime */
-(void) start
{
    self.startTime = [NSDate timeIntervalSinceReferenceDate];
    
    /* Check to see if this timer being resumed, or if its starting from 0 */
    if (self.started == YES)
    {
        NSTimeInterval timeOfStart = [NSDate timeIntervalSinceReferenceDate];
        NSTimeInterval timeSinceLastStop = timeOfStart - [self timeOfLastStop];
        
        self.timeDelta = self.currentTime;
        self.currentLapDelta = timeSinceLastStop;
    } else {
        self.lastLapTime = self.startTime;
        self.laps = [NSMutableArray array];
        self.lapStrings = [NSMutableArray array];
        self.timeOfLapStrings = [NSMutableArray array];
    }

    self.started = YES;
    self.running = YES;
    self.stopped = NO;
    self.flagType = FlagTypeGreen;

    [self updateTime];
}

/* This is where the actual timing happens. */
/* Notifies the listening object every 0.1 seconds of the new time */
-(void) updateTime
{
    if (self.running == NO) {
        return;
    }
    
    // Schedule another update in 0.1 seconds.
    [self performSelector:@selector(updateTime) withObject:self afterDelay:0.1];
    
    NSTimeInterval timeSinceStart = [NSDate timeIntervalSinceReferenceDate];
    NSTimeInterval elapsed = timeSinceStart - [self startTime] + [self timeDelta];
    
    self.currentTime = elapsed;
    
    NSString* newTimeString = [Timer stringFromTimeInterval:elapsed];
    
    self.timeString = newTimeString;
    [self.delegate tick:newTimeString withLap:self.lapNumber];
}

/* Take a split and store it. */
-(void) lap
{
    /* Ignore if stopped. */
    if (self.running == NO || self.stopped == YES)
    {
        return;
    }
    
    NSTimeInterval currentTime = [NSDate timeIntervalSinceReferenceDate];
    NSTimeInterval elapsedSinceLastLap = (currentTime - [self lastLapTime]) - [self currentLapDelta];
    
    NSString* thisLapString = [Timer stringFromTimeInterval:elapsedSinceLastLap];
    
    /* Add new values to appropriate arrays. */
    [self.lapStrings addObject:thisLapString];
    [self.laps addObject:[NSNumber numberWithDouble:elapsedSinceLastLap]];
    [self.timeOfLapStrings addObject:self.timeString];
    
    self.lastLapTime = currentTime;
    self.lastLapString = thisLapString;
    self.lapNumber++;
    
    /* If this is the first lap since resume, start delta from this lap */
    if ([self recentlyStopped])
    {
        self.currentLapDelta = 0;
        self.recentlyStopped = NO;
    }
    
    self.lapSum = self.lapSum + elapsedSinceLastLap;
    self.avgLap = self.lapSum / [self.laps count];
    
    /* Send a message to delgate. */
    [self.delegate lastLapTimeChanged:thisLapString];
}

/* Stop the timer. */
-(void) stop
{
    NSTimeInterval currentTime = [NSDate timeIntervalSinceReferenceDate];
    NSTimeInterval elapsedSinceLastLap = currentTime - [self lastLapTime];
    
    self.running = NO;
    self.stopped = YES;
    self.recentlyStopped = YES;
    self.currentLapDelta = elapsedSinceLastLap;
    self.timeOfLastStop = [NSDate timeIntervalSinceReferenceDate];
    
    self.flagType = FlagTypeRed;
}

-(void) toggle
{
    if (self.running && self.started) {
        [self stop];
    } else if (!self.started || self.stopped) {
        [self start];
    }
}

-(void) reset
{
    self.running = NO;
    self.started = NO;
    self.stopped = NO;
    self.timeString = @"00:00.0";
    self.lastLapString = @"--:--.-";
    self.currentLapDelta = 0;
    self.timeDelta = 0;
    self.lapNumber = 1;
    self.laps = [NSMutableArray array];
    self.lapStrings = [NSMutableArray array];
    self.timeOfLapStrings = [NSMutableArray array];
    self.timeDelta = 0;
    self.flagType = FlagTypeNone;
}


-(void)calculateGoalPaceFromMinutes:(NSInteger)minutes andSeconds:(NSInteger)seconds andTenths:(NSInteger)tenths
{
    NSTimeInterval goalTime = (tenths / 10.0) + (seconds) + (minutes*60.0);
    self.goalLap = goalTime;
}

#pragma mark - static methods

+(NSString*) stringFromTimeInterval:(NSTimeInterval)timeInterval
{
    int mins = (int) (timeInterval / 60.0);
    timeInterval = timeInterval - (mins * 60);
    int secs = (int) (timeInterval);
    timeInterval = timeInterval - (secs);
    int tenths = timeInterval * 10.0;
    timeInterval = timeInterval - tenths;
    
    return [NSString stringWithFormat:@"%02u:%02u.%u", mins, secs,tenths];
}

+(NSString*) minimizedStringFromTimeInterval:(NSTimeInterval)timeInterval
{
    NSTimeInterval elapsed = timeInterval;
    int mins = (int) (elapsed / 60.0);
    elapsed = elapsed - (mins * 60);
    int secs = (int) (elapsed);
    elapsed = elapsed - (secs);
    int tenths = elapsed * 10.0;
    elapsed = elapsed - tenths;
    
    if (elapsed > 60)
        return [NSString stringWithFormat:@"%02u:%02u.%u", mins, secs,tenths];
    else if (elapsed >= 10)
        return [NSString stringWithFormat:@"%02u.%u", secs, tenths];
    else
        return [NSString stringWithFormat:@"%u.%u", secs, tenths];
}

#pragma mark - NSCoding delegate methods

-(void) encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeDouble:self.goalLap forKey:@"goalLap"];
    [encoder encodeDouble:self.avgLap forKey:@"avgLap"];
    [encoder encodeDouble:self.lapSum forKey:@"avgSum"];
    [encoder encodeInteger:self.lapNumber forKey:@"lapNumber"];
    [encoder encodeInteger:self.row forKey:@"row"];
    [encoder encodeObject:self.timeString forKey:@"timeString"];
    [encoder encodeObject:self.lastLapString forKey:@"lastLapString"];
    [encoder encodeObject:self.name forKey:@"name"];
    [encoder encodeObject:self.laps forKey:@"laps"];
    [encoder encodeObject:self.lapStrings forKey:@"lapStrings"];
    [encoder encodeObject:self.timeOfLapStrings forKey:@"timeOfLapStrings"];
    [encoder encodeObject:self.delegate forKey:@"delegate"];
    [encoder encodeObject:self.thumb forKey:@"thumb"];
    [encoder encodeInteger:self.flagType forKey:@"flagType"];
    [encoder encodeObject:self.timerClick forKey:@"timerClick"];
    [encoder encodeBool:self.running forKey:@"running"];
    [encoder encodeBool:self.stopped forKey:@"stopped"];
    [encoder encodeBool:self.started forKey:@"started"];
    [encoder encodeBool:self.recentlyStopped forKey:@"recentlyStopped"];
    [encoder encodeDouble:self.startTime forKey:@"startTime"];
    [encoder encodeDouble:self.lastLapTime forKey:@"lastLapTime"];
    [encoder encodeDouble:self.currentTime forKey:@"currentTime"];
    [encoder encodeDouble:self.timeDelta forKey:@"timeDelta"];
    [encoder encodeDouble:self.currentLapDelta forKey:@"currentLapDelta"];
    [encoder encodeDouble:self.timeOfLastStop forKey:@"timeOfLastStop"];
}

-(id) initWithCoder:(NSCoder *)decoder
{
    
    self = [super init];
    if (self) {
        self.timeString = [decoder decodeObjectForKey:@"timeString"];
        self.lastLapString = [decoder decodeObjectForKey:@"lastLapString"];
        self.name = [decoder decodeObjectForKey:@"name"];
        self.laps = [decoder decodeObjectForKey:@"laps"];
        self.lapStrings = [decoder decodeObjectForKey:@"lapStrings"];
        self.timeOfLapStrings = [decoder decodeObjectForKey:@"timeOfLapStrings"];
        self.delegate = [decoder decodeObjectForKey:@"delegate"];
        self.thumb = [decoder decodeObjectForKey:@"thumb"];
        self.timerClick = [decoder decodeObjectForKey:@"timerClick"];
        self.goalLap = [decoder decodeDoubleForKey:@"goalLap"];
        self.avgLap = [decoder decodeDoubleForKey:@"avgLap"];
        self.lapSum = [decoder decodeDoubleForKey:@"lapSum"];
        self.startTime = [decoder decodeDoubleForKey:@"startTime"];
        self.lastLapTime = [decoder decodeDoubleForKey:@"lastLapTime"];
        self.currentTime = [decoder decodeDoubleForKey:@"currentTime"];
        self.timeDelta = [decoder decodeDoubleForKey:@"timeDelta"];
        self.currentLapDelta = [decoder decodeDoubleForKey:@"currentLapDelta"];
        self.timeOfLastStop = [decoder decodeDoubleForKey:@"timeOfLastStop"];
        self.running = [decoder decodeBoolForKey:@"running"];
        self.stopped = [decoder decodeBoolForKey:@"stopped"];
        self.started = [decoder decodeBoolForKey:@"started"];
        self.recentlyStopped = [decoder decodeBoolForKey:@"recentlyStopped"];
        self.lapNumber = [decoder decodeIntegerForKey:@"lapNumber"];
        self.row = [decoder decodeIntegerForKey:@"row"];
        self.flagType = [decoder decodeIntegerForKey:@"flagType"];
        
    }
    
    return self;
    
}

@end
