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
#import "TockSoundPlayer.h"
#import "GoalPickerView.h"
#import "SettingsViewController.h"

@interface TimesViewController ()

@property (nonatomic) UIColor *lastGeneratedColor;
@property BOOL allowSound;
@property UIBarButtonItem *startAllButton;

@end

@implementation TimesViewController

@synthesize numTimers, tableView, bottomActionView;

- (id)init{
    self = [super init];
    if (self) {
        self.allowSound = NO;
        self.title = NSLocalizedString(@"Tock", @"Tock");
        self.numTimers = 0;
        self.numSections = 1;
        self.timers = [[NSMutableArray alloc] init];
        
        UILabel *navBarLabel = [[UILabel alloc] init];
        [navBarLabel setText:@"Tock"];
        [navBarLabel setBackgroundColor:[UIColor clearColor]];
        [navBarLabel setFont:[UIFont boldSystemFontOfSize:20]];
        [navBarLabel setTextAlignment:NSTextAlignmentCenter];
        [navBarLabel setTextColor:[UIColor whiteColor]];

        [navBarLabel setShadowOffset:CGSizeMake(1,1)];
        [navBarLabel sizeToFit];
        [self.navigationItem setTitleView:navBarLabel];
        UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(newTimer)];
        UIBarButtonItem *summaryButton = [[UIBarButtonItem alloc] initWithTitle:@"Summary" style:UIBarButtonItemStylePlain target:self action:@selector(openSummary)];
        [self.navigationItem setLeftBarButtonItem:summaryButton];
        [self.navigationItem setRightBarButtonItem:addButton];
//        [self.navigationController setToolbarHidden:NO];
//        self.navigationController.toolbarItems = [NSArray arrayWithObjects:addButton, nil];
        self.lastGeneratedColor = nil;
        
        // 40  - .15
        // 120 - .47
        // 240 - .94
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
        self.allowSound = YES;
        self.isShowingGoalPicker = NO;
    }
    return self;
}

-(void)openSummary
{
    [TockSoundPlayer playSoundWithName:@"high_click" andExtension:@"wav" andVolume:1.0];
    SummaryViewController *summaryViewController = [[SummaryViewController alloc] initWithTimers:[self timers]];
    [summaryViewController setDeltaType:DeltaFromPreviousLap];
    [summaryViewController setTimesViewController:self];
    UINavigationController *summaryNavigationController = [[UINavigationController alloc] initWithRootViewController:summaryViewController];
    [summaryNavigationController.navigationBar setTintColor:[UIColor colorWithRed:0.05 green:0.05 blue:0.05 alpha:1]];
    [summaryViewController.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:summaryViewController action:@selector(back)]];
    [self.navigationController presentViewController:summaryNavigationController animated:YES completion:nil];

}

