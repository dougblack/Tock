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

@property (nonatomic) UILabel *numberLabel;

@end


@implementation SummaryHeaderView

- (id)initWithThumb:(UIColor*)thumb andTimerNumber:(NSInteger)timerNumber andTimer:(Timer*)timer;
{
    self = [super init];
    if (self) {
        [self setBackgroundColor:[CommonCLUtility viewBackgroundColor]];
        
        UIView *thumbView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
        [thumbView setBackgroundColor:thumb];
        [self addSubview:thumbView];
        
        UITextField *nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 0, 250, 50)];
        [nameTextField setTextAlignment:NSTextAlignmentLeft];
        [nameTextField setTextColor:[UIColor whiteColor]];
        
        [nameTextField setText:[timer name]];
        [nameTextField setFont:[UIFont boldSystemFontOfSize:20]];
        [nameTextField setBackgroundColor:[UIColor clearColor]];
        [nameTextField setBorderStyle:UITextBorderStyleNone];
        [nameTextField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        self.nameTextField = nameTextField;
        self.nameTextField.delegate = self;
        [self addSubview:nameTextField];
        
        UILabel* numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(280, 0, 30, 50)];
        [numberLabel setTextAlignment:NSTextAlignmentCenter];
        [numberLabel setTextColor:[UIColor whiteColor]];
        [numberLabel setText:[NSString stringWithFormat:@"%d", timerNumber]];
        [numberLabel setFont:[UIFont boldSystemFontOfSize:20]];
        [numberLabel setBackgroundColor:[UIColor clearColor]];
        [numberLabel setHidden:YES];
        self.numberLabel = numberLabel;
        [self addSubview:numberLabel];
        [self setOpaque:YES];
        
        self.timer = timer;
    }
    return self;
}

-(void)convertToLapHeader
{
    self.numberLabel.hidden = NO;
    self.nameTextField.text = @"LAP";
    self.nameTextField.enabled = NO;
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

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    textField.text = [textField.text stringByReplacingCharactersInRange:range withString:[string uppercaseString]]; return NO;
}

@end
