//
//  NewTimerCell.m
//  Times
//
//  Created by Douglas Black on 12/25/12.
//  Copyright (c) 2012 Doug Black. All rights reserved.
//

#import "NewTimerCell.h"

@implementation NewTimerCell 

@synthesize timesTable;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andTimesTable:(TimesViewController*)newTimesTable
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.timesTable = newTimesTable;
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        UIView *shadowView = [[UIView alloc] initWithFrame:CGRectMake(7.0, 7.0, 306, 86)];
        [shadowView setBackgroundColor:[CommonCLUtility outlineColor]];
        [self.contentView addSubview:shadowView];
        UIView *lightView = [[UIView alloc] initWithFrame:CGRectMake(9.0, 9.0, 302, 82)];
        [lightView setBackgroundColor:[CommonCLUtility highlightColor]];
        [self.contentView addSubview:lightView];
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(10.0, 10.0, 300, 80)];
        [backView setBackgroundColor:[CommonCLUtility backgroundColor]];
        [backView setTag:1];
        [self.contentView addSubview:backView];
        UIButton *plusButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 300, 80)];
        plusButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [plusButton setFrame:CGRectMake(10, 10, 300, 80)];
        [plusButton setTitle:@"+" forState:UIControlStateNormal];
        [plusButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [plusButton setTitleShadowColor:[CommonCLUtility highlightColor] forState:UIControlStateNormal];
        [[plusButton titleLabel] setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:70.0]];
        [plusButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [plusButton setContentVerticalAlignment:UIControlContentVerticalAlignmentTop];
        [plusButton setTitleEdgeInsets:UIEdgeInsetsMake(-12.0, 132.0, 0.0, 0.0)];
        [[plusButton titleLabel] setShadowOffset:CGSizeMake(1,1)];
        [plusButton setBackgroundImage:[CommonCLUtility imageFromColor:[UIColor colorWithRed:0.15 green:0.15 blue:0.15 alpha:1]] forState:UIControlStateSelected];
        [plusButton setBackgroundImage:[CommonCLUtility imageFromColor:[UIColor colorWithRed:0.15 green:0.15 blue:0.15 alpha:1]] forState:UIControlStateSelected];
        [plusButton addTarget:self action:@selector(plusButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [plusButton addTarget:self action:@selector(plusButtonDown:) forControlEvents:UIControlEventTouchDown];
        [plusButton addTarget:self action:@selector(plusButtonCancel:) forControlEvents:UIControlEventTouchDragExit];
        [plusButton addTarget:self action:@selector(plusButtonCancel:) forControlEvents:UIControlEventTouchCancel];
        [self.contentView addSubview:plusButton];
        
        [self setUserInteractionEnabled:YES];
    }
    return self;
}

-(void)highlight:(UIView *)view withDuration:(NSTimeInterval)duration andWait:(NSTimeInterval)wait
{
    [UIView beginAnimations:@"Fade Out" context:nil];
    [UIView setAnimationDelay:wait];
    [UIView setAnimationDuration:duration];
    view.backgroundColor = [UIColor whiteColor];
    [UIView commitAnimations];
}

-(void)plusButtonCancel:(id)sender
{
    [((UIButton*)sender) setBackgroundColor:[UIColor clearColor]];
}

-(void)plusButtonClicked:(id)sender
{
    
//    [self highlight:(UIButton*)sender withDuration:0.5 andWait:0];
    [[self timesTable] newTimer];
}

-(void)plusButtonDown:(id)sender
{
    [((UIButton*)sender) setBackgroundColor:[CommonCLUtility selectedColor]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

}



@end
