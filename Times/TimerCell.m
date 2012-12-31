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
        [shadowView setBackgroundColor:[CommonCLUtility outlineColor]];
        [self.contentView addSubview:shadowView];
        
        UIView *thumbLightView = [[UIView alloc] initWithFrame:CGRectMake(9.0, 9.0, 65, 82)];
        [thumbLightView setBackgroundColor:[CommonCLUtility highlightColor]];
        UIView *thumbBackView = [[UIView alloc] initWithFrame:CGRectMake(10.0, 10.0, 63, 80)];
        [thumbBackView setBackgroundColor:[CommonCLUtility backgroundColor]];
        [thumbBackView setTag:3];
        [thumbBackView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)]];
        [self.contentView addSubview:thumbLightView];
        [self.contentView addSubview:thumbBackView];
        
        UIView *timeLightView = [[UIView alloc] initWithFrame:CGRectMake(76, 9.0, 168, 82)];
        [timeLightView setBackgroundColor:[CommonCLUtility highlightColor]];
        UIView *timeBackView = [[UIView alloc] initWithFrame:CGRectMake(77, 10.0, 166, 80)];
        [timeBackView setBackgroundColor:[CommonCLUtility backgroundColor]];
        [timeBackView setTag:4];
        [timeBackView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)]];
        UILongPressGestureRecognizer *timeResetRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
        [timeResetRecognizer setMinimumPressDuration:1];
        [timeBackView addGestureRecognizer:timeResetRecognizer];
        [self.contentView addSubview:timeLightView];
        [self.contentView addSubview:timeBackView];
        
        UIView *lapLightView = [[UIView alloc] initWithFrame:CGRectMake(246, 9.0, 65, 82)];
        [lapLightView setBackgroundColor:[CommonCLUtility highlightColor]];
        UIView *lapBackView = [[UIView alloc] initWithFrame:CGRectMake(247.0, 10.0, 63, 80)];
        [lapBackView setBackgroundColor:[CommonCLUtility backgroundColor]];
        [lapBackView setTag:5];
        [lapBackView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)]];
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
        [lastLapLabel setTextColor:[CommonCLUtility weakTextColor]];
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
        [lapTextLabel setTextColor:[CommonCLUtility weakTextColor]];
        [lapTextLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:15]];
        [lapTextLabel setTextAlignment:NSTextAlignmentCenter];
        [self.contentView addSubview:lapTextLabel];
        
        TriangleView *triangle = [[TriangleView alloc] init];
        [triangle setFrame:CGRectMake(219, 9, 25, 25)];
        [triangle setBackgroundColor:[UIColor clearColor]];
        [triangle setHidden:YES];
        [triangle setTag:7];
        [self.contentView addSubview:triangle];

        imagePickerController = [[UIImagePickerController alloc] init];
//        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
            [imagePickerController setSourceType:UIImagePickerControllerSourceTypeCamera];
        [imagePickerController setDelegate:self];
        [self setImagePickerController:imagePickerController];
        
        [self setUserInteractionEnabled:YES];
    }
    
    return self;
}

-(void)handleTap:(UITapGestureRecognizer*)sender
{
    UIView *senderView = (UIView*)sender.view;
    if (sender.state == UIGestureRecognizerStateRecognized)
    {
        int tag = senderView.tag;
        [senderView setBackgroundColor:[UIColor colorWithRed:0.15 green:0.15 blue:0.15 alpha:1]];
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
    for (UITouch *touch in touches) {
        UIView *view = [touch view];
        if (view.tag == 3 || view.tag == 4 || view.tag == 5)
        {
            view.backgroundColor = [CommonCLUtility selectedColor];
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
    }
}

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch *touch in touches)
    {
        UIView *view = [touch view];
        if (view.tag == 3 || view.tag == 4 || view.tag == 5)
            view.backgroundColor = [CommonCLUtility backgroundColor];
    }

}

-(void) refresh
{
    [(UILabel*)[[self contentView] viewWithTag:1] setText:[[self timer] timeString]];
    NSLog([[self timer] lastLapString]);
    [(UILabel*)[[self contentView] viewWithTag:6] setText:[[self timer] lastLapString]];
    if (self.thumb != nil)
        [[[self contentView] viewWithTag:3] setBackgroundColor:self.thumb];
    else
        [[[self contentView] viewWithTag:3] setBackgroundColor:[CommonCLUtility backgroundColor]];
    [(UILabel*)[[self contentView] viewWithTag:2] setText:[NSString stringWithFormat:@"%d", [[self timer]lapNumber]]];
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
    [self setThumb:[UIColor colorWithPatternImage:[CommonCLUtility imageWithImage:pickedImage scaledToSize:CGSizeMake(63, 80)]]];
    [[self timer] setThumb:[self thumb]];
    [[[self contentView] viewWithTag:3] setBackgroundColor:[self thumb]];
    [[[self timesTable] navigationController] dismissViewControllerAnimated:YES completion:nil];
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

- (void) setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}


@end
