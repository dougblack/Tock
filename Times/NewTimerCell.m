//
//  NewTimerCell.m
//  Times
//
//  Created by Douglas Black on 12/25/12.
//  Copyright (c) 2012 Doug Black. All rights reserved.
//

#import "NewTimerCell.h"

@implementation NewTimerCell 

@synthesize content, timesTable;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andTimesTable:(TimesTableViewController*)newTimesTable
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.timesTable = newTimesTable;
        NewTimerCellContentView *content = [[NewTimerCellContentView alloc] initWithFrame:CGRectInset(self.contentView.bounds, 0.0, 1.0)];
        content.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        content.contentMode = UIViewContentModeRedraw;
        [content setTimesTable:newTimesTable];
        self.content = content;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUserInteractionEnabled:YES];
        [self.contentView addSubview:content];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
