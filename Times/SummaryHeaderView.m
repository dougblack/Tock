//
//  SummaryHeaderView.m
//  Times
//
//  Created by Douglas Black on 1/5/13.
//  Copyright (c) 2013 Doug Black. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "SummaryHeaderView.h"
#import "CommonCLUtility.h"

@implementation SummaryHeaderView

- (id)initWithThumb:(UIColor*)thumb andTimerNumber:(NSInteger)timerNumber
{
    self = [super init];
    if (self) {
        [self setBackgroundColor:[CommonCLUtility viewBackgroundColor]];
        
        UIView *thumbView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 60)];
        [thumbView setBackgroundColor:thumb];
//        [thumbView.layer setCornerRadius:3];
        [self addSubview:thumbView];
        
        UILabel *timerLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 60)];
        [timerLabel setTextAlignment:NSTextAlignmentLeft];
        [timerLabel setTextColor:[UIColor whiteColor]];
        [timerLabel setShadowColor:[UIColor darkGrayColor]];
        [timerLabel setShadowOffset:CGSizeMake(-1, -1)];
        [timerLabel setText:@"Timer"];
        [timerLabel setFont:[UIFont boldSystemFontOfSize:25]];
        [timerLabel setBackgroundColor:[UIColor clearColor]];
        [self addSubview:timerLabel];
        
        UILabel* numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(280, 0, 30, 60)];
        [numberLabel setTextAlignment:NSTextAlignmentCenter];
        [numberLabel setTextColor:[UIColor whiteColor]];
        [numberLabel setShadowColor:[UIColor darkGrayColor]];
        [numberLabel setShadowOffset:CGSizeMake(-1, -1)];
        [numberLabel setText:[NSString stringWithFormat:@"%d", timerNumber]];
        [numberLabel setFont:[UIFont boldSystemFontOfSize:25]];
        [numberLabel setBackgroundColor:[UIColor clearColor]];
        [self addSubview:numberLabel];
        [self setOpaque:YES];
    }
    return self;
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
