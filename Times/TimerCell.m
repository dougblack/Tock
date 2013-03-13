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
#import "CommonCLUtility.h"
#import "TockSoundPlayer.h"

#define MAX_TIMER_NAME_LENGTH 6

@interface TimerCell ()

@property (nonatomic) UITextField *timerName;
@property (nonatomic) UILabel *deleteButton;
@property (nonatomic) UILabel *lapLabel;
@property (nonatomic) UILabel *timeLabel;
@property (nonatomic) UILabel *lapNumberLabel;
@property (nonatomic) UILabel *flashLabel;
@property (nonatomic) UIView *timerNameBack;

@property (nonatomic) UIImageView *bullsEyeImageView;
@property (nonatomic) BOOL hasGoal;

@property (nonatomic) BOOL isInDeleteMode;

@end

@implementation TimerCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.movableViews = [NSMutableArray array];
        self.isInDeleteMode = NO;
        
        UIFont *cellFont = [UIFont fontWithName:@"HelveticaNeue-Bold" size:40.0];
        
        UISwipeGestureRecognizer *deleteGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRight:)];
        [deleteGestureRecognizer setDirection:UISwipeGestureRecognizerDirectionRight];
        [self addGestureRecognizer:deleteGestureRecognizer];
        
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
        [deleteBtn setBackgroundColor:[UIColor colorWithRed:0.52 green:0 blue:0.08 alpha:1]];
        [deleteBtn setTag:9];
        [deleteBtn addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)]];
        [self setDeleteButton:deleteBtn];
        [self.contentView addSubview:deleteBtn];
        
        UIView *shadowView = [[UIView alloc] initWithFrame:CGRectMake(7.0, 7.0, 306, 86)];
        [shadowView setBackgroundColor:[CommonCLUtility outlineColor]];
        [shadowView setTag:13];
        [self.contentView addSubview:shadowView];
        [self.movableViews addObject:shadowView];
        
        UIView *thumbLightView = [[UIView alloc] initWithFrame:CGRectMake(9.0, 43, 65, 48)];
        [thumbLightView setBackgroundColor:[CommonCLUtility highlightColor]];
        [thumbLightView setTag:10];
        [self.contentView addSubview:thumbLightView];
        [self.movableViews addObject:thumbLightView];
        
        UIView *thumbBackView = [[UIView alloc] initWithFrame:CGRectMake(10.0, 44, 63, 46)];
        [thumbBackView setBackgroundColor:[CommonCLUtility backgroundColor]];
        [thumbBackView setTag:3];
        [thumbBackView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)]];
        [self.contentView addSubview:thumbBackView];
        [self.movableViews addObject:thumbBackView];
        
        UIImageView *bullsEyeImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bulls_eye"]];
        [bullsEyeImage setFrame:CGRectMake(26.5, 52, 30, 30)];
        self.bullsEyeImageView = bullsEyeImage;
        [self.movableViews addObject:bullsEyeImage];
        [self.contentView addSubview:bullsEyeImage];
        
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 10.0, 63, 20)];
        [nameLabel setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.3]];
        [nameLabel setTextAlignment:NSTextAlignmentCenter];
        [nameLabel setTextColor:[UIColor whiteColor]];
        [nameLabel setFont:[UIFont boldSystemFontOfSize:18]];
        [nameLabel setText:@"CHRISTIAN"];
        [nameLabel setAdjustsFontSizeToFitWidth:YES];
        
        UIView *timeLightView = [[UIView alloc] initWithFrame:CGRectMake(76, 9.0, 168, 82)];
        [timeLightView setBackgroundColor:[CommonCLUtility highlightColor]];
        [timeLightView setTag:11];
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
        [lapLightView setTag:12];
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
        self.timeLabel = timeLabel;
        [self.contentView addSubview:timeLabel];
        [self.movableViews addObject:timeLabel];
        
        UILabel *lastLapLabel = [[UILabel alloc] initWithFrame:CGRectMake(77, 2, 166, 45)];
        [lastLapLabel setText:@"--:--._"];
        [lastLapLabel setOpaque:NO];
        [lastLapLabel setBackgroundColor:[UIColor clearColor]];
        [lastLapLabel setTextColor:[UIColor whiteColor]];
        [lastLapLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:15]];
        [lastLapLabel setTextAlignment:NSTextAlignmentCenter];
        [lastLapLabel setTag:6];
        self.lapLabel = lastLapLabel;
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
        [lapLabel setNumberOfLines:1];
        [self.contentView addSubview:lapLabel];
        [self.movableViews addObject:lapLabel];
        
        UILabel *lapTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(247, 2, 63, 45)];
        [lapTextLabel setText:@"LAP"];
        [lapTextLabel setOpaque:NO];
        [lapTextLabel setBackgroundColor:[UIColor clearColor]];
        [lapTextLabel setTextColor:[UIColor whiteColor]];
        [lapTextLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:15]];
        [lapTextLabel setTextAlignment:NSTextAlignmentCenter];
        [self.contentView addSubview:lapTextLabel];
        [self.movableViews addObject:lapTextLabel];
        
        UILabel *flashLabel = [[UILabel alloc] initWithFrame:CGRectMake(77, 20, 166, 59)];
        [flashLabel setTextColor:[UIColor whiteColor]];
        [flashLabel setText:@"GOAL TIME\nSET"];
        [flashLabel setFont:[UIFont boldSystemFontOfSize:18]];
        [flashLabel setBackgroundColor:[UIColor clearColor]];
        [flashLabel setTextAlignment:NSTextAlignmentCenter];
        [flashLabel setAdjustsFontSizeToFitWidth:YES];
        flashLabel.alpha = 0.0;
        flashLabel.numberOfLines = 2;
        self.flashLabel = flashLabel;
        [self.movableViews addObject:flashLabel];
        [self.contentView addSubview:flashLabel];
        
        UITextField *timerName = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, 63, 30)];
        [timerName setTextColor:[UIColor whiteColor]];
        [timerName setMinimumFontSize:3.0];
        timerName.autocapitalizationType = UITextAutocapitalizationTypeAllCharacters;
        [timerName setFont:[UIFont boldSystemFontOfSize:15.0]];
        [timerName setAdjustsFontSizeToFitWidth:YES];
        timerName.borderStyle = UITextBorderStyleNone;
        timerName.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        timerName.textAlignment = NSTextAlignmentCenter;
        timerName.delegate = self;
        timerName.autocorrectionType = UITextAutocorrectionTypeNo;
        
        UIView *timerNameBack = [[UIView alloc] initWithFrame:CGRectMake(9, 9, 65, 32)];
        [timerNameBack setBackgroundColor:[CommonCLUtility highlightColor]];
        self.timerNameBack = timerNameBack;
        [self.movableViews addObject:timerNameBack];
        [self.contentView addSubview:timerNameBack];

        self.timerName = timerName;
        [self.movableViews addObject:timerName];
        [self.contentView addSubview:timerName];

    }
    return self;
}

