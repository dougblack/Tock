//
//  LapTimerView.m
//  Times
//
//  Created by Douglas Black on 12/31/12.
//  Copyright (c) 2012 Doug Black. All rights reserved.
//

#import "LapTimerView.h"
#import "Timer.h"
#import "LapTableView.h"
#import "LapViewController.h"
#import "TriangleView.h"
#import "CommonCLUtility.h"

@implementation LapTimerView

@synthesize lapNumber;
@synthesize running;
@synthesize lapViewController;
@synthesize lapTableView;

- (id)initWithFrame:(CGRect)frame andTimer:(Timer*)timer
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setTimer:timer];
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
        [backView setBackgroundColor:[CommonCLUtility viewDarkBackColor]];
        [self addSubview:backView];
        UIFont *cellFont = [UIFont fontWithName:@"HelveticaNeue-Bold" size:40.0];
        UIView *shadowView = [[UIView alloc] initWithFrame:CGRectMake(7.0, 7.0, 306, 86)];
        [shadowView setBackgroundColor:[CommonCLUtility outlineColor]];
        [self addSubview:shadowView];
        
        UIView *thumbLightView = [[UIView alloc] initWithFrame:CGRectMake(9.0, 9.0, 65, 82)];
        [thumbLightView setBackgroundColor:[CommonCLUtility highlightColor]];
        UIView *thumbBackView = [[UIView alloc] initWithFrame:CGRectMake(10.0, 10.0, 63, 80)];
        if ([[self timer] thumb])
            [thumbBackView setBackgroundColor:[[self timer] thumb]];
        else
            [thumbBackView setBackgroundColor:[CommonCLUtility backgroundColor]];
        [thumbBackView setTag:13];
        [thumbBackView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)]];
        [self addSubview:thumbLightView];
        [self addSubview:thumbBackView];
        
        UIView *timeLightView = [[UIView alloc] initWithFrame:CGRectMake(76, 9.0, 168, 82)];
        [timeLightView setBackgroundColor:[CommonCLUtility highlightColor]];
        UIView *timeBackView = [[UIView alloc] initWithFrame:CGRectMake(77, 10.0, 166, 80)];
        [timeBackView setBackgroundColor:[CommonCLUtility backgroundColor]];
        [timeBackView setTag:14];
        [timeBackView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)]];
        UILongPressGestureRecognizer *timeResetRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
        [timeResetRecognizer setMinimumPressDuration:1];
        [timeBackView addGestureRecognizer:timeResetRecognizer];
        [self addSubview:timeLightView];
        [self addSubview:timeBackView];
        
        UIView *lapLightView = [[UIView alloc] initWithFrame:CGRectMake(246, 9.0, 65, 82)];
        [lapLightView setBackgroundColor:[CommonCLUtility highlightColor]];
        UIView *lapBackView = [[UIView alloc] initWithFrame:CGRectMake(247.0, 10.0, 63, 80)];
        [lapBackView setBackgroundColor:[CommonCLUtility backgroundColor]];
        [lapBackView setTag:15];
        [lapBackView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)]];
        [self addSubview:lapLightView];
        [self addSubview:lapBackView];
        
        UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(77, 39, 166, 45)];
        [timeLabel setText:[[self timer] timeString]];
        [timeLabel setOpaque:NO];
        [timeLabel setBackgroundColor:[UIColor clearColor]];
        [timeLabel setTextColor:[UIColor whiteColor]];
        [timeLabel setFont:cellFont];
        [timeLabel setTextAlignment:NSTextAlignmentCenter];
        [timeLabel setTag:11];
        [timeLabel setUserInteractionEnabled:NO];
        [self addSubview:timeLabel];
        
        UILabel *lastLapLabel = [[UILabel alloc] initWithFrame:CGRectMake(77, 2, 166, 45)];
        [lastLapLabel setText:[[self timer] lastLapString]];
        [lastLapLabel setOpaque:NO];
        [lastLapLabel setBackgroundColor:[UIColor clearColor]];
        [lastLapLabel setTextColor:[CommonCLUtility weakTextColor]];
        [lastLapLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:15]];
        [lastLapLabel setTextAlignment:NSTextAlignmentCenter];
        [lastLapLabel setTag:16];
        [self addSubview:lastLapLabel];
        
        UILabel *lapLabel = [[UILabel alloc] initWithFrame:CGRectMake(247, 39, 63, 45)];
        [lapLabel setText:[NSString stringWithFormat:@"%d",[[self timer] lapNumber]]];
        [lapLabel setOpaque:NO];
        [lapLabel setBackgroundColor:[UIColor clearColor]];
        [lapLabel setTextColor:[UIColor whiteColor]];
        [lapLabel setFont:cellFont];
        [lapLabel setTextAlignment:NSTextAlignmentCenter];
        [lapLabel setTag:12];
        [lapLabel setAdjustsFontSizeToFitWidth:YES];
        [self addSubview:lapLabel];
        
        UILabel *lapTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(247, 2, 63, 45)];
        [lapTextLabel setText:@"LAP"];
        [lapTextLabel setOpaque:NO];
        [lapTextLabel setBackgroundColor:[UIColor clearColor]];
        [lapTextLabel setTextColor:[CommonCLUtility weakTextColor]];
        [lapTextLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:15]];
        [lapTextLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:lapTextLabel];
        
        TriangleView *triangle = [[TriangleView alloc] init];
        [triangle setFrame:CGRectMake(219, 9, 25, 25)];
        [triangle setBackgroundColor:[UIColor clearColor]];
        [triangle setHidden:YES];
        [triangle setTag:17];
        [self addSubview:triangle];
        
        [[self timer] setDelegate:self];
        
        [self setUserInteractionEnabled:YES];
    }
    return self;
}


