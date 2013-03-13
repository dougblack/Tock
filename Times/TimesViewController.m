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
#import "CommonCLUtility.h"
#import "Timer.h"
#import "TockSoundPlayer.h"
#import "GoalPickerView.h"
#import "AboutViewController.h"
#import "AboutViewController.h"

@interface TimesViewController ()

@property (nonatomic) UIColor *lastGeneratedColor;
@property BOOL allowSound;
@property UIBarButtonItem *startAllButton;
@property UIBarButtonItem *plusButton;

@end

@implementation TimesViewController

@synthesize numTimers, tableView;

- (id)init{
    
    self = [super init];
    if (self) {
        
        /* Set up */
        self.title = NSLocalizedString(@"Tock", @"Tock");
        self.numTimers = 0;
        self.numSections = 1;
        self.colorIndex = (arc4random() % 11);
        self.isShowingGoalPicker = NO;
        self.allowSound = YES;
        self.lastGeneratedColor = nil;
        self.timers = [[NSMutableArray alloc] init];
        
        /* Display title label */
        UILabel *navBarLabel = [[UILabel alloc] init];
        [navBarLabel setText:@"Tock"];
        [navBarLabel setBackgroundColor:[UIColor clearColor]];
        [navBarLabel setFont:[UIFont boldSystemFontOfSize:20]];
        [navBarLabel setTextAlignment:NSTextAlignmentCenter];
        [navBarLabel setTextColor:[UIColor whiteColor]];
        [navBarLabel setShadowOffset:CGSizeMake(1,1)];
        [navBarLabel sizeToFit];
        [self.navigationItem setTitleView:navBarLabel];
        
        /* Display new timer button */
        UIImage *plusImage = [UIImage imageNamed:@"plus_button.png"];
        UIButton *addBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 45, 32)];
        [addBtn setBackgroundImage:plusImage forState:UIControlStateNormal];
        [addBtn addTarget:self action:@selector(newTimer) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithCustomView:addBtn];
        self.plusButton = addButton;
        [self.navigationItem setRightBarButtonItem:addButton];

        /* Display summary button */
        UIImage *buttonImage = [[UIImage imageNamed:@"summary_button.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 70, 0, 0)];
        UIButton *summaryBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 32)];
        [summaryBtn setBackgroundImage:buttonImage forState:UIControlStateNormal];
        UIBarButtonItem *summaryButton = [[UIBarButtonItem alloc] initWithCustomView:summaryBtn];
        [summaryBtn addTarget:self action:@selector(openSummary) forControlEvents:UIControlEventTouchUpInside];
        [self.navigationItem setLeftBarButtonItem:summaryButton];

        /* Timer color palette */

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
        

        /* Create initial two timers */
        [self newTimer];
        [self newTimer];

    }
    return self;
}

/* Slide up the summary view */
-(void)openSummary
{
    /* Play button click sound */
    [TockSoundPlayer playSoundWithName:@"high_click" andExtension:@"wav" andVolume:1.0];
    
    /* Build controller */
    SummaryViewController *summaryViewController = [[SummaryViewController alloc] initWithTimers:[self timers]];
    [summaryViewController setDeltaType:DeltaFromPreviousLap];
    [summaryViewController setTimesViewController:self];
    UINavigationController *summaryNavigationController = [[UINavigationController alloc] initWithRootViewController:summaryViewController];
    [summaryNavigationController.navigationBar setTintColor:[UIColor colorWithRed:0.05 green:0.05 blue:0.05 alpha:1]];
    
    /* Build new nav bar */
    UIImage *doneImage = [UIImage imageNamed:@"button.png"];
    UIButton *doneBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 32)];
    [doneBtn setBackgroundImage:doneImage forState:UIControlStateNormal];
    [doneBtn setTitle:@"Done" forState:UIControlStateNormal];
    [doneBtn setTitleEdgeInsets:UIEdgeInsetsMake(1, 2, 0, 0)];
    [doneBtn setFont:[UIFont boldSystemFontOfSize:12]];
    [doneBtn addTarget:summaryViewController action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithCustomView:doneBtn];
    
    [summaryViewController.navigationItem setRightBarButtonItem:doneButton];
    [self.navigationController presentViewController:summaryNavigationController animated:YES completion:nil];

}

/* Flip to about view */
-(void)openAbout
{
    /* Build controller */
    AboutViewController *aboutViewController = [[AboutViewController alloc] init];
    aboutViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    aboutViewController.timesViewController = self;
    
    /* Build new nav bar */
    UINavigationController *aboutNavigationController = [[UINavigationController alloc] initWithRootViewController:aboutViewController];
    [aboutNavigationController.navigationBar setTintColor:[UIColor colorWithRed:0.05 green:0.05 blue:0.05 alpha:1]];
    
    UIImage *doneImage = [UIImage imageNamed:@"button.png"];
    UIButton *doneBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 32)];
    [doneBtn setBackgroundImage:doneImage forState:UIControlStateNormal];
    [doneBtn setTitle:@"Done" forState:UIControlStateNormal];
    [doneBtn setTitleEdgeInsets:UIEdgeInsetsMake(1, 2, 0, 0)];
    [doneBtn setFont:[UIFont boldSystemFontOfSize:12]];
    [doneBtn addTarget:aboutViewController action:@selector(saveAndClose) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithCustomView:doneBtn];
    [aboutViewController.navigationItem setRightBarButtonItem:doneButton];
    
    [self.navigationController presentViewController:aboutNavigationController animated:YES completion:nil];
}

