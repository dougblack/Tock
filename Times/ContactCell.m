//
//  SettingsCell.m
//  Tock
//
//  Created by Douglas Black on 1/9/13.
//  Copyright (c) 2013 Doug Black. All rights reserved.
//

#import "ContactCell.h"
#import "CommonCLUtility.h"

@interface ContactCell ()

@property UILabel *leftLabel;
@property UILabel *rightLabel;
@property UIView *backView;

@end

@implementation ContactCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIFont *cellBoldFont = [UIFont fontWithName:@"HelveticaNeue-Bold" size:15.0];
        UIFont *cellFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:15.0];
        
        UIView *shadowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 49)];
        [shadowView setBackgroundColor:[CommonCLUtility outlineColor]];
        [self.contentView addSubview:shadowView];
        
        UIView *lapLightView = [[UIView alloc] initWithFrame:CGRectMake(2, 2, 296, 45)];
        [lapLightView setBackgroundColor:[CommonCLUtility highlightColor]];
        UIView *lapBackView = [[UIView alloc] initWithFrame:CGRectMake(3, 3, 294, 43)];
        self.backView = lapBackView;
        [lapBackView setBackgroundColor:[CommonCLUtility backgroundColor]];
        [self.contentView addSubview:lapLightView];
        [self.contentView addSubview:lapBackView];
        
        UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 3, 150, 43)];
        [leftLabel setTextColor:[UIColor whiteColor]];
        [leftLabel setBackgroundColor:[UIColor clearColor]];
        [leftLabel setTextAlignment:NSTextAlignmentLeft];
        [leftLabel setFont:cellBoldFont];
        [leftLabel setTag:21];
        self.leftLabel = leftLabel;
        [self.contentView addSubview:leftLabel];
        
        UILabel *rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(150, 3, 135, 43)];
        [rightLabel setTextColor:[UIColor whiteColor]];
        [rightLabel setBackgroundColor:[UIColor clearColor]];
        [rightLabel setTextAlignment:NSTextAlignmentRight];
        [rightLabel setFont:cellFont];
        [rightLabel setTag:31];
        self.rightLabel = rightLabel;
        [self.contentView addSubview:rightLabel];
    }
    return self;
}

-(void)refresh
{
    self.leftLabel.text = self.leftString;
    self.rightLabel.text = self.rightString;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    if (highlighted) {
        self.backView.backgroundColor = [UIColor blackColor];
    } else {
        self.backView.backgroundColor = [CommonCLUtility backgroundColor];
    }
}

@end
