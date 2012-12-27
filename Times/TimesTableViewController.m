//
//  TimesTable.m
//  Times
//
//  Created by Douglas Black on 12/23/12.
//  Copyright (c) 2012 Doug Black. All rights reserved.
//

#import "TimesTableViewController.h"

@implementation TimesTableViewController

@synthesize numTimers;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.title = NSLocalizedString(@"Times", @"Times");
        self.numTimers = 1;
        self.numSections = 1;
        [[self tableView] registerClass:[TimerCell class] forCellReuseIdentifier:@"Cell"];
        [[self tableView] registerClass:[NewTimerCell class] forCellReuseIdentifier:@"New"];
        [[self tableView] setDelaysContentTouches:YES];
    }
    return self;
}

- (void)newTimer
{
    self.numTimers++;;
    [[self timers] addObject:[[Timer alloc] init]];
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
 
    self.tableView.rowHeight = 100;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UIImageView *backgroundView = [[UIImageView alloc] init];
    CAGradientLayer *gradient = [CAGradientLayer layer];
    ls
    UIColor *topColor = [UIColor colorWithRed:0.26 green:0.26 blue:0.26 alpha:1];
    UIColor *bottomColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1];
    gradient.frame = self.tableView.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)topColor.CGColor, (id)bottomColor.CGColor, nil];
    gradient.startPoint = CGPointMake(0.5f, 0.0f);
    gradient.endPoint = CGPointMake(0.5f, 1.0f);
    [backgroundView.layer addSublayer:gradient];
    self.tableView.backgroundView = backgroundView;

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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    static NSString *NewIdentifier = @"New";
    if ([indexPath row] == self.numTimers-1) {
        NewTimerCell *new = (NewTimerCell *)[[NewTimerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NewIdentifier andTimesTable:self];
        [new setTimesTable:self];
        return new;
    }
    
    
    TimerCell *timer = (TimerCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (timer == nil) {
        timer = (TimerCell *)[[TimerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        [timer setTimesTable:self];
        [timer setTimesTable:self];
        [timer setCurrentTime:@"00:00.00"];
        [timer setLapNumber:@"1"];
    } else {
        [timer reset];
    }

    UIView *thumb = [UIView alloc];
    thumb.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"debut_light.png"]];
    [timer setThumb:thumb];
    [timer setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return timer;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
    if ([indexPath row] == self.numTimers-1) {
        [self newTimer];
    } else {
        [[(TimerCell *)[self.tableView cellForRowAtIndexPath:indexPath] timer] toggle];
    }

}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];  //let the tableview handle cell selection
    [self.nextResponder touchesBegan:touches withEvent:event]; // give the controller a chance for handling touch events
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self.nextResponder touchesEnded:touches withEvent:event];
}

@end
