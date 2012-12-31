//
//  TimerActionCell.m
//  Times
//
//  Created by Douglas Black on 12/29/12.
//  Copyright (c) 2012 Doug Black. All rights reserved.
//

#import "TimerActionCell.h"

@implementation TimerActionCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.shouldShowStartAll = YES;
        
        UIView *shadowView = [[UIView alloc] initWithFrame:CGRectMake(7.0, 7.0, 306, 86)];
        [shadowView setBackgroundColor:[CommonCLUtility outlineColor]];
        [self.contentView addSubview:shadowView];
        UIView *lightView = [[UIView alloc] initWithFrame:CGRectMake(9.0, 9.0, 302, 82)];
        [lightView setBackgroundColor:[CommonCLUtility highlightColor]];
        [self.contentView addSubview:lightView];
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(10.0, 10.0, 300, 80)];
        [backView setBackgroundColor:[UIColor colorWithRed:0.1 green:0.4 blue:0.13 alpha:1]];
        [backView setTag:1];
        [self.contentView addSubview:backView];
        
        UIButton *actionButton = [[UIButton alloc] initWithFrame:CGRectMake(10.0, 10.0, 300, 80)];
        actionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [actionButton setFrame:CGRectMake(10, 10, 300, 80)];
        [actionButton setTitle:@"START ALL TIMERS" forState:UIControlStateNormal];
        [actionButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [actionButton setTitleShadowColor:[UIColor colorWithRed:0.2 green:0.5 blue:0.23 alpha:1] forState:UIControlStateNormal];
        [[actionButton titleLabel] setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:22.0]];
        [[actionButton titleLabel] setShadowOffset:CGSizeMake(1,1)];
        [actionButton addTarget:self action:@selector(actionButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [actionButton addTarget:self action:@selector(actionButtonDown:) forControlEvents:UIControlEventTouchDown];
        [actionButton addTarget:self action:@selector(actionButtonCancel:) forControlEvents:UIControlEventTouchDragExit];
        [actionButton addTarget:self action:@selector(actionButtonCancel:) forControlEvents:UIControlEventTouchCancel];
        [actionButton setTag:2];
        [self.contentView addSubview:actionButton];
        [self setUserInteractionEnabled:YES];
    }
    return self;
}

-(void)highlight:(UIView *)view withDuration:(NSTimeInterval)duration andWait:(NSTimeInterval)wait
{
    [UIView beginAnimations:@"Fade In" context:nil];
    [UIView setAnimationDelay:wait];
    [UIView setAnimationDuration:duration];
    if (self.shouldShowStartAll)
        view.backgroundColor = [UIColor colorWithRed:0.4 green:0.1 blue:0.13 alpha:1];
    else
        view.backgroundColor = [UIColor colorWithRed:0.1 green:0.4 blue:0.13 alpha:1];
    [UIView commitAnimations];
}

-(void) actionButtonClicked:(id)sender
{
    [self highlight:[(UIView*)[self contentView] viewWithTag:1] withDuration:0.5 andWait:0];
    NSLog(@"START ALL TIMERS!");
    if (self.shouldShowStartAll)
    {
        [(UIButton*)[[self contentView] viewWithTag:2] setTitle:@"STOP TIMERS" forState:UIControlStateNormal];
        [(UIButton*)[[self contentView] viewWithTag:2] setTitleShadowColor:[UIColor colorWithRed:0.6 green:0.3 blue:0.33 alpha:1] forState:UIControlStateNormal];
        NSMutableArray *timers = [[self timesController] timers];
        for (int i = 0; i < [timers count]; i++) {
            if ([[timers objectAtIndex:i] running] == NO)
            {
                [(Timer*)[timers objectAtIndex:i] start];
            }
        }
    } else {
        [(UIButton*)[[self contentView] viewWithTag:2] setTitle:@"START TIMERS" forState:UIControlStateNormal];
        [(UIButton*)[[self contentView] viewWithTag:2] setTitleShadowColor:[UIColor colorWithRed:0.3 green:0.6 blue:0.33 alpha:1] forState:UIControlStateNormal];
        NSMutableArray *timers = [[self timesController] timers];
        for (int i = 0; i < [timers count]; i++) {
            if ([[timers objectAtIndex:i] running] == YES)
            {
                [(Timer*)[timers objectAtIndex:i] stop];
            }
        }
    }
    
    self.shouldShowStartAll = !self.shouldShowStartAll;
}

-(void) actionButtonDown:(id)sender
{
    [[[self contentView] viewWithTag:1] setBackgroundColor:[UIColor colorWithRed:0 green:0.3 blue:0.3 alpha:1]];
}

-(void) actionButtonCancel:(id)sender
{
    [[[self contentView] viewWithTag:1] setBackgroundColor:[UIColor colorWithRed:0.1 green:0.4 blue:0.13 alpha:1]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
