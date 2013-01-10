//
//  TimerSummaryCell.m
//  Tock
//
//  Created by Douglas Black on 1/9/13.
//  Copyright (c) 2013 Doug Black. All rights reserved.
//

#import "TimerSummaryCell.h"
#import "CommonCLUtility.h"

@interface TimerSummaryCell ()

@property UILabel *timerNameLabel;
@property UILabel *lapStringLabel;

@end

@implementation TimerSummaryCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIColor *foreColor = [CommonCLUtility backgroundColor];
        
        UILabel* timerNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 80, 40)];
        [timerNameLabel setTextAlignment:NSTextAlignmentCenter];
        [timerNameLabel setTextColor:[UIColor whiteColor]];
        [timerNameLabel setText:self.timerName];
        [timerNameLabel setFont:[UIFont boldSystemFontOfSize:20]];
        [timerNameLabel setBackgroundColor:foreColor];
        self.timerNameLabel = timerNameLabel;
        [self.contentView addSubview:timerNameLabel];
        
        UILabel* lapStringLabel = [[UILabel alloc] initWithFrame:CGRectMake(230, 10, 80, 40)];
        [lapStringLabel setTextAlignment:NSTextAlignmentCenter];
        [lapStringLabel setTextColor:[UIColor whiteColor]];
        [lapStringLabel setText:self.lapString];
        [lapStringLabel setFont:[UIFont boldSystemFontOfSize:20]];
        [lapStringLabel setBackgroundColor:foreColor];
        self.lapStringLabel = lapStringLabel;
        [self.contentView addSubview:lapStringLabel];
        
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
    self.timerNameLabel.text = self.timerName;
    self.timerNameLabel.backgroundColor = self.nameColor;
    self.lapStringLabel.text = self.lapString;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
