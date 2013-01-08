//
//  Timer.m
//  Times
//
//  Created by Douglas Black on 12/24/12.
//  Copyright (c) 2012 Doug Black. All rights reserved.
//

#import "Timer.h"
#import "TimerCell.h"

@implementation Timer

-(id) init
{
    self = [super init];
    if (self)
    {
        self.running = NO;
        self.timeString = @"00:00.0";
        self.lastLapString = @"--:--.-";
        self.lapNumber = 1;
        self.timeDelta = 0;
        self.currentLapDelta = 0;
        self.recentlyStopped = NO;
        self.avgLap = 0;
        self.flagType = FlagTypeNone;
        self.name = @"TIMER";
    }
    return self;
}

-(void) start
{

//    // PLAY A SOUND ON START
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"click_low" ofType:@"wav"];
//    NSURL *clickURL = [[NSURL alloc] initFileURLWithPath:path];
//    NSError *clickError = [NSError new];
//    self.timerClick = [[AVAudioPlayer alloc] initWithContentsOfURL:clickURL error:&clickError];
//    self.timerClick.volume = 0.4;
//    [self.timerClick play];

    [self setStartTime:[NSDate timeIntervalSinceReferenceDate]];
    
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
    }

    self.started = YES;
    self.running = YES;
    self.stopped = NO;
    self.flagType = FlagTypeGreen;

    [self updateTime];
}

-(void) updateTime
{
    if (self.running == NO) {
        return;
    }
    
    // Schedule another update in 1 millisecond.
    [self performSelector:@selector(updateTime) withObject:self afterDelay:0.1];
    
    NSTimeInterval timeSinceStart = [NSDate timeIntervalSinceReferenceDate];
    NSTimeInterval elapsed = timeSinceStart - [self startTime] + [self timeDelta];
    
    self.current = elapsed;
    
    NSString* newTimeString = [Timer stringFromTimeInterval:elapsed];
    
    self.timeString = newTimeString;
    [self.delegate tick:newTimeString withLap:self.lapNumber];
}

-(void) lap
{
    if (self.running == NO || self.stopped == YES)
    {
        return;
    }
    
    NSTimeInterval currentTime = [NSDate timeIntervalSinceReferenceDate];
    NSTimeInterval elapsed = (currentTime - [self lastLapTime]) - [self currentLapDelta];
    
    NSString* thisLapString = [Timer stringFromTimeInterval:elapsed];
    
    // Add new values to appropriate arrays.
    [self.lapStrings addObject:thisLapString];
    [self.laps addObject:[NSNumber numberWithDouble:elapsed]];
    [self.timesAtLaps addObject:[NSNumber numberWithDouble:[self currentTime]]];
    
    self.lastLapTime = currentTime;
    self.lastLapString = thisLapString;
    self.lapNumber++;
    
    if ([self recentlyStopped])
    {
        self.currentLapDelta = 0;
        self.recentlyStopped = NO;
    }
    
    self.lapSum = self.lapSum + elapsed;
    self.avgLap = self.lapSum / [self.laps count];
    [self.delegate lastLapTimeChanged:thisLapString];
}

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
    self.timeDelta = 0;
    self.flagType = FlagTypeNone;
}

-(id) copyWithZone:(NSZone *)zone
{
    Timer* newTimer = [[Timer alloc] init];
    newTimer.startTime = [self startTime];
    newTimer.lastLapTime = [self lastLapTime];
    newTimer.running = [self running];
    newTimer.started = [self started];
    newTimer.stopped = [self stopped];
    newTimer.timeString = [[self timeString] copyWithZone:zone];
    newTimer.currentTime = [self currentTime];
    newTimer.lastLapString = [[self lastLapString] copyWithZone:zone];
    newTimer.laps = [[self laps] copyWithZone:zone];
    newTimer.lapStrings = [[self lapStrings] copyWithZone:zone];
    newTimer.row = [self row];
    newTimer.thumb = [[self thumb] copyWithZone:zone];
    newTimer.timeDelta = [self timeDelta];
    return newTimer;
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

@end
