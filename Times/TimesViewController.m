//
//  TimesTable.m
//  Times
//
//  Created by Douglas Black on 12/23/12.
//  Copyright (c) 2012 Doug Black. All rights reserved.
//

#import "TimesViewController.h"

@implementation TimesViewController

@synthesize numTimers, tableView;

- (id)init{
    self = [super init];
    if (self) {
        self.title = NSLocalizedString(@"Times", @"Times");
        self.numTimers = 1;
        self.numSections = 1;
        self.timers = [[NSMutableArray alloc] init];
        
        UILabel *navBarLabel = [[UILabel alloc] init];
        [navBarLabel setText:@"Times"];
        [navBarLabel setBackgroundColor:[UIColor clearColor]];
        [navBarLabel setFont:[UIFont boldSystemFontOfSize:22]];
        [navBarLabel setTextAlignment:NSTextAlignmentCenter];
        [navBarLabel setTextColor:[UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1]];
        [navBarLabel setShadowColor:[UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1]];
        [navBarLabel setShadowOffset:CGSizeMake(1,1)];
        [navBarLabel sizeToFit];
        [self.navigationItem setTitleView:navBarLabel];
    }
    return self;
}

-(void)loadView
{
    TimesTableView *timesTableView = [[TimesTableView alloc] init];
    [timesTableView registerClass:[TimerCell class] forCellReuseIdentifier:@"Cell"];
    [timesTableView registerClass:[NewTimerCell class] forCellReuseIdentifier:@"New"];
    [timesTableView registerClass:[TimerActionCell class] forCellReuseIdentifier:@"Action"];

    [timesTableView setRowHeight:100];
    [timesTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [timesTableView setDelegate:self];
    [timesTableView setDataSource:self];
    [self setTableView:timesTableView];
    [self setView:timesTableView];

}

- (void)newTimer
{
    self.numTimers++;;
    if (self.numTimers == 3)
        self.numTimers++;
    Timer* newTimer = [[Timer alloc] init];
    [newTimer setRow:numTimers-1];
    [[self timers] addObject:[[Timer alloc] init]];
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    UIImageView *backgroundView = [[UIImageView alloc] init];
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    UIColor *topColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1];
    UIColor *bottomColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1];
    gradient.frame = self.view.frame;
    gradient.colors = [NSArray arrayWithObjects:(id)topColor.CGColor, (id)bottomColor.CGColor, nil];
    gradient.startPoint = CGPointMake(0.5f, 0.0f);
    gradient.endPoint = CGPointMake(0.5f, 1.0f);
    [backgroundView.layer addSublayer:gradient];
    
    [(TimesTableView*)self.view setBackgroundColor:nil];
    [(TimesTableView*)self.view setBackgroundView:backgroundView];
    


    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [self numSections];;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self numTimers];
}

- (UITableViewCell *)tableView:(UITableView *)currentTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    static NSString *NewIdentifier = @"New";
    static NSString *ActionIdentifier = @"Action";
    
    if (self.numTimers > 2 && [indexPath row] == 0)
    {
        TimerActionCell *actionCell = (TimerActionCell*)[[TimerActionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ActionIdentifier];
        [actionCell setTimesController:self];
        return actionCell;
    }
    
    if ([indexPath row] == self.numTimers-1) {
        NewTimerCell *new = (NewTimerCell *)[[NewTimerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NewIdentifier andTimesTable:self];
        [new setTimesTable:self];
        return new;
    }
    Timer *timer;
    if (self.numTimers <= 3)
        timer = [[self timers] objectAtIndex:[indexPath row]];
    else
        timer = [[self timers] objectAtIndex:[indexPath row]-1];

    TimerCell *timerCell = (TimerCell *)[currentTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (timerCell == nil) {
        timerCell = (TimerCell *)[[TimerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSLog(@"Row: %d", [indexPath row]);

    [timerCell setTimesTable:self];
    
    [timerCell setSelectionStyle:UITableViewCellSelectionStyleNone];

    [timerCell setLapNumber:[NSString stringWithFormat:@"%d", (int)[timer lapNumber]]];
    [[timerCell timer] setDelegate:nil];
    
    if ([timerCell lastRow] == -1 || ([timerCell lastRow] != [indexPath row]))
    {
        // Recycle the cell
        [timerCell cleanse];
    }
    
    [timerCell setTime:[timer timeString]];
    [timerCell setThumb:[timer thumb]];
    [timerCell setLastLap:[timer lastLapString]];
    [timer setDelegate:timerCell];
    [timerCell setLastRow:[indexPath row]];
    [timerCell setTimer:timer];
    [timerCell refresh];
    return timerCell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

//    if ([indexPath row] == self.numTimers-1) {
//        [self newTimer];
//    } else {
//        [[(TimerCell *)[self.tableView cellForRowAtIndexPath:indexPath] timer] toggle];
//    }

}

@end
