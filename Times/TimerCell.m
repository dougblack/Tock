//
//  TimerCell.m
//  Times
//
//  Created by Douglas Black on 12/23/12.
//  Copyright (c) 2012 Doug Black. All rights reserved.
//

#import "TimerCell.h"
#import "Timer.h"
#import "TimesViewController.h"
#import "TimesTableView.h"
#import "LapViewController.h"
#import "CommonCLUtility.h"
#import "TriangleView.h"

@implementation TimerCell

@synthesize thumb, lapNumber, timer, running, timesTable;
@synthesize imagePickerController;
@synthesize lastRow;
@synthesize movableViews;
@synthesize deleteButton;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.time = @"00:00.0";
        self.lapNumber = @"1";
        self.lastRow = -1;
        self.movableViews = [NSMutableArray array];
        self.isInDeleteMode = NO;
        
        UIFont *cellFont = [UIFont fontWithName:@"HelveticaNeue-Bold" size:40.0];
        imagePickerController = [[UIImagePickerController alloc] init];
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
            [imagePickerController setSourceType:UIImagePickerControllerSourceTypeCamera];
        [imagePickerController setDelegate:self];
        [self setImagePickerController:imagePickerController];
        
        UISwipeGestureRecognizer *deleteGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRight:)];
        [deleteGestureRecognizer setDirection:UISwipeGestureRecognizerDirectionRight];
        [self addGestureRecognizer:deleteGestureRecognizer];
        
        UISwipeGestureRecognizer *checkLapsGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeft:)];
        [checkLapsGestureRecognizer setDirection:UISwipeGestureRecognizerDirectionLeft];
        [self addGestureRecognizer:checkLapsGestureRecognizer];
        
        UITapGestureRecognizer *splitTimerGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(splitTimer:)];
        [splitTimerGestureRecognizer setNumberOfTouchesRequired:2];
        [self addGestureRecognizer:splitTimerGestureRecognizer];
        ;
        [self setUserInteractionEnabled:YES];
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        UIView *deleteButtonOutline = [[UIView alloc] initWithFrame:CGRectMake(12, 22, 56, 56)];
        [deleteButtonOutline setBackgroundColor:[CommonCLUtility outlineColor]];
        [self.contentView addSubview:deleteButtonOutline];
        
        UILabel *deleteBtn = [[UILabel alloc] initWithFrame:CGRectMake(14, 24, 52, 52)];
        [deleteBtn setText:@"X"];
        [deleteBtn setFont:[UIFont boldSystemFontOfSize:30]];
        [deleteBtn setTextAlignment:NSTextAlignmentCenter];
        [deleteBtn setTextColor:[UIColor whiteColor]];
        [deleteBtn setShadowColor:[UIColor blackColor]];
        [deleteBtn setShadowOffset:CGSizeMake(0, -2)];
        [deleteBtn setBackgroundColor:[UIColor colorWithRed:0.52 green:0 blue:0.08 alpha:1]];
        [deleteBtn setTag:9];
        [deleteBtn addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)]];
        [self setDeleteButton:deleteBtn];
        [self.contentView addSubview:deleteBtn];
        
        UIView *shadowView = [[UIView alloc] initWithFrame:CGRectMake(7.0, 7.0, 306, 86)];
        [shadowView setBackgroundColor:[CommonCLUtility outlineColor]];
        [self.contentView addSubview:shadowView];
        [self.movableViews addObject:shadowView];
        
        UIView *thumbLightView = [[UIView alloc] initWithFrame:CGRectMake(9.0, 9.0, 65, 82)];
        [thumbLightView setBackgroundColor:[CommonCLUtility highlightColor]];
        [thumbLightView setTag:10];
        [self.contentView addSubview:thumbLightView];
        [self.movableViews addObject:thumbLightView];
        
        UIView *thumbBackView = [[UIView alloc] initWithFrame:CGRectMake(10.0, 10.0, 63, 80)];
        [thumbBackView setBackgroundColor:[CommonCLUtility backgroundColor]];
        [thumbBackView setTag:3];
        [thumbBackView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)]];
        [self.contentView addSubview:thumbBackView];
        [self.movableViews addObject:thumbBackView];
        
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 10.0, 63, 20)];
        [nameLabel setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.3]];
        [nameLabel setTextAlignment:NSTextAlignmentCenter];
        [nameLabel setTextColor:[UIColor whiteColor]];
        [nameLabel setFont:[UIFont boldSystemFontOfSize:18]];
        [nameLabel setText:@"CHRISTIAN"];
        [nameLabel setAdjustsFontSizeToFitWidth:YES];
