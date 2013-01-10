//
//  SummaryHeaderView.h
//  Times
//
//  Created by Douglas Black on 1/5/13.
//  Copyright (c) 2013 Doug Black. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Timer;
@interface SummaryHeaderView : UIView <UITextFieldDelegate>

@property (nonatomic) UITextField *nameTextField;
@property (nonatomic) Timer *timer;

- (id)initWithThumb:(UIColor*)thumb andTimerNumber:(NSInteger)timerNumber andTimer:(Timer*)timer;

-(void)convertToLapHeader;

@end
