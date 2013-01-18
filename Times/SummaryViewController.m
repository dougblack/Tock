//
//  SummaryViewController.m
//  Times
//
//  Created by Douglas Black on 1/3/13.
//  Copyright (c) 2013 Doug Black. All rights reserved.
//

#import "SummaryViewController.h"
#import "SummaryTableView.h"
#import "SummaryCell.h"
#import "SummaryHeaderView.h"
#import "SummaryHeaderCell.h"
#import "TimesViewController.h"
#import "Timer.h"
#import "CommonCLUtility.h"
#import "NoLapsCell.h"
#import "TockSoundPlayer.h"
#import "TimerSummaryCell.h"

@interface SummaryViewController ()

@property (nonatomic) NSMutableArray *headerViews;
@property (nonatomic) NSMutableArray *headerViewsByLap;
@property UISegmentedControl *deltaControl;

@end

@implementation SummaryViewController

- (id)initWithTimers:(NSMutableArray*)timers
{
    self = [super init];
    if (self) {
        
        UISegmentedControl *deltaControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"Previous", @"Goal", @"Average", nil]];
        deltaControl.segmentedControlStyle = UISegmentedControlStyleBar;
        deltaControl.tintColor = [UIColor colorWithRed:0.05 green:0.05 blue:0.05 alpha:1];
        deltaControl.selectedSegmentIndex = 1;
        [[deltaControl.subviews objectAtIndex:1] setTintColor:[UIColor redColor]];
        [deltaControl addTarget:self action:@selector(deltaChanged:) forControlEvents:UIControlEventValueChanged];
        self.deltaControl = deltaControl;
        [self.navigationItem setTitleView:deltaControl];
        [self.navigationItem.leftBarButtonItem setTitle:@"Back"];
        
        self.timersData = [NSMutableArray array];
        self.headerViews = [NSMutableArray array];
        
        int i = 1;
        self.mostLaps = -1;
        for (Timer *timer in timers)
        {
            NSInteger count = timer.laps.count;
            if (count > self.mostLaps)
                self.mostLaps = timer.laps.count;
            
            NSMutableDictionary *thisTimersDeltas = [[NSMutableDictionary alloc] init];
            NSMutableArray *previousLapDeltas = [NSMutableArray array];
            NSMutableArray *goalLapDeltas = [NSMutableArray array];
            NSMutableArray *avgLapDeltas = [NSMutableArray array];
            NSMutableArray *lapDisplayTypes = [NSMutableArray array];
            NSTimeInterval previousLap = 0;
            double goal = [timer goalLap];
            double avg = [timer avgLap];
            for (NSNumber *lap in [timer laps])
            {
                [lapDisplayTypes addObject:[NSNumber numberWithInt:DisplayLap]];
                double lapDouble = [lap doubleValue];
                if (previousLap == 0)
                    [previousLapDeltas addObject:[NSNull null]];
                else {
                    double delta = lapDouble - previousLap;
                    [previousLapDeltas addObject:[NSNumber numberWithDouble:delta]];
                }
                
                if (goal != -1)
                    [goalLapDeltas addObject:[NSNumber numberWithDouble:(lapDouble-goal)]];
                else
                    [goalLapDeltas addObject:[NSNull null]];
                
                [avgLapDeltas addObject:[NSNumber numberWithDouble:(lapDouble-avg)]];
                previousLap = lapDouble;
            }
            
            [thisTimersDeltas setObject:previousLapDeltas forKey:@"Previous"];
            [thisTimersDeltas setObject:goalLapDeltas forKey:@"Goal"];
            [thisTimersDeltas setObject:avgLapDeltas forKey:@"Avg"];
            [thisTimersDeltas setObject:lapDisplayTypes forKey:@"LapDisplayType"];
            [self.timersData addObject:thisTimersDeltas];
            SummaryHeaderView *headerView = [[SummaryHeaderView alloc] initWithThumb:timer.thumb andTimerNumber:i andTimer:timer];
            [self.headerViews addObject:headerView];
            i++;
        }
        
        self.timers = timers;
        self.displayType = DisplayByTimer;
        
        self.headerViewsByLap = [NSMutableArray array];
        self.arrayOfLaps = [NSMutableArray array];
        for (int i = 0; i < self.mostLaps; i++)
        {
            SummaryHeaderView *headerView = [[SummaryHeaderView alloc] initWithThumb:[UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1] andTimerNumber:i+1 andTimer:nil];
            [headerView convertToLapHeader];
            
            [self.headerViewsByLap addObject:headerView];
            
            NSMutableArray *currentLaps = [NSMutableArray array];
            for (Timer* timer in timers)
            {
                if (i < timer.laps.count)
                    [currentLaps addObject:[timer.laps objectAtIndex:i]];
                else
                    [currentLaps addObject:[NSNull null]];
            }
            [self.arrayOfLaps addObject:currentLaps];
        }
        
    }
    return self;
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
    
    UISwipeGestureRecognizer *backRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(back:)];
    [backRecognizer setDirection:UISwipeGestureRecognizerDirectionRight];
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
    [tapRecognizer setNumberOfTapsRequired:1];
    
    SummaryTableView *summaryTableView = [[SummaryTableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-44)];
    [summaryTableView registerClass:[SummaryCell class] forCellReuseIdentifier:@"SummaryCell"];
    [summaryTableView registerClass:[NoLapsCell class] forCellReuseIdentifier:@"NoLapsCell"];
    [summaryTableView registerClass:[SummaryHeaderCell class] forCellReuseIdentifier:@"HeaderCell"];
    [summaryTableView registerClass:[TimerSummaryCell class] forCellReuseIdentifier:@"TimerSummaryCell"];
    [summaryTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [summaryTableView setDelegate:self];
    [summaryTableView setDataSource:self];
    [summaryTableView setBackgroundColor:[CommonCLUtility viewDarkBackColor]];
    [summaryTableView setShowsVerticalScrollIndicator:NO];
    [summaryTableView addGestureRecognizer:tapRecognizer];
    [self setTableView:summaryTableView];
    [self.view addSubview:summaryTableView];
    
    UITabBar *tabBar = [[UITabBar alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-44, self.view.frame.size.width, 44)];
    UITabBarItem *lapBarItem = [[UITabBarItem alloc] initWithTitle:@"By Lap" image:[UIImage imageNamed:@"by_lap.png"] tag:0];
    UITabBarItem *timerByItem = [[UITabBarItem alloc] initWithTitle:@"By Timer" image:[UIImage imageNamed:@"by_timer.png"] tag:1];
    [tabBar setItems:[NSArray arrayWithObjects:timerByItem, lapBarItem, nil]];
    tabBar.delegate = self;
    [tabBar setSelectedItem:timerByItem];
    [self.view addSubview:tabBar];
    
}