-(void)showFlash:(NSString*)flashString;
{
    self.flashLabel.text = flashString;
    
    self.lapLabel.alpha = 0.0;
    self.timeLabel.alpha = 0.0;
    self.flashLabel.alpha = 1.0;
    
    [UIView beginAnimations:@"HIDE" context:nil];
    [UIView setAnimationDelay:2.0];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    self.lapLabel.alpha = 1.0;
    self.timeLabel.alpha = 1.0;
    self.flashLabel.alpha = 0.0;
    [UIView commitAnimations];
}

-(void)splitTimer:(UITapGestureRecognizer*)sender
{
    if (sender.state == UIGestureRecognizerStateRecognized)
    {
        Timer *newTimer = [Timer alloc];
        newTimer = [[self timer] copyWithZone:NSZoneFromPointer((__bridge void *)(newTimer))];
        [self.timesTable.timers insertObject:newTimer atIndex:self.row+1];
        [self.timesTable.tableView reloadData];
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
        if (tag != 3)
        {
            UIColor *color = [self.timer thumb];
            const float* colors = CGColorGetComponents(color.CGColor);
            UIColor *lightColor = [UIColor colorWithRed:colors[0]+0.3 green:colors[1]+0.3 blue:colors[2]+0.3 alpha:1];
            senderView.backgroundColor = lightColor;
        }
        switch (tag) {
            case 3:
            {
                [self.timesTable showPickerViewForTimer:self.timer];
                break;
            }// thumb
            case 4: // time
                [self highlightAll:senderView withDuration:0.5 andWait:0];
                [[self timesTable] performSelector:@selector(checkTimers) withObject:[self timesTable] afterDelay:0];
                [[self timer] toggle];
                break;
            case 5: // lap
                [self highlight:senderView withDuration:0.5 andWait:0];
                [[self timesTable] performSelector:@selector(checkTimers) withObject:[self timesTable] afterDelay:0];
                [[self timer] lap];
                break;
            default:
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
            UIColor *color = [self.timer thumb];
            const float* colors = CGColorGetComponents(color.CGColor);
            UIColor *lightColor = [UIColor colorWithRed:colors[0]+0.3 green:colors[1]+0.3 blue:colors[2]+0.3 alpha:1];
            view.backgroundColor = lightColor;
        }
        
        if (self.isInDeleteMode && point.x >= self.deleteButton.frame.origin.x && point.x <= self.deleteButton.frame.origin.x + self.deleteButton.frame.size.width && point.y >= self.deleteButton.frame.origin.y && point.y <= self.deleteButton.frame.origin.y + self.deleteButton.frame.size.height)
        {
            [self.deleteButton setBackgroundColor:[UIColor colorWithRed:0.32 green:0 blue:0 alpha:1]];
        }
    }
}

