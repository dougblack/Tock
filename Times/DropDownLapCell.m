//
//  DropDownLapCell.m
//  Times
//
//  Created by Douglas Black on 1/5/13.
//  Copyright (c) 2013 Doug Black. All rights reserved.
//

#import "DropDownLapCell.h"
#import "CommonCLUtility.h"

@implementation DropDownLapCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *shadowView = [[UIView alloc] initWithFrame:CGRectMake(20, 3, 260, 57)];
        [shadowView setBackgroundColor:[UIColor blackColor]];
        [self addSubview:shadowView];
        
        UIView *lightView = [[UIView alloc] initWithFrame:CGRectMake(22, 5, 256, 53)];
        [lightView setBackgroundColor:[CommonCLUtility highlightColor]];
        [self addSubview:lightView];
        
        UIView *mainView = [[UIView alloc] initWithFrame:CGRectMake(23, 6, 254, 51)];
        [mainView setBackgroundColor:[CommonCLUtility viewBackgroundColor]];
        [self addSubview:mainView];
        
        [self setBackgroundColor:[CommonCLUtility viewDarkerBackColor]];
        [self setOpaque:YES];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
