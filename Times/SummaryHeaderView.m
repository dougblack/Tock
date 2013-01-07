//
//  SummaryHeaderView.m
//  Times
//
//  Created by Douglas Black on 1/5/13.
//  Copyright (c) 2013 Doug Black. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "SummaryHeaderView.h"
#import "CommonCLUtility.h"
#import "Timer.h"

@interface SummaryHeaderView ()

@end


@implementation SummaryHeaderView

- (id)initWithThumb:(UIColor*)thumb andTimerNumber:(NSInteger)timerNumber andTimer:(Timer*)timer;
{
    self = [super init];
    if (self) {
        [self setBackgroundColor:[CommonCLUtility viewBackgroundColor]];
        
        UIView *thumbView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 60)];
        [thumbView setBackgroundColor:thumb];
//        [thumbView.layer setCornerRadius:3];
        [self addSubview:thumbView];
        
        UITextField *nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 0, 100, 60)];
        [nameTextField setTextAlignment:NSTextAlignmentLeft];
        [nameTextField setTextColor:[UIColor whiteColor]];
        
        [nameTextField setText:[timer name]];
        [nameTextField setFont:[UIFont boldSystemFontOfSize:25]];
        [nameTextField setBackgroundColor:[UIColor clearColor]];
        [nameTextField setBorderStyle:UITextBorderStyleNone];
        [nameTextField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        self.nameTextField = nameTextField;
        self.nameTextField.delegate = self;
        [self addSubview:nameTextField];
        
        UILabel* numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(280, 0, 30, 60)];
        [numberLabel setTextAlignment:NSTextAlignmentCenter];
        [numberLabel setTextColor:[UIColor whiteColor]];
        [numberLabel setText:[NSString stringWithFormat:@"%d", timerNumber]];
        [numberLabel setFont:[UIFont boldSystemFontOfSize:25]];
        [numberLabel setBackgroundColor:[UIColor clearColor]];
        [self addSubview:numberLabel];
        [self setOpaque:YES];
    }
    return self;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [self.timer setName:textField.text];
}

@end
