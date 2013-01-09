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

@end

@implementation SettingsCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIFont *cellFont = [UIFont fontWithName:@"HelveticaNeue-Bold" size:30.0];
        
        UIView *shadowView = [[UIView alloc] initWithFrame:CGRectMake(7.0, 0, 306, 59)];
        [shadowView setBackgroundColor:[CommonCLUtility outlineColor]];
        [self addSubview:shadowView];
        
        UIView *lapLightView = [[UIView alloc] initWithFrame:CGRectMake(9.0, 2, 302, 55)];
        [lapLightView setBackgroundColor:[CommonCLUtility highlightColor]];
        UIView *lapBackView = [[UIView alloc] initWithFrame:CGRectMake(10.0, 3, 300, 53)];
        [lapBackView setBackgroundColor:[CommonCLUtility backgroundColor]];
        [self addSubview:lapLightView];
        [self addSubview:lapBackView];
        
        UILabel *settingsNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 6, 200, 56)];
        [settingsNameLabel setTextColor:[UIColor whiteColor]];
        [settingsNameLabel setBackgroundColor:[UIColor clearColor]];
        [settingsNameLabel setTextAlignment:NSTextAlignmentCenter];
        [settingsNameLabel setFont:cellFont];
        [settingsNameLabel setTag:21];
        self.settingNameLabel = settingsNameLabel;
        [self addSubview:settingsNameLabel];
    }
    return self;
}

-(void)refresh
{
    self.settingNameLabel.text = self.settingName;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
