//
//  SummaryHeaderCell.h
//  Times
//
//  Created by Douglas Black on 1/6/13.
//  Copyright (c) 2013 Doug Black. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface SummaryHeaderCell : UITableViewCell

@property NSString *time;
@property NSString *avg;
@property NSString *goal;

-(void)refresh;

@end
