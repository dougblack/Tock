//
//  GoalPickerView.h
//  Tock
//
//  Created by Douglas Black on 1/8/13.
//  Copyright (c) 2013 Doug Black. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TimesViewController;
@class Timer;
@interface GoalPickerView : UIView <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic) NSMutableArray *goalLapMinutes;
@property (nonatomic) NSMutableArray *goalLapSeconds;
@property (nonatomic) NSMutableArray *goalLapTenths;

@property UIPickerView *goalLapPicker;

@property Timer* timer;

@property TimesViewController *controller;

@end
