//
//  SummaryCell.m
//  Times
//
//  Created by Douglas Black on 1/3/13.
//  Copyright (c) 2013 Doug Black. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "SummaryCell.h"
#import "CommonCLUtility.h"
#import "SummaryViewController.h"
#import "SummaryTableView.h"
#import "Timer.h"

@interface SummaryCell ()

@property (nonatomic) UILabel *lapNumberLabel;
@property (nonatomic) UILabel *lapStringLabel;

@end

@implementation SummaryCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIColor *foreColor = [CommonCLUtility backgroundColor];
        
        UILabel* lapNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
        [lapNumberLabel setTextAlignment:NSTextAlignmentCenter];
        [lapNumberLabel setTextColor:[UIColor whiteColor]];
        [lapNumberLabel setText:[NSString stringWithFormat:@"%d", self.lapNumber]];
        [lapNumberLabel setFont:[UIFont boldSystemFontOfSize:25]];
        [lapNumberLabel setBackgroundColor:foreColor];
        self.lapNumberLabel = lapNumberLabel;
        [self.contentView addSubview:lapNumberLabel];
        
        UITapGestureRecognizer *lapTappedRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(flipLapString:)];        
        UILabel* lapStringLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 10, 80, 40)];
        [lapStringLabel setTextAlignment:NSTextAlignmentCenter];
        [lapStringLabel setTextColor:[UIColor whiteColor]];
        [lapStringLabel setText:self.lapTimeString];
        [lapStringLabel setFont:[UIFont boldSystemFontOfSize:20]];
        [lapStringLabel setBackgroundColor:foreColor];
        [self addGestureRecognizer:lapTappedRecognizer];
        self.lapStringLabel = lapStringLabel;
        [self.contentView addSubview:lapStringLabel];
        
        UILabel *lapDeltaLabel = [[UILabel alloc] initWithFrame:CGRectMake(230, 10, 80, 40)];
        [lapDeltaLabel setTextAlignment:NSTextAlignmentCenter];
        [lapDeltaLabel setTextColor:[CommonCLUtility green]];
        [lapDeltaLabel setText:@"---"];
        [lapDeltaLabel setFont:[UIFont boldSystemFontOfSize:20]];
        [lapDeltaLabel setBackgroundColor:foreColor];
        [lapDeltaLabel setAdjustsFontSizeToFitWidth:YES];
        self.lapDeltaLabel = lapDeltaLabel;
        self.lapDeltaLabel.hidden = YES;
        [self.contentView addSubview:lapDeltaLabel];

        
        UIView *bottomBar = [[UIView alloc] initWithFrame:CGRectMake(0, 58, 320, 2)];
        [bottomBar setBackgroundColor:foreColor];
        [self.contentView addSubview:bottomBar];
        
        [self.contentView setBackgroundColor:[CommonCLUtility viewDarkBackColor]];
        self.opaque = YES;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.userInteractionEnabled = YES;
    }
    return self;
}

-(void)flipLapString:(id)sender
{
    if (self.stringDisplayType == DisplayLap)
        self.stringDisplayType = DisplayTime;
    else
        self.stringDisplayType = DisplayLap;
    [[[self.controller.timersData objectAtIndex:(unsigned int)self.timerNumber] objectForKey:@"LapDisplayType"] setObject:[NSNumber numberWithInt:self.stringDisplayType] atIndex:(unsigned int)self.lapNumber-1];
    [self refresh];
}

-(void)refresh
{
    switch (self.deltaColor) {
        case DeltaIsRed:
            [self.lapDeltaLabel setTextColor:[UIColor redColor]];
            break;
        case DeltaIsGreen:
            [self.lapDeltaLabel setTextColor:[UIColor greenColor]];
            break;
        case DeltaIsGray:
            [self.lapDeltaLabel setTextColor:[UIColor grayColor]];
            break;
        default:
            break;
    }
    
    
    [self.lapDeltaLabel setText:self.lapDelta];
    if (self.stringDisplayType == DisplayLap) {
        [self.lapStringLabel setText:self.lapTimeString];
        self.lapStringLabel.backgroundColor = [CommonCLUtility backgroundColor];
    }
    else {
        [self.lapStringLabel setText:self.timeAtLapString];
        self.lapStringLabel.backgroundColor = self.timer.thumb;
    }
    
    [self.lapNumberLabel setText:[NSString stringWithFormat:@"%d", self.lapNumber]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end