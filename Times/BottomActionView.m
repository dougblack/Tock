//
//  TopActionView.m
//  Times
//
//  Created by Douglas Black on 1/1/13.
//  Copyright (c) 2013 Doug Black. All rights reserved.
//

#import "BottomActionView.h"
#import "TimesViewController.h"
#import "CommonCLUtility.h"

@implementation BottomActionView

@synthesize controller;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[CommonCLUtility viewDarkBackColor]];
        UIView *backView = [[UIView alloc] initWithFrame:frame];
        [backView setBackgroundColor:[CommonCLUtility viewDarkBackColor]];
        UIView *shadowView = [[UIView alloc] initWithFrame:CGRectMake(7, 7, 306, 60)];
        [shadowView setBackgroundColor:[CommonCLUtility outlineColor]];
        UIView *highlightView = [[UIView alloc] initWithFrame:CGRectMake(9, 9, 302, 56)];
        [highlightView setBackgroundColor:[CommonCLUtility highlightColor]];
        UIView *mainBackView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 300, 54)];
        [mainBackView setBackgroundColor:[CommonCLUtility backgroundColor]];
        
        UILabel *startLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 300, 54)];
        [startLabel setBackgroundColor:[UIColor colorWithRed:0.158 green:0.37 blue:0.029 alpha:1]];
        [startLabel setText:@"START ALL TIMERS"];
        [startLabel setTextColor:[UIColor whiteColor]];
        [startLabel setFont:[UIFont boldSystemFontOfSize:18]];
        [startLabel setShadowColor:[UIColor colorWithRed:0.1 green:0.3 blue:0 alpha:1]];
        [startLabel setShadowOffset:CGSizeMake(0, -2)];
        [startLabel setTextAlignment:NSTextAlignmentCenter];
        [startLabel setTag:31];
        [self addSubview:backView];
        [self addSubview:shadowView];
        [self addSubview:mainBackView];
        [self addSubview:startLabel];
        [self setOpaque:YES];
        
        [self setUserInteractionEnabled:YES];
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch *touch in touches)
    {
        CGPoint point = [touch locationInView:self];
        if (point.x >= 10 && point.x <= 310 && point.y >= 7 && point.y <= 72)
        {
            [[self viewWithTag:31] setBackgroundColor:[UIColor colorWithRed:0.058 green:0.27 blue:0 alpha:1]];
        }
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch* touch in touches) {
        CGPoint point = [touch locationInView:self];
        if (point.x >= 10 && point.x <= 310 && point.y >=7 && point.y <= 72)
        {
            [[self viewWithTag:31] setBackgroundColor:[UIColor colorWithRed:0.158 green:0.37 blue:0.029 alpha:1]];
            [self.controller startAll];
        }
    }
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [[self viewWithTag:31] setBackgroundColor:[UIColor colorWithRed:0.158 green:0.37 blue:0.029 alpha:1]];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
