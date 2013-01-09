//
//  SettingsViewController.h
//  Tock
//
//  Created by Douglas Black on 1/9/13.
//  Copyright (c) 2013 Doug Black. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TimesViewController;
@interface SettingsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property TimesViewController *timesViewController;

@property NSMutableArray *settingNames;
@property NSMutableArray *settingType;

@property UITableView *tableView;

-(void)saveAndClose;

@end
