//
//  GoalPickerView.m
//  Tock
//
//  Created by Douglas Black on 1/8/13.
//  Copyright (c) 2013 Doug Black. All rights reserved.
//

#import "GoalPickerView.h"
#import "CommonCLUtility.h"
#import "TimesViewController.h"
#import "Timer.h"
#import "TimerCell.h"

@implementation GoalPickerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.goalLapMinutes = [NSMutableArray array];
        self.goalLapSeconds = [NSMutableArray array];
        self.goalLapTenths = [NSMutableArray array];
        for (int i = 0; i < 60; i++) {
            NSNumber *number = [NSNumber numberWithInt:i];
            [self.goalLapSeconds addObject:number];
            [self.goalLapMinutes addObject:number];
        }
        for (int i = 0; i < 10; i++) {
            [self.goalLapTenths addObject:[NSNumber numberWithInt:i]];
        }
        
        UIPickerView *goalLapPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 320, 216)];
        goalLapPicker.opaque = YES;
        goalLapPicker.showsSelectionIndicator = YES;
        goalLapPicker.delegate = self;
        goalLapPicker.dataSource = self;
        self.goalLapPicker = goalLapPicker;
        [self addSubview:goalLapPicker];
        
        UIColor *softColor = [UIColor colorWithRed:0. green:0. blue:0. alpha:0.6];
        
        UILabel *minutesLabel = [[UILabel alloc] initWithFrame:CGRectMake(47, 98, 80, 20)];
        [minutesLabel setText:@"mins"];
        [minutesLabel setBackgroundColor:[UIColor clearColor]];
        [minutesLabel setFont:[UIFont boldSystemFontOfSize:20.0]];
        [minutesLabel setTextColor:softColor];
        [self addSubview:minutesLabel];
        
        UILabel *secondsLabel = [[UILabel alloc] initWithFrame:CGRectMake(148, 98, 80, 20)];
        [secondsLabel setText:@"secs"];
        [secondsLabel setFont:[UIFont boldSystemFontOfSize:20.0]];
        [secondsLabel setBackgroundColor:[UIColor clearColor]];
        [secondsLabel setTextColor:softColor];
        [self addSubview:secondsLabel];
        
        UILabel *tenthsLabel = [[UILabel alloc] initWithFrame:CGRectMake(240, 98, 80, 20)];
        [tenthsLabel setText:@"tenths"];
        [tenthsLabel setBackgroundColor:[UIColor clearColor]];
        [tenthsLabel setFont:[UIFont boldSystemFontOfSize:20.0]];
        [tenthsLabel setTextColor:softColor];
        [self addSubview:tenthsLabel];
        
        UIView *border = [[UIView alloc] initWithFrame:CGRectMake(7, 223, 306, 60)];
        [border setBackgroundColor:[UIColor blackColor]];
        [self addSubview:border];
        
        UIButton *setButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 226, 300, 54)];
        [setButton setTitle:@"LOCK GOAL PACE" forState:UIControlStateNormal];
        [setButton setBackgroundColor:[UIColor colorWithRed:0.52 green:0 blue:0.08 alpha:1]];
        setButton.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        [setButton addTarget:self action:@selector(setGoalPace) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:setButton];
        self.opaque = YES;
        [self setBackgroundColor:[CommonCLUtility viewDarkBackColor]];
        self.userInteractionEnabled = YES;
        
    }
    return self;
}

-(void)setGoalPace
{
    [self.timer calculateGoalPaceFromMinutes: [self.goalLapPicker selectedRowInComponent:0] andSeconds: [self.goalLapPicker selectedRowInComponent:1] andTenths: [self.goalLapPicker selectedRowInComponent:2] ];
    [self.timer.delegate showFlash:@"GOAL TIME SET"];
    [self.controller hidePickerView];
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            return 60;
            break;
        case 1:
            return 60;
            break;
        case 2:
            return 10;
        default:
            return -1;
            break;
    }
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            return [NSString stringWithFormat:@"%d", [[self.goalLapMinutes objectAtIndex:row] intValue]];
            break;
        case 1:
            return [NSString stringWithFormat:@"%d", [[self.goalLapSeconds objectAtIndex:row] intValue]];
            break;
        case 2:
            return [NSString stringWithFormat:@"%d", [[self.goalLapSeconds objectAtIndex:row] intValue]];
        default: // will never get called
            return @"";
            break;
    }
}

-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            return 100.0f;
            break;
        case 1:
            return 100.0f;
            break;
        case 2:
            return 100.0f;
            break;
        default:
            return 0.0f;
            break;
    }
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
}

@end
