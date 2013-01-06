//
//  TimerCell.h
//  Times
//
//  Created by Douglas Black on 12/23/12.
//  Copyright (c) 2012 Doug Black. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TimerCellContentView;
@class TimesViewController;
@class Timer;
@interface TimerCell : UITableViewCell <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property TimesViewController *timesTable;
@property UIImagePickerController* imagePickerController;
@property UIColor *thumb;
@property UIColor *miniThumb;
@property NSString *time;
@property NSString *lapNumber;
@property NSString *lastLap;
@property Timer *timer;
@property NSInteger lastRow;
@property NSMutableArray *movableViews;
@property BOOL isInDeleteMode;
@property BOOL allowEdit;
@property BOOL running;
@property UILabel *deleteButton;


-(void) tick:(NSString*)time withLap:(NSInteger)lapNumber;
-(void) lastLapTimeChanged:(NSString*)lastLap;
-(void) start;
-(void) stop;
-(void) refresh;

@end