//        [self.contentView addSubview:nameLabel];
        
        UIView *timeLightView = [[UIView alloc] initWithFrame:CGRectMake(76, 9.0, 168, 82)];
        [timeLightView setBackgroundColor:[CommonCLUtility highlightColor]];
        [self.contentView addSubview:timeLightView];
        [self.movableViews addObject:timeLightView];
        
        UILongPressGestureRecognizer *timeResetRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
        [timeResetRecognizer setMinimumPressDuration:2];
        
        UIView *timeBackView = [[UIView alloc] initWithFrame:CGRectMake(77, 10.0, 166, 80)];
        [timeBackView setBackgroundColor:[CommonCLUtility backgroundColor]];
        [timeBackView setTag:4];
        [timeBackView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)]];
        [timeBackView addGestureRecognizer:timeResetRecognizer];
        [self.contentView addSubview:timeBackView];
        [self.movableViews addObject:timeBackView];
        
        UIView *lapLightView = [[UIView alloc] initWithFrame:CGRectMake(246, 9.0, 65, 82)];
        [lapLightView setBackgroundColor:[CommonCLUtility highlightColor]];
        [self.contentView addSubview:lapLightView];
        [self.movableViews addObject:lapLightView];
        
        UIView *lapBackView = [[UIView alloc] initWithFrame:CGRectMake(247.0, 10.0, 63, 80)];
        [lapBackView setBackgroundColor:[CommonCLUtility backgroundColor]];
        [lapBackView setTag:5];
        [lapBackView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)]];
        [self.contentView addSubview:lapBackView];
        [self.movableViews addObject:lapBackView];
        
        UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(77, 39, 166, 45)];
        [timeLabel setText:self.time];
        [timeLabel setOpaque:NO];
        [timeLabel setBackgroundColor:[UIColor clearColor]];
        [timeLabel setTextColor:[UIColor whiteColor]];
        [timeLabel setFont:cellFont];
        [timeLabel setTextAlignment:NSTextAlignmentCenter];
        [timeLabel setTag:1];
        [timeLabel setUserInteractionEnabled:NO];
        [self.contentView addSubview:timeLabel];
        [self.movableViews addObject:timeLabel];
        
        UILabel *lastLapLabel = [[UILabel alloc] initWithFrame:CGRectMake(77, 2, 166, 45)];
        [lastLapLabel setText:@"--:--._"];
        [lastLapLabel setOpaque:NO];
        [lastLapLabel setBackgroundColor:[UIColor clearColor]];
        [lastLapLabel setTextColor:[CommonCLUtility weakTextColor]];
        [lastLapLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:15]];
        [lastLapLabel setTextAlignment:NSTextAlignmentCenter];
        [lastLapLabel setTag:6];
        [self.contentView addSubview:lastLapLabel];
        [self.movableViews addObject:lastLapLabel];
        
        UILabel *lapLabel = [[UILabel alloc] initWithFrame:CGRectMake(247, 39, 63, 45)];
        [lapLabel setText:self.lapNumber];
        [lapLabel setOpaque:NO];
        [lapLabel setBackgroundColor:[UIColor clearColor]];
        [lapLabel setTextColor:[UIColor whiteColor]];
        [lapLabel setFont:cellFont];
        [lapLabel setTextAlignment:NSTextAlignmentCenter];
        [lapLabel setTag:2];
        [lapLabel setAdjustsFontSizeToFitWidth:YES];
        [self.contentView addSubview:lapLabel];
        [self.movableViews addObject:lapLabel];
        
        UILabel *lapTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(247, 2, 63, 45)];
        [lapTextLabel setText:@"LAP"];
        [lapTextLabel setOpaque:NO];
        [lapTextLabel setBackgroundColor:[UIColor clearColor]];
        [lapTextLabel setTextColor:[CommonCLUtility weakTextColor]];
        [lapTextLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:15]];
        [lapTextLabel setTextAlignment:NSTextAlignmentCenter];
        [self.contentView addSubview:lapTextLabel];
        [self.movableViews addObject:lapTextLabel];
        
        TriangleView *triangle = [[TriangleView alloc] init];
        [triangle setFrame:CGRectMake(219, 9, 25, 25)];
        [triangle setBackgroundColor:[UIColor clearColor]];
        [triangle setHidden:YES];
        [triangle setTag:7];
        [self.contentView addSubview:triangle];
        [self.movableViews addObject:triangle];

    }
    return self;
}

-(void)splitTimer:(UITapGestureRecognizer*)sender
{
    if (sender.state == UIGestureRecognizerStateRecognized)
    {
        NSLog(@"SPLIT TIMER");
        Timer *newTimer = [Timer alloc];
        newTimer = [[self timer] copyWithZone:NSZoneFromPointer((__bridge void *)(newTimer))];
        [[[self timesTable] timers] insertObject:newTimer atIndex:[self lastRow]+1];
        [[[self timesTable] tableView] reloadData];
    }
    
}

