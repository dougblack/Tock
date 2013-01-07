//
//  TimerSettingViewController.m
//  Times
//
//  Created by Douglas Black on 1/6/13.
//  Copyright (c) 2013 Doug Black. All rights reserved.
//

#import "TimerSettingViewController.h"
#import "CommonCLUtility.h"

@interface TimerSettingViewController ()

@end

@implementation TimerSettingViewController

- (id)init
{
    self = [super init];
    if (self) {
        UILabel *navBarLabel = [[UILabel alloc] init];
        [navBarLabel setText:@"Timer Settings"];
        [navBarLabel setBackgroundColor:[UIColor clearColor]];
        [navBarLabel setFont:[UIFont boldSystemFontOfSize:20]];
        [navBarLabel setTextAlignment:NSTextAlignmentCenter];
        [navBarLabel setTextColor:[UIColor whiteColor]];
        
        [navBarLabel setShadowOffset:CGSizeMake(1,1)];
        [navBarLabel sizeToFit];
        [self.navigationItem setTitleView:navBarLabel];
        [self.navigationItem.leftBarButtonItem setTitle:@"Back"];
        self.goalLapMinutes = [NSMutableArray array];
        self.goalLapSeconds = [NSMutableArray array];
        self.goalLapTenths = [NSMutableArray array];
        for (int i = 0; i < 60; i++) {
            NSNumber *number = [NSNumber numberWithInt:i];
            [self.goalLapSeconds addObject:number];
            [self.goalLapMinutes addObject:number];
        }
        for (int i = 0; i < 10; i++) {
            [self.goalLapTenths addObject:[NSNumber numberWithInt:i]];
        }
    }
    return self;
}

-(void)back
{
    [self.superController dismissViewControllerAnimated:YES completion:nil];
}

-(void)loadView
{
    
    [super loadView];
    int navBarHeight = self.navigationController.navigationBar.frame.size.height;
    int frameHeight = [[UIScreen mainScreen] applicationFrame].size.height;
    self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, frameHeight-navBarHeight)];
    self.view.opaque = YES;
    self.view.backgroundColor = [CommonCLUtility viewDarkBackColor];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIPickerView *goalLapPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-216, 320, 216)];
    goalLapPicker.delegate = self;
    goalLapPicker.dataSource = self;
    goalLapPicker.opaque = YES;
    goalLapPicker.showsSelectionIndicator = YES;
    [self.view addSubview:goalLapPicker];

}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            return 60;
            break;
        case 1:
            return 1;
            break;
        case 2:
            return 60;
            break;
        case 3:
            return 1;
            break;
        case 4:
            return 10;
        default:
            return -1;
            break;
    }
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 5;
}

-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            return [NSString stringWithFormat:@"%02d", [[self.goalLapMinutes objectAtIndex:row] intValue]];
            break;
        case 1:
            return @":";
            break;
        case 2:
            return [NSString stringWithFormat:@"%02d", [[self.goalLapSeconds objectAtIndex:row] intValue]];
            break;
        case 3:
            return @".";
            break;
        case 4:
            return [NSString stringWithFormat:@"%d", [[self.goalLapSeconds objectAtIndex:row] intValue]];
        default:
            return @"";
            break;
    }
}

-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    if (component == 1 || component == 3)
        return 20.0f;
    return 40.0f;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
