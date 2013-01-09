//
//  SummaryHeaderCell.h
//  Times
//
//  Created by Douglas Black on 1/6/13.
//  Copyright (c) 2013 Doug Black. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@class Timer;
@interface SummaryHeaderCell : UITableViewCell

@property (nonatomic) NSString *time;
@property (nonatomic) NSString *avg;
@property (nonatomic) NSString *goal;
@property (nonatomic) Timer* timer;

-(void)refresh;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andTimer:(Timer*)timer;

@end
