//
//  SummaryHeaderCell.m
//  Times
//
//  Created by Douglas Black on 1/6/13.
//  Copyright (c) 2013 Doug Black. All rights reserved.
//

#import "SummaryHeaderCell.h"
#import "CommonCLUtility.h"
#import "Timer.h"

@interface SummaryHeaderCell ()

@property (nonatomic) UILabel *currentTimeLabel;
@property (nonatomic) UILabel *averageTimeLabel;
@property (nonatomic) UILabel *goalLapLabel;

@end

@implementation SummaryHeaderCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andTimer:(Timer*)timer
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        


        
    }
    return self;
}

-(void)refresh
{
    UIColor *textColor = [UIColor whiteColor];
    UIFont *textFont = [UIFont boldSystemFontOfSize:15];
    
    UILabel *currentTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 80, 40)];
    [currentTimeLabel setTextColor:textColor];
    [currentTimeLabel setFont:textFont];
    [currentTimeLabel setTextAlignment:NSTextAlignmentCenter];
    [currentTimeLabel setBackgroundColor:[CommonCLUtility viewDarkBackColor]];
    currentTimeLabel.numberOfLines = 2;
    currentTimeLabel.adjustsFontSizeToFitWidth = YES;
    self.currentTimeLabel = currentTimeLabel;
    [self.contentView addSubview:currentTimeLabel];
    
    UILabel *averageLapLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 10, 80, 40)];
    [averageLapLabel setTextColor:textColor];
    [averageLapLabel setFont:textFont];
    [averageLapLabel setTextAlignment:NSTextAlignmentCenter];
    [averageLapLabel setBackgroundColor:[CommonCLUtility viewDarkBackColor]];
    averageLapLabel.adjustsFontSizeToFitWidth = YES;
    averageLapLabel.numberOfLines = 2;
    self.averageTimeLabel = averageLapLabel;
    [self.contentView addSubview:averageLapLabel];
    
    UILabel *goalLapLabel = [[UILabel alloc] initWithFrame:CGRectMake(230, 10, 80, 40)];
    [goalLapLabel setTextColor:textColor];
    [goalLapLabel setFont:textFont];
    [goalLapLabel setTextAlignment:NSTextAlignmentCenter];
    [goalLapLabel setBackgroundColor:[CommonCLUtility viewDarkBackColor]];
    goalLapLabel.adjustsFontSizeToFitWidth = YES;
    goalLapLabel.numberOfLines = 2;
    self.goalLapLabel = goalLapLabel;
    [self.contentView addSubview:goalLapLabel];
    [self.contentView setBackgroundColor:self.timer.thumb];

    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.opaque = YES;
    self.currentTimeLabel.text = [@"TOTAL\n" stringByAppendingString:self.time];
    self.averageTimeLabel.text = [@"AVG\n" stringByAppendingString:self.avg];
    self.goalLapLabel.text = [@"GOAL\n" stringByAppendingString:self.goal];
    [self.contentView setBackgroundColor:self.timer.thumb];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
