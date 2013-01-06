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

@interface SummaryCell ()

@property UILabel *lapNumberLabel;
@property UILabel *lapStringLabel;
@property UILabel *lapDeltaLabel;

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
        [lapNumberLabel.layer setCornerRadius:2];
        self.lapNumberLabel = lapNumberLabel;
        [self.contentView addSubview:lapNumberLabel];
        
        UILabel* lapStringLabel = [[UILabel alloc] initWithFrame:CGRectMake(200, 10, 110, 40)];
        [lapStringLabel setTextAlignment:NSTextAlignmentCenter];
        [lapStringLabel setTextColor:[UIColor whiteColor]];
        [lapStringLabel setText:self.lapTimeString];
        [lapStringLabel setFont:[UIFont boldSystemFontOfSize:25]];
        [lapStringLabel setBackgroundColor:foreColor];
        [lapStringLabel.layer setCornerRadius:2];
        self.lapStringLabel = lapStringLabel;
        [self.contentView addSubview:lapStringLabel];
        
        UILabel *lapDeltaLabel = [[UILabel alloc] initWithFrame:CGRectMake(110, 10, 80, 40)];
        [lapDeltaLabel setTextAlignment:NSTextAlignmentCenter];
        [lapDeltaLabel setTextColor:[CommonCLUtility green]];
        [lapDeltaLabel setText:@"---"];
        [lapDeltaLabel setFont:[UIFont boldSystemFontOfSize:25]];
        [lapDeltaLabel setBackgroundColor:foreColor];
        [lapDeltaLabel.layer setCornerRadius:2];
        self.lapDeltaLabel = lapDeltaLabel;
//        [self.contentView addSubview:lapDeltaLabel];
        
        UIView *bottomBar = [[UIView alloc] initWithFrame:CGRectMake(0, 58, 320, 2)];
        [bottomBar setBackgroundColor:foreColor];
        [self.contentView addSubview:bottomBar];
        
        [self.contentView setBackgroundColor:[CommonCLUtility viewDarkBackColor]];
        self.opaque = YES;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

-(void)refresh
{
    [self.lapDeltaLabel setText:@"---"];
    [self.lapStringLabel setText:self.lapTimeString];
    [self.lapNumberLabel setText:[NSString stringWithFormat:@"%d", self.lapNumber]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end