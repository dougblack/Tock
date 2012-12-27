//
//  TimerCellContentView.m
//  Times
//
//  Created by Douglas Black on 12/25/12.
//  Copyright (c) 2012 Doug Black. All rights reserved.
//

#import "TimerCellContentView.h"

@implementation TimerCellContentView

@synthesize time, lapNumber, running, stopped, lapped, timerCell, thumbSelected, timeSelected, lapSelected, lastLapTime, thumb;

- (id)initWithFrame:(CGRect)frame andStartTime:(NSString *)time andStartLap:(NSString *)lap andTimerCell:(id)cell
{
    if (self = [super initWithFrame:frame])
    {
        self.time = time;
        self.lapNumber = lap;
        self.opaque = NO;
        self.running = NO;
        self.timerCell = cell;
        self.thumbSelected = NO;
        self.timeSelected = NO;
        self.lapSelected = NO;
        self.lastLapTime = @"--:--:-";

    }
    return self;
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSArray *allTouches = [touches allObjects];
    
    for (UITouch *touch in allTouches)
    {
        CGPoint point = [touch locationInView:self];
        [self processTouchStart:touch];
    }
    
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSArray *allTouches = [touches allObjects];
    
    for (UITouch *touch in allTouches)
    {
        CGPoint point = [touch locationInView:self];
        [self processTouchEnd:touch];
    }

}

-(void)processTouchEnd:(UITouch*)touch
{
    CGPoint point = [touch locationInView:self];
    if (point.y < 10 || point.y > 90) {
        // TODO
    } else if (point.x >= 10 && point.x <= 74) {
        [[self timerCell] getThumb];
    } else if (point.x >= 76 && point.x <= 244) {
        [[[self timerCell] timer] toggle];
    } else if (point.x >= 246 && point.x <= 310) {
        [[[self timerCell] timer] lap];
    }
    self.lapSelected = NO;
    self.thumbSelected = NO;
    self.timeSelected = NO;
    [self setNeedsDisplay];
    [(UITableView*)[[self timerCell] superview] setScrollEnabled:YES];
    //    [(UITableView*)[[self timerCell] superview] reloadData];
}

-(void)processTouchStart:(UITouch*)touch
{
    CGPoint point = [touch locationInView:self];
    if (point.x >= 10 && point.x <= 74) {
        self.thumbSelected = YES;
    } else if (point.x >= 76 && point.x <= 244) {
        self.timeSelected = YES;
    } else if (point.x >= 246 && point.x <= 310) {
        self.lapSelected = YES;
    }
    [self setNeedsDisplay];
    [(UITableView*)[[self timerCell] superview] setScrollEnabled:NO];
//    [(UITableView*)[[self timerCell] superview] reloadData];
}

