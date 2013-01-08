//
//  TimesTable.h
//  Times
//
//  Created by Douglas Black on 12/23/12.
//  Copyright (c) 2012 Doug Black. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <AVFoundation/AVFoundation.h>

@class BottomActionView;
@class TimesTableView;

@interface TimesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property NSInteger numTimers;
@property NSInteger numSections;
@property NSMutableArray *timers;
@property TimesTableView *tableView;
@property BottomActionView *bottomActionView;
@property NSArray *colors;
@property NSInteger colorIndex;

@property AVAudioPlayer *audioPlayer;

-(void)newTimer;
-(void)startAll;
-(void)checkTimers;

@end
