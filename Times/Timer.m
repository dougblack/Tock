//
//  Timer.m
//  Times
//
//  Created by Douglas Black on 12/24/12.
//  Copyright (c) 2012 Doug Black. All rights reserved.
//

#import "Timer.h"

@implementation Timer

@synthesize startTime, running, timeString, delegate, started, laps, lapNumber, stopped, row, thumb, lastLapString, timeDelta;

-(id) init
{
    self = [super init];
    if (self)
    {
        running = NO;
        [self setTimeString:@"00:00.0"];
        [self setLastLapString:@"LAST LAP: --:--.-"];
        [self setLapNumber:1];
        [self setTimeDelta:0];
    }
    return self;
}

-(void) start
{
    if (self.started == YES)
    {
        [self setTimeDelta:[self currentTime]];
    }
    
    [self setLapNumber:1];
    [self setStarted:YES];
    [self setRunning:YES];
    [self setStopped:NO];
    [self setStartTime:[NSDate timeIntervalSinceReferenceDate]];
    [self setLastLapTime:[self startTime]];
    [self setLaps:[NSMutableArray array]];
    
    [[self delegate] start];
    
    [self updateTime];
}

-(void) updateTime
{
    if (running == NO) {
        [[self delegate] stop];
        return;
    }
    
    [self performSelector:@selector(updateTime) withObject:self afterDelay:0.1];
    
    NSTimeInterval currentTime = [NSDate timeIntervalSinceReferenceDate];
    NSTimeInterval elapsed = currentTime - startTime + timeDelta;
    [self setCurrentTime:elapsed];
    int mins = (int) (elapsed / 60.0);
    elapsed = elapsed - (mins * 60);
    int secs = (int) (elapsed);
    elapsed = elapsed - (secs);
    int tenths = elapsed * 10.0;
    elapsed = elapsed - tenths;
    
    [self setTimeString:[NSString stringWithFormat: @"%02u:%02u.%u", mins, secs, tenths]];
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
    NSTimeInterval elapsed = currentTime - self.lastLapTime;
    
    int mins = (int) (elapsed / 60.0);
    elapsed = elapsed - (mins * 60);
    int secs = (int) (elapsed);
    elapsed = elapsed - (secs);
    int tenths = elapsed * 10.0;
    elapsed = elapsed - tenths;
    
    [self.laps addObject:[NSNumber numberWithDouble:elapsed]];
    [self setLastLapTime:currentTime];
    [self setLastLapString:[NSString stringWithFormat:@"%02u:%02u.%u", mins, secs,tenths]];
    [self setLapNumber:self.lapNumber+1];
    
    [[self delegate] lastLapTimeChanged:self.lastLapString];
}

-(void) stop
{
    [self setRunning:NO];
    [self setStopped:YES];
    
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

@end