-(void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch *touch in touches) {
        UIView *view = [touch view];
        if (view.tag == 3 || view.tag == 4 || view.tag == 5)
        {
            if (self.timer.flagType == FlagTypeGreen)
                view.backgroundColor = [self.timer thumb];
            else
                view.backgroundColor = [CommonCLUtility backgroundColor];
        }
        if (self.isInDeleteMode)
        {
            [self.deleteButton setBackgroundColor:[UIColor colorWithRed:0.52 green:0 blue:0.08 alpha:1]];
        }
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch *touch in touches) {
        UIView *view = [touch view];
        if (view.tag == 3 || view.tag == 4 || view.tag == 5)
        {
            if (self.timer.flagType == FlagTypeGreen)
                view.backgroundColor = [self.timer thumb];
            else
                view.backgroundColor = [CommonCLUtility backgroundColor];
        }
        if (self.isInDeleteMode)
        {
            [self.deleteButton setBackgroundColor:[UIColor colorWithRed:0.52 green:0 blue:0.08 alpha:1]];
        }
    }
    [self.nextResponder touchesMoved:touches withEvent:event];
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
            if (self.timer.flagType == FlagTypeGreen)
                view.backgroundColor = [self.timer thumb];
            else
                view.backgroundColor = [CommonCLUtility backgroundColor];
        }
        
        
        if (self.isInDeleteMode && point.x >= self.deleteButton.frame.origin.x && point.x <= self.deleteButton.frame.origin.x + self.deleteButton.frame.size.width && point.y >= self.deleteButton.frame.origin.y && point.y <= self.deleteButton.frame.origin.y + self.deleteButton.frame.size.height)
        {
            // slide back over
            [self.deleteButton setBackgroundColor:[UIColor colorWithRed:0.52 green:0 blue:0.08 alpha:1]];
            [self slideCellLeft];
            NSIndexPath *pathForThisCell = [(UITableView*)self.superview indexPathForCell:self];
            [self.timesTable.tableView beginUpdates];
            [self.timesTable.timers removeObjectAtIndex:[pathForThisCell row]];
            [self.timesTable.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:pathForThisCell] withRowAnimation:UITableViewRowAnimationLeft];
            self.timesTable.numTimers--;
            [self.timesTable.tableView endUpdates];
            
            [TockSoundPlayer playSoundWithName:@"swish" andExtension:@"wav" andVolume:0.05];
        } else if (self.isInDeleteMode)
        {
            [self.deleteButton setBackgroundColor:[UIColor colorWithRed:0.52 green:0 blue:0.08 alpha:1]];
        }
    }
}

