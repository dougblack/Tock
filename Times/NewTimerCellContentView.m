//
//  NewTimerCellContentView.m
//  Times
//
//  Created by Douglas Black on 12/25/12.
//  Copyright (c) 2012 Doug Black. All rights reserved.
//

#import "NewTimerCellContentView.h"

@implementation NewTimerCellContentView

@synthesize selected, timesTable;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.opaque = NO;
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    CGRect background = CGRectMake(10.0, 10.0, 300, 80);
    CGRect outline = CGRectMake(9.0, 9.0, 302, 82);
    CGRect shadow = CGRectMake(7.0, 7.0, 306, 86);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(context, 0.0, 0.0, 0.0, 1.0);
    CGContextFillRect(context, shadow);
    CGContextSetRGBFillColor(context, 0.35, 0.35, 0.35, 1.0);
    CGContextFillRect(context, outline);
    CGContextSetShadow(context, CGSizeMake(0,0), 0);
    if (self.selected == NO) {
        CGContextSetRGBFillColor(context, 0.26, 0.26, 0.26, 1.0);
    } else {
        CGContextSetRGBFillColor(context, 0.19, 0.19, 0.19, 1.0);
    }
    
    CGContextFillRect(context, background);
    
    NSString *prompt = @"+";
    CGContextSaveGState(context);
    CGContextSetShadowWithColor(context, CGSizeMake(1,1), 0, [UIColor colorWithRed:0.35 green:0.35 blue:0.35 alpha:1].CGColor);
    [[UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1] set];
    [prompt drawAtPoint:CGPointMake(140.0, 5.0) withFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:60.0]];
    CGContextRestoreGState(context);
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

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSArray *allTouches = [touches allObjects];
    
    for (UITouch *touch in allTouches)
    {
        CGPoint point = [touch locationInView:self];
        [self processTouchStart:touch];
    }
}

-(void)processTouchStart:(UITouch*)touch
{
    CGPoint point = [touch locationInView:self];
    if (point.x >= 10 && point.x <= 310) {
        [self setSelected:YES];
    }
    [self setNeedsDisplay];
    [[[self timesTable] tableView] setScrollEnabled:NO];
//    [[timesTable tableView] reloadData];
}

-(void)processTouchEnd:(UITouch*)touch
{
    CGPoint point = [touch locationInView:self];
    if (point.x >= 10 && point.x <= 310) {
        [timesTable newTimer];
        [self setSelected:NO];
    }
    [self setSelected:NO];
    [self setNeedsDisplay];
    [[[self timesTable] tableView] setScrollEnabled:YES];
//    [[timesTable tableView] reloadData];
}


@end
