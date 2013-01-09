//
//  SettingsCell.m
//  Tock
//
//  Created by Douglas Black on 1/9/13.
//  Copyright (c) 2013 Doug Black. All rights reserved.
//

#import "SettingsCell.h"
#import "CommonCLUtility.h"

@interface SettingsCell ()

@property UILabel *settingNameLabel;
@property UISwitch *settingSwitch;

@end

@implementation SettingsCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIFont *cellFont = [UIFont fontWithName:@"HelveticaNeue-Bold" size:15.0];
        
        UIView *shadowView = [[UIView alloc] initWithFrame:CGRectMake(7.0, 0, 306, 49)];
        [shadowView setBackgroundColor:[CommonCLUtility outlineColor]];
        [self.contentView addSubview:shadowView];
        
        UIView *lapLightView = [[UIView alloc] initWithFrame:CGRectMake(9.0, 2, 302, 45)];
        [lapLightView setBackgroundColor:[CommonCLUtility highlightColor]];
        UIView *lapBackView = [[UIView alloc] initWithFrame:CGRectMake(10.0, 3, 300, 43)];
        [lapBackView setBackgroundColor:[CommonCLUtility backgroundColor]];
        [self.contentView addSubview:lapLightView];
        [self.contentView addSubview:lapBackView];
        
        UILabel *settingNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 3, 200, 43)];
        [settingNameLabel setTextColor:[UIColor whiteColor]];
        [settingNameLabel setBackgroundColor:[UIColor clearColor]];
        [settingNameLabel setTextAlignment:NSTextAlignmentLeft];
        [settingNameLabel setFont:cellFont];
        [settingNameLabel setTag:21];
        self.settingNameLabel = settingNameLabel;
        [self.contentView addSubview:settingNameLabel];
        
        self.settingSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(218, 12, 95, 27)];
        [self.settingSwitch setOn:YES];
        [self.contentView addSubview:self.settingSwitch];
    }
    return self;
}

-(void)refresh
{
    if (self.settingType == SettingTypeSwitch)
        self.settingSwitch.hidden = NO;
    else if (self.settingType == SettingTypeSelectable)
        self.settingSwitch.hidden = YES;
    self.settingNameLabel.text = self.settingName;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
