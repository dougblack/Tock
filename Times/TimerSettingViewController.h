//
//  TimerSettingViewController.h
//  Times
//
//  Created by Douglas Black on 1/6/13.
//  Copyright (c) 2013 Doug Black. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimerSettingViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic) NSMutableArray *goalLapMinutes;
@property (nonatomic) NSMutableArray *goalLapSeconds;
@property (nonatomic) NSMutableArray *goalLapTenths;
@property (nonatomic) UINavigationController *superController;

@end
