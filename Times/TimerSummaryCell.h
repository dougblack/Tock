//
//  TimerSummaryCell.h
//  Tock
//
//  Created by Douglas Black on 1/9/13.
//  Copyright (c) 2013 Doug Black. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimerSummaryCell : UITableViewCell

@property NSString *timerName;
@property NSString *lapString;

-(void)refresh;

@end