-(void) swipeRight:(UISwipeGestureRecognizer*)sender
{
    if (!self.isInDeleteMode)
    {
        [self slideCellRight];
    }
    
}

-(void) slideCellRight
{
    self.isInDeleteMode = YES;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelay:0];
    [UIView setAnimationDuration:0.3];
    for (UIView *view in [self movableViews])
    {
        [view setFrame:CGRectMake(view.frame.origin.x+75, view.frame.origin.y, view.frame.size.width, view.frame.size.height)];
    }
    [UIView commitAnimations];
}

-(void) slideCellLeft
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelay:0];
    [UIView setAnimationDuration:0.3];
    for (UIView *view in [self movableViews])
    {
        [view setFrame:CGRectMake(view.frame.origin.x-75, view.frame.origin.y, view.frame.size.width, view.frame.size.height)];
    }
    [UIView commitAnimations];
    self.isInDeleteMode = NO;
}

-(void) swipeLeft:(UISwipeGestureRecognizer*)sender
{
    if (self.isInDeleteMode)
    {
        [self slideCellLeft];
    } else
    {
        LapViewController *lapViewController = [[LapViewController alloc] init];
        [lapViewController setLaps:[[self timer] laps]];
        [lapViewController setLapStrings:[[self timer] lapStrings]];
        [lapViewController setTimer:[self timer]];
        [lapViewController setNumOfLaps:[[self timer] lapNumber]-1];
        [lapViewController setTimesTableView:[[self timesTable] tableView]];
        [[[self timesTable] navigationController] pushViewController:lapViewController animated:YES];
    }
}

-(void)handleTap:(UITapGestureRecognizer*)sender
{
    UIView *senderView = (UIView*)sender.view;
    if (sender.state == UIGestureRecognizerStateRecognized)
    {
        if (self.isInDeleteMode)
        {
            [self slideCellLeft];
            return;
        }
        
        int tag = senderView.tag;
        [senderView setBackgroundColor:[CommonCLUtility selectedColor]];
        switch (tag) {
            case 3: // thumb
                [self highlight:senderView withDuration:0.5 andWait:0];
                [[[self timesTable] navigationController] presentViewController:[self imagePickerController] animated:YES completion:nil];
                break;
            case 4: // time
                [self highlight:senderView withDuration:0.5 andWait:0];
                [[self timer] toggle];
                break;
            case 5: // lap
                [self highlight:senderView withDuration:0.5 andWait:0];
                [[self timer] lap];
                break;
            default:
                [self performSelector:@selector(checkTimers) withObject:[self timesTable] afterDelay:1];
                break;
        }
        
    }
}

-(void)handleLongPress:(UILongPressGestureRecognizer*)sender
{
    if ([[self timer] running]) // ignore if currently running
        return;
    
    [[self timer] reset];
    [self refresh];
    [self setNeedsDisplay];

}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ([touches count] > 1)
        return;
    
    for (UITouch *touch in touches) {
        UIView *view = [touch view];
        CGPoint point = [touch locationInView:self];
        
        if (view.tag == 3 || view.tag == 4 || view.tag == 5)
        {
            if (self.isInDeleteMode)
                return;
            view.backgroundColor = [CommonCLUtility selectedColor];
        }
        
        if (self.isInDeleteMode && point.x >= deleteButton.frame.origin.x && point.x <= deleteButton.frame.origin.x + deleteButton.frame.size.width && point.y >= deleteButton.frame.origin.y && point.y <= deleteButton.frame.origin.y + deleteButton.frame.size.height)
        {
            [deleteButton setBackgroundColor:[UIColor colorWithRed:0.32 green:0 blue:0 alpha:1]];
        }
    }
}

-(void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch *touch in touches) {
        UIView *view = [touch view];
        if (view.tag == 3 || view.tag == 4 || view.tag == 5)
        {
            view.backgroundColor = [CommonCLUtility backgroundColor];
        }
        if (self.isInDeleteMode)
        {
            [deleteButton setBackgroundColor:[UIColor colorWithRed:0.52 green:0 blue:0.08 alpha:1]];
        }
    }
}

