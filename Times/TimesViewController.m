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
        self.title = NSLocalizedString(@"Tock", @"Tock");
        self.numTimers = 0;
        self.numSections = 1;
        self.timers = [[NSMutableArray alloc] init];
        
        UILabel *navBarLabel = [[UILabel alloc] init];
        [navBarLabel setText:@"Tock"];
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
        [self.navigationItem setLeftBarButtonItem:summaryButton];
        [self.navigationItem setRightBarButtonItem:addButton];
        
        
        // 40 - .15
        // 120 - .47
        // 240 -.94
        self.colors = [NSArray arrayWithObjects:
                       [UIColor colorWithRed:0.94 green:0.94 blue:0.15 alpha:1],
                       [UIColor colorWithRed:0.94 green:0.15 blue:0.15 alpha:1],
                       [UIColor colorWithRed:0.47 green:0.47 blue:0.94 alpha:1],
                       [UIColor colorWithRed:0.15 green:0.47 blue:0.94 alpha:1],
                       [UIColor colorWithRed:0.94 green:0.47 blue:0.15 alpha:1],
                       [UIColor colorWithRed:0.47 green:0.94 blue:0.15 alpha:1],
                       [UIColor colorWithRed:0.94 green:0.15 blue:0.94 alpha:1],
                       [UIColor colorWithRed:0.94 green:0.15 blue:0.47 alpha:1],
                       [UIColor colorWithRed:0.15 green:0.15 blue:0.94 alpha:1],
                       [UIColor colorWithRed:0.15 green:0.15 blue:0.15 alpha:1],
                       [UIColor colorWithRed:0.47 green:0.94 blue:0.47 alpha:1],
                       [UIColor colorWithRed:0.94 green:0.47 blue:0.94 alpha:1],
                       nil];
        
        self.colorIndex = (arc4random() % 11);
        [self newTimer];
        [self newTimer];
    }
    return self;
}

-(void)openSummary
{
    SummaryViewController *summaryViewController = [[SummaryViewController alloc] initWithTimers:[self timers]];
    [summaryViewController setDeltaType:DeltaFromPreviousLap];
    [summaryViewController setTimesViewController:self];
    UINavigationController *summaryController = [[UINavigationController alloc] initWithRootViewController:summaryViewController];
    [summaryController.navigationBar setTintColor:[UIColor colorWithRed:0.05 green:0.05 blue:0.05 alpha:1]];
    [summaryViewController.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:summaryViewController action:@selector(back)]];
    [self.navigationController presentViewController:summaryController animated:YES completion:nil];

}

-(void)loadView
{
    [super loadView];
    int navBarHeight = self.navigationController.navigationBar.frame.size.height;
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
    [UIView setAnimationDuration:0.3];
    [self.bottomActionView setFrame:CGRectMake(0, self.view.frame.size.height+74, self.view.frame.size.width, self.bottomActionView.frame.size.height)];
    [UIView commitAnimations];
}

-(void)showBottomView
{

    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelay:0];
    [UIView setAnimationDuration:0.3];
    [self.bottomActionView setFrame:CGRectMake(0, self.view.frame.size.height-74, self.view.frame.size.width, self.bottomActionView.frame.size.height)];
    [[self tableView] setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-74)];
    [UIView commitAnimations];
}


- (void)newTimer
{
    self.numTimers++;;
    Timer* newTimer = [[Timer alloc] init];
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = 1;
    CGFloat brightness = 0.9;  //  0.5 to 1.0, away from black
    UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];

//    UIColor *color = [self.colors objectAtIndex:self.colorIndex];
//    self.colorIndex = (self.colorIndex + 1) % 11;
    [newTimer setThumb:color];
    [newTimer setMiniThumb:color];
    [newTimer setRow:numTimers-1];
    [[self timers] addObject:newTimer];
    [self.tableView reloadData];
    NSIndexPath *indexOfNew = [NSIndexPath indexPathForRow:[self numTimers]-1 inSection:0];
    [self.tableView scrollToRowAtIndexPath:indexOfNew atScrollPosition:UITableViewScrollPositionBottom animated:YES];

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
    BOOL hide = NO;
    for (Timer* timer in [self timers])
    {
        if ([timer running]) {
            hide = YES;
            break;
        }
    }
    if (!hide)
        [self showBottomView];
    else
        [self hideBottomView];

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
