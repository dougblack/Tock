//
//  LapViewController.m
//  Times
//
//  Created by Douglas Black on 12/30/12.
//  Copyright (c) 2012 Doug Black. All rights reserved.
//

#import "LapViewController.h"
#import "TimesTableView.h"
#import "LapTableView.h"
#import "LapTimerView.h"
#import "TimerCell.h"
#import "LapCell.h"
#import "Timer.h"
#import "CommonCLUtility.h"

@implementation LapViewController

@synthesize numOfLaps;
@synthesize laps;
@synthesize timer;
@synthesize timerHeader;
@synthesize lapStrings;

- (id)init
{
    self = [super init];
    if (self) {
        UILabel *navBarLabel = [[UILabel alloc] init];
        [navBarLabel setText:@"Laps"];
        [navBarLabel setBackgroundColor:[UIColor clearColor]];
        [navBarLabel setFont:[UIFont boldSystemFontOfSize:20]];
        [navBarLabel setTextAlignment:NSTextAlignmentCenter];
        [navBarLabel setTextColor:[UIColor whiteColor]];
        
        [navBarLabel setShadowOffset:CGSizeMake(1,1)];
        [navBarLabel sizeToFit];
        [self.navigationItem setTitleView:navBarLabel];
        [self.navigationItem.leftBarButtonItem setTitle:@"Back"];
    }
    return self;
}

-(void) loadView
{
    [super loadView];
    int navBarHeight = self.navigationController.navigationBar.frame.size.height;
    int frameHeight = [[UIScreen mainScreen] applicationFrame].size.height;
    self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, frameHeight-navBarHeight)];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    int viewHeight = 100;
    UISwipeGestureRecognizer *backGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeBack:)];
    [backGestureRecognizer setDirection:UISwipeGestureRecognizerDirectionRight];
    LapTableView *lapTableView = [[LapTableView alloc] initWithFrame:CGRectMake(0, viewHeight, self.view.frame.size.width, self.view.frame.size.height-viewHeight) style:UITableViewStylePlain];
    [lapTableView registerClass:[LapCell class] forCellReuseIdentifier:@"Lap"];
    [lapTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [lapTableView setDelegate:self];
    [lapTableView setDataSource:self];
    [lapTableView setTag:0];
    [lapTableView setBackgroundColor:[CommonCLUtility viewDarkBackColor]];
    [lapTableView setShowsVerticalScrollIndicator:NO];
    [self.view addSubview:lapTableView];
    
    LapTimerView *lapTimer = [[LapTimerView alloc] initWithFrame:CGRectMake(0, 0, 320, 95) andTimer:[self timer]];
    [lapTimer setTimer:[self timer]];
    [lapTimer setLapViewController:self];
    [lapTimer setLapTableView:lapTableView];
    [lapTimer setTag:1];
    [self.view addSubview:lapTimer];
    [self.view addGestureRecognizer:backGestureRecognizer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void) swipeBack:(UISwipeGestureRecognizer*)backGesture
{
    [[self navigationController] popViewControllerAnimated:YES];
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath row] == [[self timer] lapNumber]-2) {
        return 75;
    } else {
        return 65;
    }
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self timer] lapNumber]-1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *LapIdentifier = @"Lap";

    NSNumber *lapAsNumber = (NSNumber*) [[[self timer] laps] objectAtIndex:[[self timer] lapNumber] - [indexPath row] - 2];
    NSString *lapString = (NSString*) [[[self timer] lapStrings] objectAtIndex:[[self timer] lapNumber] - [indexPath row] - 2];
    NSTimeInterval lap = (NSTimeInterval)[lapAsNumber doubleValue];
    LapCell *lapCell = (LapCell*) [tableView dequeueReusableCellWithIdentifier:LapIdentifier];
    if (lapCell == nil)
    {
        lapCell = [(LapCell*)[LapCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:LapIdentifier];
        [lapCell setSelectionStyle:UITableViewCellEditingStyleNone];
    }
    [lapCell setLapNumber:[[self timer] lapNumber] - [indexPath row] - 1];
    [lapCell setLap:lap];
    [lapCell setLapString:lapString];
    [lapCell refresh];
    return lapCell;
}

@end
