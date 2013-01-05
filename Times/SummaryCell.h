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

@interface SummaryCell : UITableViewCell <UITableViewDataSource, UITableViewDelegate>

@property NSInteger lapNumber;
@property NSMutableArray *laps;
@property NSMutableArray *thumbs;

@property SummaryViewController *controller;

@property DropDownTableView *dropDown;
@property CGFloat height;
@property BOOL cellSelected;

@property NSIndexPath *cellPath;

@end