-(void)loadView
{
    [super loadView];
    
    /* Calculate view dimensions */
    int navBarHeight = self.navigationController.navigationBar.frame.size.height;
    int frameHeight = [[UIScreen mainScreen] applicationFrame].size.height;
    self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, frameHeight-navBarHeight)];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    int viewHeight = 44;
    int navBarHeight = self.navigationController.navigationBar.frame.size.height;
    
    /* Build TableView */
    TimesTableView *timesTableView = [[TimesTableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-navBarHeight) style:UITableViewStylePlain];
    [timesTableView registerClass:[TimerCell class] forCellReuseIdentifier:@"Cell"];
    [timesTableView setRowHeight:95];
    [timesTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [timesTableView setDelegate:self];
    [timesTableView setDataSource:self];
    [timesTableView setShowsVerticalScrollIndicator:NO];
    [self setTableView:timesTableView];
    [self.view addSubview:timesTableView];
    
    /* Build ToolBar */
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-viewHeight, self.view.frame.size.width, viewHeight)];
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIButton* settingsButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
    [settingsButton addTarget:self action:@selector(openAbout) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *modalButton = [[UIBarButtonItem alloc] initWithCustomView:settingsButton];
    [toolbar setTintColor:[UIColor blackColor]];
    UIBarButtonItem *startAllButton = [[UIBarButtonItem alloc] initWithTitle:@"START ALL" style:UIBarButtonItemStylePlain target:self action:@selector(startAll)];
    [startAllButton setTintColor:[UIColor colorWithRed:0.0 green:0.8 blue:0.3 alpha:1]];
    [startAllButton setBackgroundImage:[CommonCLUtility imageFromColor:[UIColor colorWithRed:0 green:0.8 blue:0.3 alpha:1]] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    self.startAllButton = startAllButton;
    NSArray *toolBarItems = [NSArray arrayWithObjects:startAllButton, flexibleSpace, modalButton, nil];
    [toolbar setItems:toolBarItems];
    [self.view addSubview:toolbar];
    
    /* Build GoalPickerView */
    GoalPickerView *goalPickerView = [[GoalPickerView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height+291, self.view.frame.size.width, 291)];
    goalPickerView.controller = self;
    self.goalPickerView = goalPickerView;
    [self.view addSubview:goalPickerView];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    /* Prepare TableView for cells */
    [self.tableView setBackgroundColor:[UIColor clearColor] ];
    UIImageView *tableBack = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"table_view_back.png"]];
    [self.tableView setBackgroundView:tableBack];
    [self.tableView reloadData];
    
}

/* Slide up the GoalPicker */
-(void)showPickerViewForTimer:(Timer*)timer;
{
    
    self.goalPickerView.timer = timer;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelay:0];
    [UIView setAnimationDuration:0.3];
    [self.goalPickerView setFrame:CGRectMake(0, self.view.frame.size.height-291, self.view.frame.size.width, self.goalPickerView.frame.size.height)];
    [UIView commitAnimations];
    UIImage *cancelImage = [UIImage imageNamed:@"button.png"];
    UIButton *cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 65, 32)];
    [cancelBtn setBackgroundImage:cancelImage forState:UIControlStateNormal];
    [cancelBtn setTitle:@"Cancel" forState:UIControlStateNormal];
    [cancelBtn setTitleEdgeInsets:UIEdgeInsetsMake(1, 2, 0, 0)];
    [cancelBtn setFont:[UIFont boldSystemFontOfSize:12]];
    [cancelBtn addTarget:self action:@selector(hidePickerView) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithCustomView:cancelBtn];
    [self.navigationItem setRightBarButtonItem:cancelItem];
    self.isShowingGoalPicker = YES;
}

/* Slide down the GoalPicker */
-(void)hidePickerView
{
    [self checkTimers];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelay:0];
    [UIView setAnimationDuration:0.3];
    [self.goalPickerView setFrame:CGRectMake(0, self.view.frame.size.height+291, self.view.frame.size.width, self.goalPickerView.frame.size.height)];
    [UIView commitAnimations];
    [self.navigationItem setRightBarButtonItem:self.plusButton];
    self.isShowingGoalPicker = YES;
}

/* Create a new timer */
- (void)newTimer
{
    if (self.allowSound)
        [TockSoundPlayer playSoundWithName:@"high_click" andExtension:@"wav" andVolume:1.0];
    
    self.numTimers++;;
    Timer* newTimer = [[Timer alloc] init];
    
    /* Generate and set a new color for this timer */
    UIColor *generatedColor = [CommonCLUtility generateNewColor];
    [newTimer setThumb:generatedColor];
    
    /* Update TableView data */
    [newTimer setRow:numTimers-1];
    [[self timers] addObject:newTimer];
    [self.tableView reloadData];

    
    /* Scroll to show newly added Timer */
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
    [timerCell.timer setDelegate:nil];
    [timer setDelegate:timerCell];
    [timerCell setRow:indexPath.row];
    [timerCell setTimer:timer];
    [timerCell refresh];
    return timerCell;
}

/* Check if any timers are running and then set the StartAll button accordingly. */
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
    if (!hide) // enable the StartAll button.
    {
        [self.startAllButton setTintColor:[UIColor whiteColor]];
        [self.startAllButton setEnabled:YES];
    }
    else // disable the StartAll button.
    {
        [self.startAllButton setTintColor:[UIColor darkGrayColor]];
        [self.startAllButton setEnabled:NO];
    }

    
}

-(void) startAll
{
    for (Timer* timer in [self timers])
    {
        [timer.delegate highlightAll:[[UIView alloc] init] withDuration:0.0 andWait:0.0];
        [timer start];
    }

    [self checkTimers];
}

@end


