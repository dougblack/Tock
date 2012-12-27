//
//  Timer.m
//  Times
//
//  Created by Douglas Black on 12/24/12.
//  Copyright (c) 2012 Doug Black. All rights reserved.
//

#import "Timer.h"

@implementation Timer

@synthesize startTime, running, timeString, delegate, started, laps, lapNumber;

-(id) init
{
    self = [super init];
    if (self)
    {
        running = NO;
    }
    return self;
}

-(void) start
{
    self.lapNumber = 1;
    [self setStarted:YES];
    [self setRunning:YES];
    [self setStartTime:[NSDate timeIntervalSinceReferenceDate]];
    [self setLastLapTime:[self startTime]];
    self.laps = [NSMutableArray array];
    [self updateTime];
}

-(void) pause
{
    [self setRunning:NO];
}

-(void) updateTime
{
    if (running == NO) {
        [[self delegate] stop];
        return;
    }

    [self performSelector:@selector(updateTime) withObject:self afterDelay:0.1];
    
    NSTimeInterval currentTime = [NSDate timeIntervalSinceReferenceDate];
    NSTimeInterval elapsed = currentTime - startTime;
    
    int mins = (int) (elapsed / 60.0);
    elapsed = elapsed - (mins * 60);
    int secs = (int) (elapsed);
    elapsed = elapsed - (secs);
    int tenths = elapsed * 10.0;
    elapsed = elapsed - tenths;
    
    [[self delegate] tick:[NSString stringWithFormat: @"%02u:%02u.%u", mins, secs, tenths] withLap:self.lapNumber];

}

-(void) resume
{
    self.running = YES;
    
}

-(void) tick:(NSString *)time withLap:(NSInteger*)lap
{
    [self setTimeString:time];
}

-(void) lap
{
    NSTimeInterval currentTime = [NSDate timeIntervalSinceReferenceDate];
    NSTimeInterval elapsed = currentTime - self.lastLapTime;
    
    int mins = (int) (elapsed / 60.0);
    elapsed = elapsed - (mins * 60);
    int secs = (int) (elapsed);
    elapsed = elapsed - (secs);
    int tenths = elapsed * 10.0;
    elapsed = elapsed - tenths;
    
    [self.laps addObject:[NSNumber numberWithDouble:elapsed]];
    NSLog(@"Added lap %@", [NSString stringWithFormat: @"%02u:%02u.%u", mins, secs, tenths]);
    self.lastLapTime = currentTime;
    self.lapNumber = self.lapNumber + 1;
    
    [[self delegate] lastLapTimeChanged:[NSString stringWithFormat: @"%02u:%02u.%u", mins, secs, tenths]];
}

-(void) stop
{
    [self setRunning:NO];
}

-(void) toggle
{
    if (self.running && self.started) {
        [self stop];
    } else if (!self.started) {
        [self start];
    }
    
}

@end