-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch *touch in touches)
    {
        UIView *view = [touch view];
        CGPoint point = [touch locationInView:self];
        if (view.tag == 3 || view.tag == 4 || view.tag == 5)
        {
            if (self.isInDeleteMode)
                [self slideCellLeft];
            view.backgroundColor = [CommonCLUtility backgroundColor];
        }
        
        
        if (self.isInDeleteMode && point.x >= deleteButton.frame.origin.x && point.x <= deleteButton.frame.origin.x + deleteButton.frame.size.width && point.y >= deleteButton.frame.origin.y && point.y <= deleteButton.frame.origin.y + deleteButton.frame.size.height)
        {
            // slide back over
            [deleteButton setBackgroundColor:[UIColor colorWithRed:0.52 green:0 blue:0.08 alpha:1]];
            [self slideCellLeft];
            NSIndexPath *pathForThisCell = [(UITableView*)self.superview indexPathForCell:self];
            [[[self timesTable] tableView] beginUpdates];
            [[[self timesTable] timers] removeObjectAtIndex:[pathForThisCell row]];
            [[[self timesTable] tableView] deleteRowsAtIndexPaths:[NSArray arrayWithObject:pathForThisCell] withRowAnimation:UITableViewRowAnimationLeft];
            self.timesTable.numTimers--;
            [[[self timesTable] tableView] endUpdates];
        } else if (self.isInDeleteMode)
        {
            [deleteButton setBackgroundColor:[UIColor colorWithRed:0.52 green:0 blue:0.08 alpha:1]];
        }
    }
}

-(void) refresh
{
    [(UILabel*)[[self contentView] viewWithTag:1] setText:[[self timer] timeString]];
    [(UILabel*)[[self contentView] viewWithTag:6] setText:[[self timer] lastLapString]];
    [(UILabel*)[[self contentView] viewWithTag:2] setText:[NSString stringWithFormat:@"%d", [[self timer]lapNumber]]];
    if ([[self timer] thumb] != nil)
    {
        [[[self contentView] viewWithTag:3] setBackgroundColor:[[self timer] thumb]];
        UIColor *color = [[self timer] thumb];
        const float* colors = CGColorGetComponents(color.CGColor);
        UIColor *lightColor = [UIColor colorWithRed:colors[0]+0.1 green:colors[1]+0.1 blue:colors[2]+0.1 alpha:1];
        [[[self contentView] viewWithTag:10] setBackgroundColor:lightColor];
    } else
        [[[self contentView] viewWithTag:3] setBackgroundColor:[CommonCLUtility backgroundColor]];
    if ([[self timer] running]) {
        [(TriangleView*)[[self contentView] viewWithTag:7] setHidden:NO];
        [(TriangleView*)[[self contentView] viewWithTag:7] setRed:NO];
    }
    else if ([[self timer] stopped]) {
        [(TriangleView*)[[self contentView] viewWithTag:7] setHidden:NO];
        [(TriangleView*)[[self contentView] viewWithTag:7] setRed:YES];
    }
    else
        [(TriangleView*)[[self contentView] viewWithTag:7] setHidden:YES];
    
    [[self timesTable] performSelector:@selector(checkTimers) withObject:nil afterDelay:0.5];
}

-(void)highlight:(UIView *)view withDuration:(NSTimeInterval)duration andWait:(NSTimeInterval)wait
{
    [UIView beginAnimations:@"Fade Out" context:nil];
    [UIView setAnimationDelay:wait];
    [UIView setAnimationDuration:duration];
    view.backgroundColor = [CommonCLUtility backgroundColor];
    [UIView commitAnimations];
}

-(void)start
{
    [[[self contentView] viewWithTag:7] setHidden:NO];
    [(TriangleView*)[[self contentView] viewWithTag:7] setRed:NO];
    [(TriangleView*)[[self contentView] viewWithTag:7] setNeedsDisplay];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *pickedImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    if (pickedImage != nil) {
        [self setThumb:[UIColor colorWithPatternImage:[CommonCLUtility imageWithImage:pickedImage scaledToSize:CGSizeMake(63, 80)]]];
        [self setMiniThumb:[UIColor colorWithPatternImage:[CommonCLUtility imageWithImage:pickedImage scaledToSize:CGSizeMake(31.5, 40)]]];
        [[self timer] setThumb:[self thumb]];
        [[self timer] setMiniThumb:[self miniThumb]];
        [[[self contentView] viewWithTag:3] setBackgroundColor:[self thumb]];
    }

    [[[self timesTable] navigationController] dismissViewControllerAnimated:YES completion:nil];
}

-(void) tick:(NSString *)time withLap:(NSInteger)lap
{
    [self setTime:time];
    [(UILabel*)[[self contentView] viewWithTag:1] setText:time];
    [(UILabel*)[[self contentView] viewWithTag:2] setText:[NSString stringWithFormat:@"%d", (int)lap]];
    [self setLapNumber:[NSString stringWithFormat:@"%d", (int)lap]];

}

-(void)lastLapTimeChanged:(NSString*)lapTime
{
    [(UILabel*)[[self contentView] viewWithTag:6] setText:[NSString stringWithFormat:@"%@", lapTime]];
}

-(void) stop
{
    [self setRunning:NO];
    [(TriangleView*)[[self contentView] viewWithTag:7] setRed:YES];
    [(TriangleView*)[[self contentView] viewWithTag:7] setNeedsDisplay];
}

- (void) setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
