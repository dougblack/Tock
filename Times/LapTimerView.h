//
//  LapTimerView.h
//  Times
//
//  Created by Douglas Black on 12/31/12.
//  Copyright (c) 2012 Doug Black. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@class Timer;
@class LapViewController;
@class LapTableView;

@interface LapTimerView : UIView

@property Timer* timer;

@property NSString* lapNumber;
@property BOOL running;
@property NSString* time;
@property LapViewController *lapViewController;
@property LapTableView *lapTableView;

- (id)initWithFrame:(CGRect)frame andTimer:(Timer*)timer;

@end