-(void) refresh
{
    [(UILabel*)[self.contentView viewWithTag:1] setText:[[self timer] timeString]];
    [(UILabel*)[self.contentView viewWithTag:6] setText:[[self timer] lastLapString]];
    [(UILabel*)[self.contentView viewWithTag:2] setText:[NSString stringWithFormat:@"%d", [[self timer]lapNumber]]];
    
    [self.bullsEyeImageView removeFromSuperview];
    [self.movableViews removeObject:self.bullsEyeImageView];
    if (self.timer.goalLap != -1) {
        self.bullsEyeImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bulls_eye_white_nostroke.png"]];
    } else {
        self.bullsEyeImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bulls_eye.png"]];
    }
    [self.bullsEyeImageView setFrame:CGRectMake(26.5, 52, 30, 30)];
    [self.movableViews addObject:self.bullsEyeImageView];
    [self.contentView addSubview:self.bullsEyeImageView];
    
    
    
    self.timerName.backgroundColor = [self.timer thumb];
    self.timerName.text = self.timer.name;
    
    switch ([self.timer flagType]) {
            
        case FlagTypeGreen:
        {
            [[self.contentView viewWithTag:3] setBackgroundColor:[[self timer] thumb]];
            UIColor *color = [[self timer] thumb];
            const float* colors = CGColorGetComponents(color.CGColor);
            UIColor *lightColor = [UIColor colorWithRed:colors[0]+0.1 green:colors[1]+0.1 blue:colors[2]+0.1 alpha:1];
            [[self.contentView viewWithTag:10] setBackgroundColor:lightColor];
            [[self.contentView viewWithTag:11] setBackgroundColor:lightColor];
            [[self.contentView viewWithTag:12] setBackgroundColor:lightColor];
            [self.timerNameBack setBackgroundColor:lightColor];
            [[self.contentView viewWithTag:3] setBackgroundColor:[self.timer thumb]];
            [[self.contentView viewWithTag:4] setBackgroundColor:[self.timer thumb]];
            [[self.contentView viewWithTag:5] setBackgroundColor:[self.timer thumb]];
            break;
        }
        default:
        {
            UIColor *offColor = [CommonCLUtility backgroundColor];
            UIColor *lightColor = [CommonCLUtility highlightColor];
            [[self.contentView viewWithTag:3] setBackgroundColor:offColor];
            [[self.contentView viewWithTag:10] setBackgroundColor:lightColor];
            [[self.contentView viewWithTag:11] setBackgroundColor:lightColor];
            [[self.contentView viewWithTag:12] setBackgroundColor:lightColor];
            [self.timerNameBack setBackgroundColor:lightColor];
            [[self.contentView viewWithTag:3] setBackgroundColor:offColor];
            [[self.contentView viewWithTag:4] setBackgroundColor:offColor];
            [[self.contentView viewWithTag:5] setBackgroundColor:offColor];
//            [self.contentView setBackgroundColor:[CommonCLUtility viewDarkBackColor]];
            break;
        }
    }
    [[self timesTable] performSelector:@selector(checkTimers) withObject:nil afterDelay:0];
}

