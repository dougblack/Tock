//
//  TimesTableView.m
//  Times
//
//  Created by Douglas Black on 12/26/12.
//  Copyright (c) 2012 Doug Black. All rights reserved.
//

#import "TimesTableView.h"
#import "TimerCell.h"
#import "NewTimerCell.h"

@implementation TimesTableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self registerClass:[TimerCell class] forCellReuseIdentifier:@"Cell"];
        [self registerClass:[NewTimerCell class] forCellReuseIdentifier:@"New"];
        [self setDelaysContentTouches:NO];
    }
    return self;
}

-(BOOL)touchesShouldCancelInContentView:(UIView *)view {
    return YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
