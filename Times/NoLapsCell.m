//
//  NoLapsCell.m
//  Times
//
//  Created by Douglas Black on 1/5/13.
//  Copyright (c) 2013 Doug Black. All rights reserved.
//

#import "NoLapsCell.h"
#import "CommonCLUtility.h"

/* Displayed when there aren't any laps. */
@implementation NoLapsCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIView *bottomBar = [[UIView alloc] initWithFrame:CGRectMake(0, 58, 320, 2)];
        [bottomBar setBackgroundColor:[CommonCLUtility backgroundColor]];
        [self.contentView addSubview:bottomBar];
        
        UILabel *emptyLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 10, 120, 40)];
        [emptyLabel setTextAlignment:NSTextAlignmentCenter];
        [emptyLabel setTextColor:[UIColor whiteColor]];
        [emptyLabel setBackgroundColor:[CommonCLUtility viewDarkBackColor]];
        [emptyLabel setFont:[UIFont boldSystemFontOfSize:15]];
        [emptyLabel setText:@"No laps"];
        [self.contentView addSubview:emptyLabel];
        [self setSelectionStyle:UITableViewCellEditingStyleNone];
        self.opaque = YES;
        [self.contentView setBackgroundColor:[CommonCLUtility viewDarkBackColor]];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
