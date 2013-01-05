//
//  TimesTable.m
//  Times
//
//  Created by Douglas Black on 12/23/12.
//  Copyright (c) 2012 Doug Black. All rights reserved.
//

#import "TimesViewController.h"
#import "SummaryViewController.h"
#import "TimerCell.h"
#import "TimesTableView.h"
#import "BottomActionView.h"
#import "CommonCLUtility.h"
#import "Timer.h"

@implementation TimesViewController

@synthesize numTimers, tableView, bottomActionView;

- (id)init{
    self = [super init];
    if (self) {
        self.title = NSLocalizedString(@"Times", @"Times");
        self.numTimers = 0;
        self.numSections = 1;
        self.timers = [[NSMutableArray alloc] init];
        
        UILabel *navBarLabel = [[UILabel alloc] init];
        [navBarLabel setText:@"Times"];
        [navBarLabel setBackgroundColor:[UIColor clearColor]];
        [navBarLabel setFont:[UIFont boldSystemFontOfSize:20]];
        [navBarLabel setTextAlignment:NSTextAlignmentCenter];
//        [navBarLabel setTextColor:[UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1]];
        [navBarLabel setTextColor:[UIColor whiteColor]];

        [navBarLabel setShadowOffset:CGSizeMake(1,1)];
        [navBarLabel sizeToFit];
        [self.navigationItem setTitleView:navBarLabel];
        UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(newTimer)];
        UIBarButtonItem *summaryButton = [[UIBarButtonItem alloc] initWithTitle:@"Summary" style:UIBarButtonItemStylePlain target:self action:@selector(openSummary)];
        [self.navigationItem setLeftBarButtonItem:addButton];
        [self.navigationItem setRightBarButtonItem:summaryButton];
        
        [self newTimer];
        [self newTimer];
    }
    return self;
}

-(void)openSummary
{
    SummaryViewController *summaryViewController = [[SummaryViewController alloc] init];
    [summaryViewController setTimerLaps:[self timers]];
    [self.navigationController pushViewController:summaryViewController animated:YES];
}

-(void)loadView
{
    [super loadView];
    int navBarHeight = self.navigationController.navigationBar.frame.size.height;
    //    int statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    int frameHeight = [[UIScreen mainScreen] applicationFrame].size.height;
    self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, frameHeight-navBarHeight)];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    int viewHeight = 74;
    TimesTableView *timesTableView = [[TimesTableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-viewHeight) style:UITableViewStylePlain];
    [timesTableView registerClass:[TimerCell class] forCellReuseIdentifier:@"Cell"];
    [timesTableView setRowHeight:95];
    [timesTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [timesTableView setDelegate:self];
    [timesTableView setDataSource:self];
    [self setTableView:timesTableView];
    [self.view addSubview:timesTableView];
    
    BottomActionView *bottom = [[BottomActionView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-viewHeight, self.view.frame.size.width, viewHeight)];
    [bottom setController:self];
    [self setBottomActionView:bottom];
    [self.view addSubview:bottom];
    [self.view setBackgroundColor:[CommonCLUtility viewDarkBackColor]];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.tableView setBackgroundColor:[CommonCLUtility viewDarkBackColor]];
    [self.tableView reloadData];
    
}

-(void)hideBottomView
{
    [[self tableView] setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelay:0];
    [UIView setAnimationDuration:0.5];
    [self.bottomActionView setFrame:CGRectMake(0, self.view.frame.size.height+74, self.view.frame.size.width, self.bottomActionView.frame.size.height)];
    [UIView commitAnimations];
}

-(void)showBottomView
{

    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelay:0];
    [UIView setAnimationDuration:0.5];
    [self.bottomActionView setFrame:CGRectMake(0, self.view.frame.size.height-74, self.view.frame.size.width, self.bottomActionView.frame.size.height)];
    [[self tableView] setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-74)];
    [UIView commitAnimations];
}


- (void)newTimer
{
    self.numTimers++;;
    Timer* newTimer = [[Timer alloc] init];
    [newTimer setRow:numTimers-1];
    [[self timers] addObject:[[Timer alloc] init]];
    [self.tableView reloadData];

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath row] == [self numTimers]-1)
    {
        return 100;
    }
    return 95;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self numSections];;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self numTimers];
}

- (UITableViewCell *)tableView:(UITableView *)currentTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    Timer *timer = [[self timers] objectAtIndex:[indexPath row]];

    TimerCell *timerCell = (TimerCell *)[currentTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (timerCell == nil) {
        timerCell = (TimerCell *)[[TimerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        [timerCell setSelectionStyle:UITableViewCellEditingStyleNone];

    }
    [timerCell setTimesTable:self];
    [timerCell setAllowEdit:YES];
    [[timerCell timer] setDelegate:nil];
    [timer setDelegate:timerCell];
    [timerCell setLastRow:[indexPath row]];
    [timerCell setTimer:timer];
    [timerCell refresh];
    return timerCell;
}

#pragma mark - Table view delegate

-(void) checkTimers
{
    for (Timer* timer in [self timers])
    {
        if ([timer started])
             return;
    }
    [self showBottomView];

}

-(void) startAll
{
    for (Timer* timer in [self timers])
    {
        [timer start];
    }

    [self hideBottomView];
}

@end
