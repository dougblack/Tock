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
        self.name = @"Timer";
    }
    return self;
}

-(void) start
{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"ClickButton" ofType:@"wav"];
    NSURL *clickURL = [[NSURL alloc] initFileURLWithPath:path];
    NSError *clickError = [NSError new];
    self.timerClick = [[AVAudioPlayer alloc] initWithContentsOfURL:clickURL error:&clickError];
    self.timerClick.volume = 1.0;
    [self.timerClick play];

    [self setStartTime:[NSDate timeIntervalSinceReferenceDate]];
    
    if (self.started == YES)
    {
        NSTimeInterval timeOfStart = [NSDate timeIntervalSinceReferenceDate];
        NSTimeInterval timeSinceLastStop = timeOfStart - [self timeOfLastStop];
        [self setTimeDelta:[self currentTime]];
        [self setCurrentLapDelta:timeSinceLastStop];
    } else {
        [self setLastLapTime:[self startTime]];
        [self setLaps:[NSMutableArray array]];
        [self setLapStrings:[NSMutableArray array]];
    }
    
    [self setStarted:YES];
    [self setRunning:YES];
    [self setStopped:NO];
    [self setFlagType:FlagTypeGreen];

    [[self delegate] start];
    [self updateTime];
}

-(void) updateTime
{
    if ([self running] == NO) {
        [[self delegate] stop];
        return;
    }
    
    [self performSelector:@selector(updateTime) withObject:self afterDelay:0.1];
    
    NSTimeInterval timeSinceStart = [NSDate timeIntervalSinceReferenceDate];
    NSTimeInterval elapsed = timeSinceStart - [self startTime] + [self timeDelta];
    [self setCurrentTime:elapsed];
    
    NSString* timeString = [Timer stringFromTimeInterval:elapsed];
    
    [self setTimeString:timeString];
    [[self delegate] tick:[self timeString] withLap:self.lapNumber];

}

-(void) tick:(NSString *)time withLap:(NSInteger*)lap
{
    [self setTimeString:time];
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
    [self.laps addObject:[NSNumber numberWithDouble:elapsed]];
    [self.timesAtLaps addObject:[NSNumber numberWithDouble:[self currentTime]]];
    [self setLastLapTime:currentTime];
    [self setLastLapString:thisLapString];
    [self.lapStrings addObject:thisLapString];
    [self setLapNumber:self.lapNumber+1];
    
    if ([self recentlyStopped])
    {
        [self setCurrentLapDelta:0];
        [self setRecentlyStopped:NO];
    }
    
    self.lapSum = self.lapSum + elapsed;
    self.avgLap = self.lapSum / [self.laps count];
    [[self delegate] lastLapTimeChanged:self.lastLapString];
}

-(void) stop
{
    NSTimeInterval currentTime = [NSDate timeIntervalSinceReferenceDate];
    NSTimeInterval elapsedSinceLastLap = currentTime - [self lastLapTime];
    
    [self setRunning:NO];
    [self setStopped:YES];
    [self setRecentlyStopped:YES];
    [self setCurrentLapDelta:elapsedSinceLastLap];
    [self setTimeOfLastStop:[NSDate timeIntervalSinceReferenceDate]];
    
    [self setFlagType:FlagTypeRed];
    [[self delegate] stop];
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
    [self setRunning:NO];
    [self setStarted:NO];
    [self setStopped:NO];
    [self setTimeString:@"00:00.0"];
    [self setLastLapString:@"--:--.-"];
    [self setCurrentLapDelta:0];
    [self setTimeDelta:0];
    [self setLapNumber:1];
    [self setLaps:[NSMutableArray array]];
    [self setLapStrings:[NSMutableArray array]];
    [self setTimeDelta:0];
    [self setFlagType:FlagTypeNone];
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