-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    if (item.tag == 0) {
        self.displayType = DisplayByLap;
        self.deltaControl.hidden = YES;
    } else {
        self.displayType = DisplayByTimer;
        self.deltaControl.hidden = NO;
    }
    
    [self.tableView reloadData];
}

-(void)deltaChanged:(UISegmentedControl*)control
{
    for (int i=0; i<[control.subviews count]; i++)
    {
        if ([[control.subviews objectAtIndex:i] isSelected] )
        {
            if (i == 0)
                self.deltaType = DeltaFromAverageLap;
            else if (i == 1)
                self.deltaType = DeltaFromGoalLap;
            else if (i == 2)
                self.deltaType = DeltaFromPreviousLap;
            
            [[control.subviews objectAtIndex:i] setTintColor:[UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1]];
        } else {
            [[control.subviews objectAtIndex:i] setTintColor:[UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1]];
        }
    }
    [self.tableView reloadData];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self deltaChanged:self.deltaControl];
}

-(void)back
{
    [TockSoundPlayer playSoundWithName:@"high_click" andExtension:@"wav" andVolume:1.0];
    [self.timesViewController.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.displayType == DisplayByLap)
    {
        if (self.mostLaps >= 0)
            return self.mostLaps;
        else
            return 0;
        
    }
    return [[self timers] count];
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.displayType == DisplayByTimer)
    {
        Timer *timer = [[self timers] objectAtIndex:section];
        if ([[timer laps] count] == 0)
            return 1;
        return [[timer laps] count]+1;
    } else {
        return [[self.arrayOfLaps objectAtIndex:section] count];
    }
}

