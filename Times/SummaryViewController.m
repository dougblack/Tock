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

@interface SummaryViewController ()

@property (nonatomic) NSMutableArray *headerViews;
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
        for (Timer *timer in timers)
        {
            NSMutableDictionary *thisTimersDeltas = [[NSMutableDictionary alloc] init];
            NSMutableArray *previousLapDeltas = [NSMutableArray array];
            NSMutableArray *goalLapDeltas = [NSMutableArray array];
            NSMutableArray *avgLapDeltas = [NSMutableArray array];
            NSTimeInterval previousLap = 0;
            double goal = [timer goalLap];
            double avg = [timer avgLap];
            for (NSNumber *lap in [timer laps])
            {
                double lapDouble = [lap doubleValue];
                if (previousLap == 0)
                    [previousLapDeltas addObject:[NSNull null]];
                else
                {
                    double delta = lapDouble - previousLap;
                    [previousLapDeltas addObject:[NSNumber numberWithDouble:delta]];
                }
                [goalLapDeltas addObject:[NSNumber numberWithDouble:(lapDouble-goal)]];
                [avgLapDeltas addObject:[NSNumber numberWithDouble:(lapDouble-avg)]];
                previousLap = lapDouble;
            }
            [thisTimersDeltas setObject:previousLapDeltas forKey:@"Previous"];
            [thisTimersDeltas setObject:goalLapDeltas forKey:@"Goal"];
            [thisTimersDeltas setObject:avgLapDeltas forKey:@"Avg"];
            [self.timersData addObject:thisTimersDeltas];
            SummaryHeaderView *headerView = [[SummaryHeaderView alloc] initWithThumb:timer.thumb andTimerNumber:i andTimer:timer];
            [self.headerViews addObject:headerView];
            i++;
        }
        self.timers = timers;
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
    
    SummaryTableView *summaryTableView = [[SummaryTableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [summaryTableView registerClass:[SummaryCell class] forCellReuseIdentifier:@"SummaryCell"];
    [summaryTableView registerClass:[NoLapsCell class] forCellReuseIdentifier:@"NoLapsCell"];
    [summaryTableView registerClass:[SummaryHeaderCell class] forCellReuseIdentifier:@"HeaderCell"];
    [summaryTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [summaryTableView setDelegate:self];
    [summaryTableView setDataSource:self];
    [summaryTableView setBackgroundColor:[CommonCLUtility viewDarkBackColor]];
    [summaryTableView setShowsVerticalScrollIndicator:NO];
    [summaryTableView addGestureRecognizer:tapRecognizer];
    [self setTableView:summaryTableView];
    [self.view addSubview:summaryTableView];
    
}

-(void)deltaChanged:(UISegmentedControl*)control
{
    for (int i=0; i<[control.subviews count]; i++)
    {
        if ([[control.subviews objectAtIndex:i] isSelected] )
        {
            if (i == 0)
                self.deltaType = DeltaFromPreviousLap;
            else if (i == 1)
                self.deltaType = DeltaFromGoalLap;
            else if (i == 2)
                self.deltaType = DeltaFromAverageLap;
            
            UIColor *tintcolor=[UIColor redColor];
            [[control.subviews objectAtIndex:i] setTintColor:tintcolor];
        } else {
            UIColor *tintcolor=[UIColor colorWithRed:0.05 green:0.05 blue:0.05 alpha:1]; // default color
            [[control.subviews objectAtIndex:i] setTintColor:tintcolor];
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
    return 60;
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self timers] count];
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    Timer *timer = [[self timers] objectAtIndex:section];
    if ([[timer laps] count] == 0)
        return 2;
    return [[timer laps] count]+1;
}

-(UIView*) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [self.headerViews objectAtIndex:section];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *SummaryCellIdentifier = @"SummaryCell";
    static NSString *NoLapsCellIdentifier = @"NoLapsCell";
    static NSString *HeaderCellIdentifier = @"HeaderCell";
    
    Timer *timer = [[self timers] objectAtIndex:indexPath.section];
    
    if (indexPath.row == 0)
    {
        SummaryHeaderCell *header = (SummaryHeaderCell*) [tableView dequeueReusableCellWithIdentifier:HeaderCellIdentifier];
        if (header == nil)
        {
            header = [[SummaryHeaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:HeaderCellIdentifier andTimer:timer];
        }
        [header setTime:[timer timeString]];
        [header setAvg:[Timer stringFromTimeInterval:[timer avgLap]]];
        [header setGoal:@"---"];
        [header setTimer:timer];
        [header refresh];
        return header;
    }

    if ([[timer laps] count] == 0 && indexPath.row == 1)
    {
        NoLapsCell *noLapsCell = (NoLapsCell*) [tableView dequeueReusableCellWithIdentifier:NoLapsCellIdentifier];
        if (noLapsCell == nil)
        {
            noLapsCell = [[NoLapsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NoLapsCellIdentifier];
        }
        return noLapsCell;
    }
    
    SummaryCell *summaryCell = (SummaryCell*) [tableView dequeueReusableCellWithIdentifier:SummaryCellIdentifier];
    
    if (summaryCell == nil)
    {
        summaryCell = [[SummaryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SummaryCellIdentifier];
    }
    
    [summaryCell setLapTimeString:[[timer lapStrings] objectAtIndex:indexPath.row-1]];
    
    NSMutableDictionary *timerDict = (NSMutableDictionary*)[self.timersData objectAtIndex:indexPath.section];
    switch (self.deltaType) {
        case DeltaFromPreviousLap:
        {
            NSMutableArray *previousLapDeltas = [timerDict objectForKey:@"Previous"];
            NSNumber *delta = [previousLapDeltas objectAtIndex:indexPath.row-1];
            
            if (delta != [NSNull null])
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
            } else {
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
            NSString *deltaString = [self stringForDelta:delta];
            DeltaColor deltaColor = [self colorForDeltaString:deltaString];
            [summaryCell setLapDelta:deltaString];
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

@end
