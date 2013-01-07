//
//  TimerSettingViewController.h
//  Times
//
//  Created by Douglas Black on 1/6/13.
//  Copyright (c) 2013 Doug Black. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimerSettingViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property NSMutableArray *goalLapMinutes;
@property NSMutableArray *goalLapSeconds;
@property NSMutableArray *goalLapTenths;
@property UINavigationController *superController;

@end
