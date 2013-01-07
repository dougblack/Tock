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
#import "Timer.h"
#import "CommonCLUtility.h"
#import "NoLapsCell.h"

@implementation SummaryViewController

- (id)initWithTimers:(NSMutableArray*)timers
{
    self = [super init];
    if (self) {
        UILabel *navBarLabel = [[UILabel alloc] init];
        [navBarLabel setText:@"Summary"];
        [navBarLabel setBackgroundColor:[UIColor clearColor]];
        [navBarLabel setFont:[UIFont boldSystemFontOfSize:20]];
        [navBarLabel setTextAlignment:NSTextAlignmentCenter];
        [navBarLabel setTextColor:[UIColor whiteColor]];
        
        [navBarLabel setShadowOffset:CGSizeMake(1,1)];
        [navBarLabel sizeToFit];
        [self.navigationItem setTitleView:navBarLabel];
        [self.navigationItem.leftBarButtonItem setTitle:@"Back"];
        
        self.timersData = [NSMutableArray array];
        
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
    
    SummaryTableView *summaryTableView = [[SummaryTableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [summaryTableView registerClass:[SummaryCell class] forCellReuseIdentifier:@"SummaryCell"];
    [summaryTableView registerClass:[NoLapsCell class] forCellReuseIdentifier:@"NoLapsCell"];
    [summaryTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [summaryTableView setDelegate:self];
    [summaryTableView setDataSource:self];
    [summaryTableView setBackgroundColor:[CommonCLUtility viewDarkBackColor]];
    [summaryTableView setShowsVerticalScrollIndicator:NO];
    [summaryTableView addGestureRecognizer:backRecognizer];
    [self setTableView:summaryTableView];
    [self.view addSubview:summaryTableView];
    
}

-(void)back:(UISwipeGestureRecognizer*)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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
        return 1;
    return [[timer laps] count];
}

-(UIView*) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    Timer* timer = [[self timers] objectAtIndex:section];
    SummaryHeaderView *headerView = [[SummaryHeaderView alloc] initWithThumb:[timer miniThumb] andTimerNumber:section+1];
    return headerView;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *SummaryCellIdentifier = @"SummaryCell";
    static NSString *NoLapsCellIdentifier = @"NoLapsCell";
    
    Timer *timer = [[self timers] objectAtIndex:indexPath.section];
    
    if ([[timer laps] count] == 0)
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
    
    [summaryCell setLapTimeString:[[timer lapStrings] objectAtIndex:indexPath.row]];
    
    switch (self.deltaType) {
        case DeltaFromPreviousLap:
        {
            NSMutableDictionary *timerDict = (NSMutableDictionary*)[self.timersData objectAtIndex:indexPath.section];
            NSMutableArray *previousLapDeltas = [timerDict objectForKey:@"Previous"];
            NSNumber *delta = [previousLapDeltas objectAtIndex:indexPath.row];
            if (delta != [NSNull null])
            {
                NSString *lapDeltaString;
                
                
                if ([delta doubleValue] < 0)
                {
                    lapDeltaString = [NSString stringWithFormat:@"%.1f", [delta doubleValue]];
                    [summaryCell setDeltaColor:DeltaIsGreen];
                } else {
                    lapDeltaString = [NSString stringWithFormat:@"+%.1f", [delta doubleValue]];
                    [summaryCell setDeltaColor:DeltaIsRed];
                }
                
                if ([lapDeltaString isEqualToString:@"-0.0"] || [lapDeltaString isEqualToString:@"+0.0"])
                {
                    lapDeltaString = @"0.0";
                    [summaryCell setDeltaColor:DeltaIsGreen];
                }
                
                [summaryCell setLapDelta:lapDeltaString];
            }
            
            else
            {
                [summaryCell setLapDelta:@"---"];
                [summaryCell setDeltaColor:DeltaIsGray];
                
            }
            
            summaryCell.lapDeltaLabel.hidden = NO;
            break;
        }
        case DeltaFromAverageLap:
        {
            NSMutableDictionary *timerDict = (NSMutableDictionary*)[self.timersData objectAtIndex:indexPath.section];
            NSMutableArray *avgLapDeltas = [timerDict objectForKey:@"Avg"];
            NSNumber *delta = [avgLapDeltas objectAtIndex:indexPath.row];
            [summaryCell setLapDelta:[delta stringValue]];
            summaryCell.lapDeltaLabel.hidden = NO;
            break;
        }
        case DeltaFromGoalLap:
        {
            NSMutableDictionary *timerDict = (NSMutableDictionary*)[self.timersData objectAtIndex:indexPath.section];
            NSMutableArray *goalLapDeltas = [timerDict objectForKey:@"Goal"];
            NSNumber *delta = [goalLapDeltas objectAtIndex:indexPath.row];
            [summaryCell setLapDelta:[delta stringValue]];
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
    
    [summaryCell setLapNumber:indexPath.row+1];
    summaryCell.controller = self;
    [summaryCell refresh];
    return summaryCell;
}


@end