-(void)handleTap:(UITapGestureRecognizer*)sender
{
    UIView *senderView = (UIView*)sender.view;
    if (sender.state == UIGestureRecognizerStateRecognized)
    {
        int tag = senderView.tag;
        [senderView setBackgroundColor:[CommonCLUtility selectedColor]];
        switch (tag) {
            case 14: // time
                [self highlight:senderView withDuration:0.5 andWait:0];
                [[self timer] toggle];
                break;
            case 15: // lap
                [self highlight:senderView withDuration:0.5 andWait:0];
                [[self timer] lap];
                [[self lapTableView] reloadData];
                break;
                
            default:
                break;
        }
        
    }
}

-(void)handleLongPress:(UILongPressGestureRecognizer*)sender
{
    if ([[self timer] running]) // ignore if currently running
        return;
    
    [[self timer] reset];
    [self reset];
    [[self lapViewController] setTimer:[self timer]];
    [[self lapTableView] reloadData];
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch *touch in touches) {
        UIView *view = [touch view];
        CGPoint point = [touch locationInView:self];
        NSLog(@"Touches. %f, %f", point.x, point.y);
        if (view.tag == 13 || view.tag == 14 || view.tag == 15)
        {
            view.backgroundColor = [CommonCLUtility selectedColor];
        }
    }
}

-(void) touchesMoved:(NSSet*)touches withEvent:(UIEvent *)event
{
    for (UITouch *touch in touches) {
        UIView *view = [touch view];
        if (view.tag == 13 || view.tag == 14 || view.tag == 15)
        {
            view.backgroundColor = [CommonCLUtility backgroundColor];
        }
    }
}

-(void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch *touch in touches) {
        UIView *view = [touch view];
        if (view.tag == 13 || view.tag == 14 || view.tag == 15)
        {
            view.backgroundColor = [CommonCLUtility backgroundColor];
        }
    }
}

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch *touch in touches)
    {
        UIView *view = [touch view];
        if (view.tag == 13 || view.tag == 14 || view.tag == 15)
            view.backgroundColor = [CommonCLUtility backgroundColor];
    }
    
}

-(void)highlight:(UIView *)view withDuration:(NSTimeInterval)duration andWait:(NSTimeInterval)wait
{
    [UIView beginAnimations:@"Fade Out" context:nil];
    [UIView setAnimationDelay:wait];
    [UIView setAnimationDuration:duration];
    view.backgroundColor = [CommonCLUtility backgroundColor];
    [UIView commitAnimations];
}

-(void)start
{
    [[self viewWithTag:17] setHidden:NO];
    [(TriangleView*)[self viewWithTag:17] setRed:NO];
    [(TriangleView*)[self viewWithTag:17] setNeedsDisplay];
}

-(void) reset
{
    [self setUserInteractionEnabled:YES];
    [self.timer setDelegate:self];
    [(UILabel*)[self viewWithTag:11] setText:[[self timer] timeString]];
    [(UILabel*)[self viewWithTag:16] setText:[[self timer] lastLapString]];
    if ([[self timer] thumb] != nil)
        [[self viewWithTag:13] setBackgroundColor:[[self timer] thumb]];
    else
        [[self viewWithTag:13] setBackgroundColor:[CommonCLUtility backgroundColor]];
    [(UILabel*)[self viewWithTag:12] setText:[NSString stringWithFormat:@"%d", [[self timer]lapNumber]]];
    if ([[self timer] running]) {
        [(TriangleView*)[self viewWithTag:17] setHidden:NO];
        [(TriangleView*)[self viewWithTag:17] setRed:NO];
    }
    else if ([[self timer] stopped]) {
        [(TriangleView*)[self viewWithTag:17] setHidden:NO];
        [(TriangleView*)[self viewWithTag:17] setRed:YES];
    }
    else
        [(TriangleView*)[self viewWithTag:17] setHidden:YES];
    
    [self setNeedsDisplay];
}

-(void) tick:(NSString *)time withLap:(NSInteger)lap
{
    [self setTime:time];
    [(UILabel*)[self viewWithTag:11] setText:time];
    [(UILabel*)[self viewWithTag:12] setText:[NSString stringWithFormat:@"%d", (int)lap]];
    [self setLapNumber:[NSString stringWithFormat:@"%d", (int)lap]];
    
}

-(void)lastLapTimeChanged:(NSString*)lapTime
{
    [(UILabel*)[self viewWithTag:16] setText:[NSString stringWithFormat:@"%@", lapTime]];
}

-(void) stop
{
    [self setRunning:NO];
    [(TriangleView*)[self viewWithTag:17] setRed:YES];
    [(TriangleView*)[self viewWithTag:17] setNeedsDisplay];
}

@end
