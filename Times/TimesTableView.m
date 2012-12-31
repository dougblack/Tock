//
//  TimesTableView.m
//  Times
//
//  Created by Douglas Black on 12/27/12.
//  Copyright (c) 2012 Doug Black. All rights reserved.
//

#import "TimesTableView.h"

@implementation TimesTableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setOpaque:YES];
        [self setUserInteractionEnabled:YES];
        [self setShowsVerticalScrollIndicator:NO];

    }
    return self;
}

-(BOOL)touchesShouldCancelInContentView:(UIView *)view
{
    return YES;
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];  //let the tableview handle cell selection
    [self.nextResponder touchesBegan:touches withEvent:event]; // give the controller a chance for handling touch events
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self.nextResponder touchesEnded:touches withEvent:event];
}

@end
