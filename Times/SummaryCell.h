//
//  SummaryCell.h
//  Times
//
//  Created by Douglas Black on 1/3/13.
//  Copyright (c) 2013 Doug Black. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DropDownTableView;
@class SummaryViewController;

@interface SummaryCell : UITableViewCell

@property NSInteger lapNumber;
@property NSTimeInterval lapTime;
@property NSString *lapTimeString;
@property NSTimeInterval deltaFromPrevious;
@property NSTimeInterval deltaFromAverage;
@property NSTimeInterval deltaFromGoal;

@property SummaryViewController *controller;

-(void)refresh;

@end
