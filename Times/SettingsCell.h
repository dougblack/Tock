//
//  SettingsCell.h
//  Tock
//
//  Created by Douglas Black on 1/9/13.
//  Copyright (c) 2013 Doug Black. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    SettingTypeSwitch,
    SettingTypeSelectable
} SettingType;

@interface SettingsCell : UITableViewCell

@property NSString* settingName;
@property SettingType settingType;

-(void)refresh;

@end