-(UIView*) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (self.displayType == DisplayByTimer)
        return [self.headerViews objectAtIndex:section];
    else
        return [self.headerViewsByLap objectAtIndex:section];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *SummaryCellIdentifier = @"SummaryCell";
    static NSString *NoLapsCellIdentifier = @"NoLapsCell";
    static NSString *HeaderCellIdentifier = @"HeaderCell";
    
    Timer *timer = nil;
    
    if (self.displayType == DisplayByTimer)
        timer = [[self timers] objectAtIndex:indexPath.section];
    
    if (indexPath.row == 0 && self.displayType == DisplayByTimer)
    {
        // Construct and return a header for "By Timer" mode
        SummaryHeaderCell *header = (SummaryHeaderCell*) [tableView dequeueReusableCellWithIdentifier:HeaderCellIdentifier];
        if (header == nil)
        {
            header = [[SummaryHeaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:HeaderCellIdentifier andTimer:timer];
        }
        [header setTime:[timer timeString]];
        if ([timer avgLap] != 0)
            [header setAvg:[Timer stringFromTimeInterval:[timer avgLap]]];
        else
            [header setAvg:@"---"];
        if ([timer goalLap] != -1)
            [header setGoal:[Timer stringFromTimeInterval:[timer goalLap]]];
        else
            [header setGoal:@"---"];
        [header setTimer:timer];
        [header refresh];
        return header;
    }

    if ([[timer laps] count] == 0 && indexPath.row == 1 && self.displayType == DisplayByTimer)
    {
        // Construct and return a "No Laps" cell for "By Timer" mode
        NoLapsCell *noLapsCell = (NoLapsCell*) [tableView dequeueReusableCellWithIdentifier:NoLapsCellIdentifier];
        if (noLapsCell == nil)
        {
            noLapsCell = [[NoLapsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NoLapsCellIdentifier];
        }
        return noLapsCell;
    }
    
    SummaryCell *summaryCell = (SummaryCell*) [tableView dequeueReusableCellWithIdentifier:SummaryCellIdentifier];
    
    if (self.displayType == DisplayByTimer)
    {
        // return a regular cell for the "By Timer" mode
        if (summaryCell == nil)
        {
            summaryCell = [[SummaryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SummaryCellIdentifier];
        }
        
        [summaryCell setLapTimeString:[[timer lapStrings] objectAtIndex:indexPath.row-1]];
        NSString *timeAtLap = [timer.timeOfLapStrings objectAtIndex:indexPath.row-1];
        [summaryCell setTimeAtLapString:timeAtLap];
        DisplayType displayType = [[[[self.timersData objectAtIndex:indexPath.section] objectForKey:@"LapDisplayType"] objectAtIndex:indexPath.row-1] intValue];
        [summaryCell setStringDisplayType:displayType];
        [summaryCell setTimerNumber:indexPath.section];
        NSMutableDictionary *timerDict = (NSMutableDictionary*)[self.timersData objectAtIndex:indexPath.section];
        switch (self.deltaType) {
            case DeltaFromPreviousLap:
            {
                NSMutableArray *previousLapDeltas = [timerDict objectForKey:@"Previous"];
                NSNumber *delta = [previousLapDeltas objectAtIndex:indexPath.row-1];
                
                if (delta != [NSNull null]) // A delta exists
                {
                    NSString *lapDeltaString;
                    if ([delta doubleValue] < 0) {
                        lapDeltaString = [NSString stringWithFormat:@"%.1f", [delta doubleValue]];
                        [summaryCell setDeltaColor:DeltaIsGreen];
                    } else {
                        lapDeltaString = [NSString stringWithFormat:@"+%.1f", [delta doubleValue]];
                        [summaryCell setDeltaColor:DeltaIsRed];
                    }
                    
                    if ([lapDeltaString isEqualToString:@"-0.0"] || [lapDeltaString isEqualToString:@"+0.0"]) {
                        lapDeltaString = @"0.0";
                        [summaryCell setDeltaColor:DeltaIsGray];
                    }
                    
                    [summaryCell setLapDelta:lapDeltaString];
                } else { // A delta does not exist
                    [summaryCell setLapDelta:@"---"];
                    [summaryCell setDeltaColor:DeltaIsGray];
                    
                }
                summaryCell.lapDeltaLabel.hidden = NO;
                break;
            }
            case DeltaFromAverageLap:
            {
                NSMutableArray *avgLapDeltas = [timerDict objectForKey:@"Avg"];
                NSNumber *delta = [avgLapDeltas objectAtIndex:indexPath.row-1];
                NSString *deltaString = [self stringForDelta:delta];
                DeltaColor deltaColor = [self colorForDeltaString:deltaString];
                [summaryCell setDeltaColor:deltaColor];
                [summaryCell setLapDelta:deltaString];
                summaryCell.lapDeltaLabel.hidden = NO;
                break;
            }
            case DeltaFromGoalLap:
            {
                NSMutableArray *goalLapDeltas = [timerDict objectForKey:@"Goal"];
                NSNumber *delta = [goalLapDeltas objectAtIndex:indexPath.row-1];
                NSString* deltaString;
                DeltaColor deltaColor;
                if (delta != [NSNull null])
                {
                    deltaString = [self stringForDelta:delta];
                    deltaColor = [self colorForDeltaString:deltaString];
                } else
                {
                    deltaString = @"---";
                    deltaColor = DeltaIsGray;
                }
                
                [summaryCell setLapDelta:deltaString];
                [summaryCell setDeltaColor:deltaColor];
                summaryCell.lapDeltaLabel.hidden = NO;
                break;
            }
            case None:
            {
                summaryCell.lapDeltaLabel.hidden = YES;
                break;
            }
            default:
                break;
        }
        
        [summaryCell setLapNumber:indexPath.row];
        summaryCell.controller = self;
        summaryCell.timer = timer;
        [summaryCell refresh];
        return summaryCell;
    } else
    {
        // Return a cell for the "By Lap" mode
        TimerSummaryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TimerSummaryCell"];
        
        if (cell == nil)
        {
            cell = [[TimerSummaryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TimerSummaryCell"];
        }
        NSMutableArray *timerLaps = [self.arrayOfLaps objectAtIndex:indexPath.section];
        Timer *timer = [self.timers objectAtIndex:indexPath.row];
        [cell setTimerName:timer.name];
        if ([timerLaps objectAtIndex:indexPath.row] != [NSNull null]) // if a lap for this timer exists for this row
            [cell setLapString:[Timer stringFromTimeInterval:[[timerLaps objectAtIndex:indexPath.row] doubleValue]]];
        else
            [cell setLapString:@"---"];
        [cell setNameColor:timer.thumb];
        [cell refresh];
        return cell;
    }
    
    
}

-(DeltaColor) colorForDeltaString:(NSString*)deltaString
{
    if ([deltaString characterAtIndex:0] == '+')
        return DeltaIsRed;
    else if ([deltaString characterAtIndex:0] == '-')
        return DeltaIsGreen;
    else
        return DeltaIsGray;
}

-(NSString*)stringForDelta:(NSNumber*)delta
{
    if ([[NSString stringWithFormat:@"%.1f", [delta doubleValue]] isEqualToString:@"0.0"])
    {
        return @"0.0";
    } else if ([delta doubleValue] > 0)
    {
        return [NSString stringWithFormat:@"+%.1f", [delta doubleValue]];
    } else
    {
        return [NSString stringWithFormat:@"%.1f", [delta doubleValue]];
    }
        
}

-(void)tapped:(UITapGestureRecognizer*)recognizer
{
    for (SummaryHeaderView *header in self.headerViews)
    {
        [[header nameTextField] resignFirstResponder];
    }
}

- (void)myShineGradient:(UIView*)myView withColor1:(UIColor*)color1  withColor2:(UIColor*)color2
{
    //   remove old personal shine layer (if any exists):
    int layerNumberNow = [[myView.layer sublayers] count];
    if (layerNumberNow>2) {
        [[[myView.layer sublayers] objectAtIndex:0] removeFromSuperlayer];
    }
    // add shine layer
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    
    [gradientLayer setBounds:[myView bounds]];
    // Center the layer inside the parent layer
    [gradientLayer setPosition:
     CGPointMake([myView bounds].size.width/2,
                 [myView bounds].size.height/2)];
    
    // Set the colors for the gradient to the
    // two colors specified for high and low
    [gradientLayer setColors:
     [NSArray arrayWithObjects:
      (id)[color1 CGColor],(id)[color2 CGColor], nil]];
    [myView.layer insertSublayer:gradientLayer atIndex:layerNumberNow-2];
    
    
}
- (void)setColorForBackGround:(UIView*)myView withColor1:(UIColor*)color1 withColor2:(UIColor*)color2
{
    // add shine layer
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    
    [gradientLayer setBounds:[myView bounds]];
    // Center the layer inside the parent layer
    [gradientLayer setPosition:
     CGPointMake([myView bounds].size.width/2,
                 [myView bounds].size.height/2)];
    
    // Set the colors for the gradient to the
    // two colors specified for high and low
    [gradientLayer setColors:
     [NSArray arrayWithObjects:
      (id)[color1 CGColor],(id)[color2 CGColor], nil]];
    
    [myView.layer setBackgroundColor:[ [UIColor colorWithRed:0 green:0 blue:0 alpha:0] CGColor]];
    
    [myView.layer setCornerRadius:4];
    [[myView layer] setMasksToBounds:YES];
    
    // Display a border around the button
    // with a 1.0 pixel width
    
    [[myView layer] setBorderWidth:1.0f];
    [[myView layer] setBorderColor:[ [UIColor colorWithRed:1 green:1 blue:1 alpha:.1] CGColor] ];
    ///
}

@end
