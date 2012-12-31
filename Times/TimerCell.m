//
//  TimerCell.m
//  Times
//
//  Created by Douglas Black on 12/23/12.
//  Copyright (c) 2012 Doug Black. All rights reserved.
//

#import "TimerCell.h"

@implementation TimerCell

@synthesize thumb, lapNumber, timer, running, timesTable;
@synthesize imagePickerController;
@synthesize lastRow;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.time = @"00:00.0";
        self.lapNumber = @"1";
        self.lastRow = -1;
        UIFont *cellFont = [UIFont fontWithName:@"HelveticaNeue-Bold" size:40.0];
        
        UIView *shadowView = [[UIView alloc] initWithFrame:CGRectMake(7.0, 7.0, 306, 86)];
        [shadowView setBackgroundColor:[UIColor blackColor]];
        [self.contentView addSubview:shadowView];
        
        UIView *thumbLightView = [[UIView alloc] initWithFrame:CGRectMake(9.0, 9.0, 65, 82)];
        [thumbLightView setBackgroundColor:[UIColor colorWithRed:0.35 green:0.35 blue:0.35 alpha:1]];
        UIView *thumbBackView = [[UIView alloc] initWithFrame:CGRectMake(10.0, 10.0, 63, 80)];
        [thumbBackView setBackgroundColor:[UIColor colorWithRed:0.26 green:.26 blue:.26 alpha:1]];
        [thumbBackView setTag:3];
        [self.contentView addSubview:thumbLightView];
        [self.contentView addSubview:thumbBackView];
        
        UIView *timeLightView = [[UIView alloc] initWithFrame:CGRectMake(76, 9.0, 168, 82)];
        [timeLightView setBackgroundColor:[UIColor colorWithRed:0.35 green:0.35 blue:0.35 alpha:1]];
        UIView *timeBackView = [[UIView alloc] initWithFrame:CGRectMake(77, 10.0, 166, 80)];
        [timeBackView setBackgroundColor:[UIColor colorWithRed:0.26 green:.26 blue:.26 alpha:1]];
        [timeBackView setTag:4];
        [self.contentView addSubview:timeLightView];
        [self.contentView addSubview:timeBackView];
        
        UIView *lapLightView = [[UIView alloc] initWithFrame:CGRectMake(246, 9.0, 65, 82)];
        [lapLightView setBackgroundColor:[UIColor colorWithRed:0.35 green:0.35 blue:0.35 alpha:1]];
        UIView *lapBackView = [[UIView alloc] initWithFrame:CGRectMake(247.0, 10.0, 63, 80)];
        [lapBackView setBackgroundColor:[UIColor colorWithRed:0.26 green:.26 blue:.26 alpha:1]];
        [lapBackView setTag:5];
        [self.contentView addSubview:lapLightView];
        [self.contentView addSubview:lapBackView];
        
        UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(77, 39, 166, 45)];
        [timeLabel setText:self.time];
        [timeLabel setOpaque:NO];
        [timeLabel setBackgroundColor:[UIColor clearColor]];
        [timeLabel setTextColor:[UIColor whiteColor]];
        [timeLabel setFont:cellFont];
        [timeLabel setTextAlignment:NSTextAlignmentCenter];
        [timeLabel setTag:1];
        [self.contentView addSubview:timeLabel];
        
        UILabel *lastLapLabel = [[UILabel alloc] initWithFrame:CGRectMake(77, 2, 166, 45)];
        [lastLapLabel setText:@"LAST LAP: 00:00.0"];
        [lastLapLabel setOpaque:NO];
        [lastLapLabel setBackgroundColor:[UIColor clearColor]];
        [lastLapLabel setTextColor:[UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1]];
        //        [lapTextLabel setTextColor:[UIColor blackColor]];
        [lastLapLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:15]];
        [lastLapLabel setTextAlignment:NSTextAlignmentCenter];
        [lastLapLabel setTag:6];
        [self.contentView addSubview:lastLapLabel];
        
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
        
        UILabel *lapTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(247, 2, 63, 45)];
        [lapTextLabel setText:@"LAP"];
        [lapTextLabel setOpaque:NO];
        [lapTextLabel setBackgroundColor:[UIColor clearColor]];
        [lapTextLabel setTextColor:[UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1]];
        [lapTextLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:15]];
        [lapTextLabel setTextAlignment:NSTextAlignmentCenter];
        [self.contentView addSubview:lapTextLabel];
        
        UIButton *timeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [timeButton setFrame:CGRectMake(77, 10, 170, 80)];
        [timeButton setBackgroundImage:[CommonCLUtility imageFromColor:[UIColor colorWithRed:0.15 green:0.15 blue:0.15 alpha:1]] forState:UIControlStateSelected];
        [timeButton setBackgroundImage:[CommonCLUtility imageFromColor:[UIColor colorWithRed:0.15 green:0.15 blue:0.15 alpha:1]] forState:UIControlStateSelected];
        [timeButton addTarget:self action:@selector(timeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [timeButton addTarget:self action:@selector(timeButtonDown:) forControlEvents:UIControlEventTouchDown];
        [timeButton addTarget:self action:@selector(timeButtonCancel:) forControlEvents:UIControlEventTouchDragExit];
        [timeButton addTarget:self action:@selector(timeButtonCancel:) forControlEvents:UIControlEventTouchCancel];
        [self.contentView addSubview:timeButton];
        
        UIButton *lapButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [lapButton setFrame:CGRectMake(247, 10, 63, 80)];
        [lapButton setBackgroundImage:[CommonCLUtility imageFromColor:[UIColor colorWithRed:0.15 green:0.15 blue:0.15 alpha:1]] forState:UIControlStateSelected];
        [lapButton setBackgroundImage:[CommonCLUtility imageFromColor:[UIColor colorWithRed:0.15 green:0.15 blue:0.15 alpha:1]] forState:UIControlStateSelected];
        [lapButton addTarget:self action:@selector(lapButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [lapButton addTarget:self action:@selector(lapButtonDown:) forControlEvents:UIControlEventTouchDown];
        [lapButton addTarget:self action:@selector(lapButtonCancel:) forControlEvents:UIControlEventTouchDragExit];
        [lapButton addTarget:self action:@selector(lapButtonCancel:) forControlEvents:UIControlEventTouchCancel];
        [self.contentView addSubview:lapButton];

        UIButton *thumbButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [thumbButton setFrame:CGRectMake(10, 10, 63, 80)];
        [thumbButton setBackgroundImage:[CommonCLUtility imageFromColor:[UIColor colorWithRed:0.15 green:0.15 blue:0.15 alpha:1]] forState:UIControlStateSelected];
        [thumbButton setBackgroundImage:[CommonCLUtility imageFromColor:[UIColor colorWithRed:0.15 green:0.15 blue:0.15 alpha:1]] forState:UIControlStateSelected];
        [thumbButton addTarget:self action:@selector(thumbButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [thumbButton addTarget:self action:@selector(thumbButtonDown:) forControlEvents:UIControlEventTouchDown];
        [thumbButton addTarget:self action:@selector(thumbButtonCancel:) forControlEvents:UIControlEventTouchDragExit];
        [thumbButton addTarget:self action:@selector(thumbButtonCancel:) forControlEvents:UIControlEventTouchCancel];
        [self.contentView addSubview:thumbButton];
        
        TriangleView *triangle = [[TriangleView alloc] init];
        [triangle setFrame:CGRectMake(219, 9, 25, 25)];
        [triangle setBackgroundColor:[UIColor clearColor]];
        [triangle setHidden:YES];
        [triangle setTag:7];
        [self.contentView addSubview:triangle];

        imagePickerController = [[UIImagePickerController alloc] init];
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
            [imagePickerController setSourceType:UIImagePickerControllerSourceTypeCamera];
        [imagePickerController setDelegate:self];
        
        [self setUserInteractionEnabled:YES];
    }
    
    return self;
}

-(void)buttonTap:(UITapGestureRecognizer*)sender
{
    if (sender.state == UIGestureRecognizerStateBegan)
    {
        UIButton *senderButton = (UIButton*)sender.view;
        [senderButton setBackgroundColor:[UIColor colorWithRed:0.15 green:0.15 blue:0.15 alpha:1]];
    }
}

-(void) refresh
{
    [(UILabel*)[[self contentView] viewWithTag:1] setText:self.time];
    if (self.thumb != nil)
        [[[self contentView] viewWithTag:3] setBackgroundColor:self.thumb];
    else
        [[[self contentView] viewWithTag:3] setBackgroundColor:[UIColor colorWithRed:0.26 green:0.26 blue:0.26 alpha:1]];
    [(UILabel*)[[self contentView] viewWithTag:2] setText:self.lapNumber];
    [(UILabel*)[[self contentView] viewWithTag:6] setText:self.lastLap];
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
}

-(void)highlight:(UIView *)view withDuration:(NSTimeInterval)duration andWait:(NSTimeInterval)wait
{
    [UIView beginAnimations:@"Fade Out" context:nil];
    [UIView setAnimationDelay:wait];
    [UIView setAnimationDuration:duration];
    view.backgroundColor = [UIColor colorWithRed:0.26 green:0.26 blue:0.26 alpha:1];
    [UIView commitAnimations];
}

-(void)lapButtonClicked:(id)sender
{
    [self highlight:[[self contentView] viewWithTag:5] withDuration:0.5 andWait:0];
    [[self timer] lap];
}

-(void)lapButtonDown:(id)sender
{
    [[[self contentView] viewWithTag:5] setBackgroundColor:[UIColor colorWithRed:0.15 green:0.15 blue:0.15 alpha:1]];
}

-(void)lapButtonCancel:(id)sender
{
    [[[self contentView] viewWithTag:5] setBackgroundColor:[UIColor colorWithRed:0.26 green:0.26 blue:0.26 alpha:1]];
}

-(void)timeButtonClicked:(id)sender
{
    [self highlight:[[self contentView] viewWithTag:4] withDuration:0.5 andWait:0];
    [[self timer] toggle];
}

-(void)start
{
    [[[self contentView] viewWithTag:7] setHidden:NO];
    [(TriangleView*)[[self contentView] viewWithTag:7] setRed:NO];
    [(TriangleView*)[[self contentView] viewWithTag:7] setNeedsDisplay];
}

-(void)timeButtonDown:(id)sender
{
    [[[self contentView] viewWithTag:4] setBackgroundColor:[UIColor colorWithRed:0.15 green:0.15 blue:0.15 alpha:1]];
}

-(void)timeButtonCancel:(id)sender
{

    [[[self contentView] viewWithTag:4] setBackgroundColor:[UIColor colorWithRed:0.26 green:0.26 blue:0.26 alpha:1]];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *pickedImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    [self setThumb:[UIColor colorWithPatternImage:[CommonCLUtility imageWithImage:pickedImage scaledToSize:CGSizeMake(63, 80)]]];
    [[self timer] setThumb:[self thumb]];
    [[[self contentView] viewWithTag:3] setBackgroundColor:[self thumb]];
    [[[self timesTable] navigationController] dismissViewControllerAnimated:YES completion:nil];
}

-(void)thumbButtonClicked:(id)sender
{
    [self highlight:[[self contentView] viewWithTag:3] withDuration:0.5 andWait:0];
    [[[self timesTable] navigationController] presentViewController:[self imagePickerController] animated:YES completion:nil];
}

-(void)thumbButtonDown:(id)sender
{
    [[[self contentView] viewWithTag:3] setBackgroundColor:[UIColor colorWithRed:0.15 green:0.15 blue:0.15 alpha:1]];
}

-(void)thumbButtonCancel:(id)sender
{
    
    [[[self contentView] viewWithTag:3] setBackgroundColor:[UIColor colorWithRed:0.26 green:0.26 blue:0.26 alpha:1]];
}

-(void) reset
{
    [self setUserInteractionEnabled:YES];
    [self.timer setDelegate:nil];
    self.timer = [[Timer alloc] init];
    [self.timer setDelegate: self];
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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

-(void)cleanse
{
    [(UILabel*)[[self contentView] viewWithTag:1] setText:@"00:00.0"];
    [(UILabel*)[[self contentView] viewWithTag:2] setText:@"1"];
    [(UILabel*)[[self contentView] viewWithTag:16] setText:@"00:00.0"];
}

@end
