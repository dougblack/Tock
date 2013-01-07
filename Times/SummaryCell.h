//
//  SummaryCell.h
//  Times
//
//  Created by Douglas Black on 1/3/13.
//  Copyright (c) 2013 Doug Black. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    DeltaIsRed,
    DeltaIsGreen,
    DeltaIsGray
} DeltaColor;

@class DropDownTableView;
@class SummaryViewController;

@interface SummaryCell : UITableViewCell

@property NSInteger lapNumber;
@property NSTimeInterval lapTime;
@property NSString *lapTimeString;
@property NSString *lapDelta;
@property NSTimeInterval deltaFromPrevious;
@property NSTimeInterval deltaFromAverage;
@property NSTimeInterval deltaFromGoal;

@property UILabel *lapDeltaLabel;
@property DeltaColor deltaColor;

@property SummaryViewController *controller;

-(void)refresh;

@end
