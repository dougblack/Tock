//
//  SummaryHeaderCell.m
//  Times
//
//  Created by Douglas Black on 1/6/13.
//  Copyright (c) 2013 Doug Black. All rights reserved.
//

#import "SummaryHeaderCell.h"
#import "CommonCLUtility.h"

@interface SummaryHeaderCell ()

@property UILabel *currentTimeLabel;
@property UILabel *averageTimeLabel;
@property UILabel *goalLapLabel;

@end

@implementation SummaryHeaderCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        

        UIColor *textColor = [UIColor whiteColor];
        UIFont *textFont = [UIFont boldSystemFontOfSize:17];
        
        UILabel *currentTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 80, 40)];
        [currentTimeLabel setTextColor:textColor];
        [currentTimeLabel setFont:textFont];
        [currentTimeLabel setTextAlignment:NSTextAlignmentCenter];
        [currentTimeLabel setBackgroundColor:[CommonCLUtility viewDarkBackColor]];
        [currentTimeLabel.layer setCornerRadius:2];
        currentTimeLabel.adjustsFontSizeToFitWidth = YES;
        self.currentTimeLabel = currentTimeLabel;
        [self.contentView addSubview:currentTimeLabel];
        
        UILabel *averageLapLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 10, 80, 40)];
        [averageLapLabel setTextColor:textColor];
        [averageLapLabel setFont:textFont];
        [averageLapLabel setTextAlignment:NSTextAlignmentCenter];
        [averageLapLabel setBackgroundColor:[CommonCLUtility viewDarkBackColor]];
        [averageLapLabel.layer setCornerRadius:2];
        averageLapLabel.adjustsFontSizeToFitWidth = YES;
        self.averageTimeLabel = averageLapLabel;
        [self.contentView addSubview:averageLapLabel];
        
        UILabel *goalLapLabel = [[UILabel alloc] initWithFrame:CGRectMake(230, 10, 80, 40)];
        [goalLapLabel setTextColor:textColor];
        [goalLapLabel setFont:textFont];
        [goalLapLabel setTextAlignment:NSTextAlignmentCenter];
        [goalLapLabel setBackgroundColor:[CommonCLUtility viewDarkBackColor]];
        [goalLapLabel.layer setCornerRadius:2];
        goalLapLabel.adjustsFontSizeToFitWidth = YES;
        self.goalLapLabel = goalLapLabel;
        [self.contentView addSubview:goalLapLabel];
        [self.contentView setBackgroundColor:[CommonCLUtility backgroundColor]];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.opaque = YES;
        
    }
    return self;
}

-(void)refresh
{
    self.currentTimeLabel.text = self.time;
    self.averageTimeLabel.text = self.avg;
    self.goalLapLabel.text = self.goal;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
