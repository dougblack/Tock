//
//  TimerCell.m
//  Times
//
//  Created by Douglas Black on 12/23/12.
//  Copyright (c) 2012 Doug Black. All rights reserved.
//

#import "TimerCell.h"

@implementation TimerCell

@synthesize thumb, currentTime, lapNumber, timerCellContentView, timer, running, imagePickerController, timesTable;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // What does this do?
        timerCellContentView = [[TimerCellContentView alloc] initWithFrame:CGRectInset(self.contentView.bounds, 0.0, 1.0) andStartTime:@"00:00.0" andStartLap:@"1" andTimerCell:self];
        timerCellContentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        timerCellContentView.contentMode = UIViewContentModeRedraw;
        [self setUserInteractionEnabled:YES];
        [self.contentView addSubview:timerCellContentView];
        imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        UIImagePickerControllerSourceTypePhotoLibrary;
        self.imagePickerController;
    }
    
    self.timer = [[Timer alloc] init];
    [self.timer setDelegate: self];
    
    return self;
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSLog(@"RETURNED");
    UIImage *pickedImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    [[self timerCellContentView] setThumb:pickedImage];
    [[[self timesTable] navigationController] dismissModalViewControllerAnimated:NO];
}

-(void) reset
{
    timerCellContentView = [[TimerCellContentView alloc] initWithFrame:CGRectInset(self.contentView.bounds, 0.0, 1.0) andStartTime:@"00:00.0" andStartLap:@"1" andTimerCell:self];
    timerCellContentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    timerCellContentView.contentMode = UIViewContentModeRedraw;
    [self setUserInteractionEnabled:YES];
    [self.contentView addSubview:timerCellContentView];
    [self.timer setDelegate:nil];
    self.timer = [[Timer alloc] init];
    [self.timer setDelegate: self];
}

-(void) getThumb
{
    NSLog(@"IMAGE");
    [[[self timesTable] navigationController] presentModalViewController:self.imagePickerController animated:YES];
}

-(void) tick:(NSString *)time withLap:(NSInteger *)lap
{
    [[self timerCellContentView] setRunning:YES];
    [self setCurrentTime:time];
    [self setNeedsDisplay];
    
    [[self timerCellContentView] setTime:time];
    [[self timerCellContentView] setLapNumber:[NSString stringWithFormat:@"%d", lap]];
    [[self timerCellContentView] setNeedsDisplay];

//    [(UITableView *)[self superview] reloadData];

}

-(void)lastLapTimeChanged:(NSString*)lapTime
{
    [[self timerCellContentView] setLastLapTime:lapTime];
}

-(void) stop
{
    [[self timerCellContentView] setRunning:NO];
    [self setNeedsDisplay];
    [[self timerCellContentView] setNeedsDisplay];
//    [(UITableView *)[self superview] reloadData];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