-(void)openSettings
{
    SettingsViewController *settingsViewController = [[SettingsViewController alloc] init];
    settingsViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    settingsViewController.timesViewController = self;
    
    UINavigationController *settingsNavigationController = [[UINavigationController alloc] initWithRootViewController:settingsViewController];
    [settingsNavigationController.navigationBar setTintColor:[UIColor colorWithRed:0.05 green:0.05 blue:0.05 alpha:1]];
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:settingsViewController action:@selector(saveAndClose)];
    saveButton.tintColor =[UIColor colorWithRed:0.3 green:0.0 blue:0.8 alpha:1];
    [settingsViewController.navigationItem setRightBarButtonItem:saveButton];
    
    
    [self.navigationController presentViewController:settingsNavigationController animated:YES completion:nil];
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
    int viewHeight = 44;
    int navBarHeight = self.navigationController.navigationBar.frame.size.height;
    
    TimesTableView *timesTableView = [[TimesTableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-navBarHeight) style:UITableViewStylePlain];
    [timesTableView registerClass:[TimerCell class] forCellReuseIdentifier:@"Cell"];
    [timesTableView setRowHeight:95];
    [timesTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [timesTableView setDelegate:self];
    [timesTableView setDataSource:self];
    [timesTableView setShowsVerticalScrollIndicator:NO];
    [self setTableView:timesTableView];
    [self.view addSubview:timesTableView];
    
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-viewHeight, self.view.frame.size.width, viewHeight)];

    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *settingsButton = [[UIBarButtonItem alloc] init];
    [settingsButton setAction:@selector(openSettings)];
    [settingsButton setTarget:self];
    settingsButton.title = @"\u2699";
    UIFont *f1 = [UIFont fontWithName:@"Helvetica" size:24.0];
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:f1, UITextAttributeFont, nil];
    [settingsButton setTitleTextAttributes:dict forState:UIControlStateNormal];
    [toolbar setTintColor:[UIColor blackColor]];
    UIBarButtonItem *startAllButton = [[UIBarButtonItem alloc] initWithTitle:@"START ALL" style:UIBarButtonItemStylePlain target:self action:@selector(startAll)];
    [startAllButton setTintColor:[UIColor colorWithRed:0.0 green:0.8 blue:0.3 alpha:1]];
    [startAllButton setBackgroundImage:[CommonCLUtility imageFromColor:[UIColor colorWithRed:0 green:0.8 blue:0.3 alpha:1]] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    self.startAllButton = startAllButton;
    
    NSArray *toolBarItems = [NSArray arrayWithObjects:startAllButton, flexibleSpace, settingsButton, nil];
    [toolbar setItems:toolBarItems];
    [self.view addSubview:toolbar];
    
    GoalPickerView *goalPickerView = [[GoalPickerView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height+291, self.view.frame.size.width, 291)];
    goalPickerView.controller = self;
    self.goalPickerView = goalPickerView;
    [self.view addSubview:goalPickerView];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.tableView setBackgroundColor:[CommonCLUtility viewDarkBackColor]];
    [self.tableView reloadData];
    
}

-(void)showPickerViewForTimer:(Timer*)timer;
{
    [self hideBottomView];
    
    self.goalPickerView.timer = timer;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelay:0];
    [UIView setAnimationDuration:0.3];
    [self.goalPickerView setFrame:CGRectMake(0, self.view.frame.size.height-291, self.view.frame.size.width, self.goalPickerView.frame.size.height)];
    [UIView commitAnimations];
    self.isShowingGoalPicker = YES;
}

-(void)hidePickerView
{
    [self checkTimers];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelay:0];
    [UIView setAnimationDuration:0.3];
    [self.goalPickerView setFrame:CGRectMake(0, self.view.frame.size.height+291, self.view.frame.size.width, self.goalPickerView.frame.size.height)];
    [UIView commitAnimations];
    self.isShowingGoalPicker = YES;
}

-(void)hideBottomView
{
//    [[self tableView] setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDelay:0];
//    [UIView setAnimationDuration:0.3];
//    [self.bottomActionView setFrame:CGRectMake(0, self.view.frame.size.height+74, self.view.frame.size.width, self.bottomActionView.frame.size.height)];
//    [UIView commitAnimations];
}

-(void)showBottomView
{

//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDelay:0];
//    [UIView setAnimationDuration:0.3];
//    [self.bottomActionView setFrame:CGRectMake(0, self.view.frame.size.height-74, self.view.frame.size.width, self.bottomActionView.frame.size.height)];
//    [[self tableView] setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-74)];
//    [UIView commitAnimations];
}


- (void)newTimer
{
    if (self.allowSound)
        [TockSoundPlayer playSoundWithName:@"high_click" andExtension:@"wav" andVolume:1.0];
    
    self.numTimers++;;
    Timer* newTimer = [[Timer alloc] init];

    UIColor *generatedColor = [CommonCLUtility generateNewColor];
    [newTimer setThumb:generatedColor];
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
    return 100;
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
    [timerCell.timer setDelegate:nil];
    [timer setDelegate:timerCell];
    [timerCell setRow:indexPath.row];
    [timerCell setTimer:timer];
    [timerCell refresh];
    return timerCell;
}

// Check if any timers are running and then set the StartAll
// button accordingly.
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