-(void)drawRect:(CGRect)rect
{
    // Make background rect
    CGRect background = CGRectMake(10.0, 10.0, 300, 80);
    CGRect outline = CGRectMake(9.0, 9.0, 302, 82);
    CGRect shadow = CGRectMake(7.0, 7.0, 306, 86);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(context, 0.0, 0.0, 0.0, 1);
    CGContextFillRect(context, shadow);
    CGContextSetRGBFillColor(context, 0.4, 0.4, 0.4, 1.0);
    CGContextFillRect(context, outline);
    CGContextSetShadow(context, CGSizeMake(0,0), 0);
    CGContextSetRGBFillColor(context, 0.26, 0.26, 0.26, 1.0);
    CGContextFillRect(context, background);
    
    CGRect thumbSelect = CGRectMake(10.0, 10.0, 65, 80);
    CGRect timeSelect = CGRectMake(76.0, 10.0, 170, 80);
    CGRect lapSelect = CGRectMake(245.0, 10.0, 65, 80);
    CGContextSetRGBFillColor(context, 0.19, 0.19, 0.19, 1);
    
    if (self.thumbSelected == YES) {
        CGContextFillRect(context, thumbSelect);
    } else if (self.timeSelected == YES) {
        CGContextFillRect(context, timeSelect);
    } else if (self.lapSelected == YES) {
        CGContextFillRect(context, lapSelect);
    }
    
    CGPoint leftPoints[] = {
        CGPointMake(75.0, 8.0),
        CGPointMake(75.0, 92.0)
    };
    CGPoint leftLightPoints[] = {
        CGPointMake(74.0, 10.0),
        CGPointMake(74.0, 90.0)
    };
    CGPoint leftRightLightPoints[] = {
        CGPointMake(76.0, 10.0),
        CGPointMake(76.0, 90.0)
    };
    CGPoint rightPoints[] = {
        CGPointMake(245.0, 8.0),
        CGPointMake(245.0, 92.0)
    };
    CGPoint rightLightPoints[] = {
        CGPointMake(244.0, 10.0),
        CGPointMake(244.0, 90.0)
    };
    CGPoint rightRightLightPoints[] = {
        CGPointMake(246.0, 10.0),
        CGPointMake(246.0, 90.0)
    };
    CGContextSetLineWidth(context, 1.0);
    CGContextSetRGBStrokeColor(context, 0.0, 0.0, 0.0, 1.0);
    CGContextAddLines(context, leftPoints, 2);
    CGContextAddLines(context, rightPoints, 2);
    CGContextStrokePath(context);
    CGContextSetRGBStrokeColor(context, 0.35, 0.35, 0.35, 1.0);
    CGContextAddLines(context, leftLightPoints, 2);
    CGContextAddLines(context, rightLightPoints, 2);
    CGContextAddLines(context, leftRightLightPoints, 2);
    CGContextAddLines(context, rightRightLightPoints, 2);
    CGContextStrokePath(context);


    CGContextSaveGState(context);

//    CGContextSetShadowWithColor(context, CGSizeMake(1,1), 0, [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1].CGColor);
//    [[UIColor colorWithRed:0 green:0 blue:0 alpha:1] set];
//    [@"LAP" drawAtPoint:CGPointMake(262.0, 12.0) withFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:15.0]];
////    [[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1] set];
////    CGContextSetShadowWithColor(context, CGSizeMake(0,-1), 0, [UIColor blackColor].CGColor);
//    [self.time drawAtPoint:CGPointMake(90.0, 25.0) withFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:40.0]];
//    [self.lapNumber drawAtPoint:CGPointMake(265.0, 31.0) withFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:40.0]];
//    CGContextRestoreGState(context);
//    CGContextSetShadowWithColor(context, CGSizeMake(1,1), 0, [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1].CGColor);
    
//    CGContextSetShadowWithColor(context, CGSizeMake(1,1), 0, [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1].CGColor);
    if ([self thumb] != nil) {
//        UIImageView *thumbView = [[UIImageView alloc] init];
//        thumbView.contentMode = UIViewContentModeScaleAspectFit;
//        thumbView.clipsToBounds = YES;
//        [thumbView setImage:[self thumb]];
//        [thumbView drawRect:CGRectMake(10.0, 10.0, 65.0, 80.0)];
        [[self thumb] drawInRect:CGRectMake(10, 10, 63, 80)];
    }
    CGContextSetShadowWithColor(context, CGSizeMake(0,0), 0, [UIColor blackColor].CGColor);
    [[UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1] set];
    [@"LAP" drawAtPoint:CGPointMake(264.0, 12.0) withFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:15.0]];
    [[NSString stringWithFormat:@"LAST LAP: %@", [self lastLapTime]] drawAtPoint:CGPointMake(92.0, 12) withFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:15.0]];
    [[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1] set];

    [self.time drawAtPoint:CGPointMake(90.0, 39.0) withFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:40.0]];
    [self.lapNumber drawAtPoint:CGPointMake(267.0, 39.0) withFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:40.0]];
    CGContextRestoreGState(context);
}

@end