-(void)highlightAll:(UIView *)view withDuration:(NSTimeInterval)duration andWait:(NSTimeInterval)wait
{

    [UIView beginAnimations:@"Fade Out" context:nil];
    [UIView setAnimationDelay:0];
    [UIView setAnimationDuration:0.25];
    
    // Flag type is about to switch so check against previous type
    if (self.timer.flagType != FlagTypeGreen)
    {
        [[self.contentView viewWithTag:3] setBackgroundColor:[[self timer] thumb]];
        UIColor *color = [[self timer] thumb];
        const float* colors = CGColorGetComponents(color.CGColor);
        UIColor *lightColor = [UIColor colorWithRed:colors[0]+0.1 green:colors[1]+0.1 blue:colors[2]+0.1 alpha:1];
        [[self.contentView viewWithTag:10] setBackgroundColor:lightColor];
        [[self.contentView viewWithTag:11] setBackgroundColor:lightColor];
        [[self.contentView viewWithTag:12] setBackgroundColor:lightColor];
        [self.timerNameBack setBackgroundColor:lightColor];
        [[self.contentView viewWithTag:3] setBackgroundColor:[self.timer thumb]];
        [[self.contentView viewWithTag:4] setBackgroundColor:[self.timer thumb]];
        [[self.contentView viewWithTag:5] setBackgroundColor:[self.timer thumb]];
    }
    else
    {
        UIColor *offColor = [CommonCLUtility backgroundColor];
        UIColor *lightColor = [CommonCLUtility highlightColor];
        [[self.contentView viewWithTag:3] setBackgroundColor:offColor];
        [[self.contentView viewWithTag:10] setBackgroundColor:lightColor];
        [[self.contentView viewWithTag:11] setBackgroundColor:lightColor];
        [[self.contentView viewWithTag:12] setBackgroundColor:lightColor];
        [self.timerNameBack setBackgroundColor:lightColor];
        [[self.contentView viewWithTag:3] setBackgroundColor:offColor];
        [[self.contentView viewWithTag:4] setBackgroundColor:offColor];
        [[self.contentView viewWithTag:5] setBackgroundColor:offColor];
    }
    [UIView commitAnimations];
}

-(void)highlight:(UIView *)view withDuration:(NSTimeInterval)duration andWait:(NSTimeInterval)wait
{
    
    [UIView beginAnimations:@"Fade Out" context:nil];
    [UIView setAnimationDelay:wait];
    [UIView setAnimationDuration:0.25];
    
    // Flag type will not switch so check against current type
    if (self.timer.flagType == FlagTypeGreen)
    {
        UIColor *color = [[self timer] thumb];
        const float* colors = CGColorGetComponents(color.CGColor);
        UIColor *lightColor = [UIColor colorWithRed:colors[0]+0.1 green:colors[1]+0.1 blue:colors[2]+0.1 alpha:1];
        [[self.contentView viewWithTag:12] setBackgroundColor:lightColor];
        [[self.contentView viewWithTag:5] setBackgroundColor:[self.timer thumb]];
    }
    else
    {
        UIColor *offColor = [CommonCLUtility backgroundColor];
        UIColor *lightColor = [CommonCLUtility highlightColor];
        [[self.contentView viewWithTag:12] setBackgroundColor:lightColor];
        [[self.contentView viewWithTag:5] setBackgroundColor:offColor];
    }
    [UIView commitAnimations];
}

-(void) tick:(NSString *)time withLap:(NSInteger)lap
{
    [self setTime:time];
    [(UILabel*)[self.contentView viewWithTag:1] setText:time];
    [(UILabel*)[self.contentView viewWithTag:2] setText:[NSString stringWithFormat:@"%d", (int)lap]];
    [self setLapNumber:[NSString stringWithFormat:@"%d", (int)lap]];

}

-(void)lastLapTimeChanged:(NSString*)lapTime
{
    [(UILabel*)[self.contentView viewWithTag:6] setText:[NSString stringWithFormat:@"%@", lapTime]];
}

- (void) setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

#pragma mark - UITextFieldDelegate methods

// Adjusts inset so that the cell is visible.
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.timesTable.tableView.contentInset = UIEdgeInsetsMake(0, 0, 200, 0);
    [self.timesTable.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.row inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

// Resets inset.
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [self.timer setName:textField.text];
    self.timesTable.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
}

// Makes all characters uppercase
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    int newLength = (textField.text.length - range.length) + string.length;
    if (newLength <= MAX_TIMER_NAME_LENGTH)
        textField.text = [textField.text stringByReplacingCharactersInRange:range withString:[string uppercaseString]];
    return NO;
}

// Closes keyboard
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    self.timer.name = textField.text;
    [textField resignFirstResponder];
    return YES;
}

@end
