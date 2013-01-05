//
//  SummaryCell.m
//  Times
//
//  Created by Douglas Black on 1/3/13.
//  Copyright (c) 2013 Doug Black. All rights reserved.
//

#import "SummaryCell.h"
#import "CommonCLUtility.h"
#import "DropDownLapCell.h"
#import "DropDownTableView.h"
#import "SummaryViewController.h"
#import "SummaryTableView.h"

@implementation SummaryCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(7, 3, 306, 64)];
        [backView setBackgroundColor:[CommonCLUtility outlineColor]];
        [self.contentView addSubview:backView];
        
        UIView *highlightView = [[UIView alloc] initWithFrame:CGRectMake(9, 5, 302, 60)];
        [highlightView setBackgroundColor:[CommonCLUtility highlightColor]];
        [self.contentView addSubview:highlightView];
        
        UIView *mainView = [[UIView alloc] initWithFrame:CGRectMake(10, 6, 300, 58)];
        [mainView setBackgroundColor:[CommonCLUtility backgroundColor]];
        [self.contentView addSubview:mainView];
        
        UILabel *cellLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 6, 300, 58)];
        [cellLabel setBackgroundColor:[UIColor clearColor]];
        [cellLabel setText:@"TIMER #"];
        [cellLabel setTextColor:[UIColor whiteColor]];
        [cellLabel setFont:[UIFont boldSystemFontOfSize:25]];
        [cellLabel setTextAlignment:NSTextAlignmentCenter];
        [self.contentView addSubview:cellLabel];
        
        DropDownTableView *dropDown = [[DropDownTableView alloc] initWithFrame:CGRectMake(10, 68, 300, 500)];
        [dropDown setDelegate:self];
        [dropDown setDataSource:self];
        [dropDown setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [dropDown setBackgroundColor:[CommonCLUtility viewDarkerBackColor]];
        [dropDown setHidden:YES];
        [dropDown setTag:51];
        [dropDown setRowHeight:60];
        [self.contentView addSubview:dropDown];
        
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cellClicked:)];
        
        [self addGestureRecognizer:tapRecognizer];
        self.height = 70;
        self.selectionStyle = UITableViewCellSeparatorStyleNone;
        self.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        self.clipsToBounds = YES;
        self.userInteractionEnabled = YES;
        
    }
    return self;
}

-(void)cellClicked:(UITapGestureRecognizer*)sender
{
    if (self.cellSelected)
    {
        self.controller.selectedRow = nil;
        [[self.controller tableView] beginUpdates];
        [[self.controller tableView] endUpdates];
        self.cellSelected = NO;
        UIView *dropDown = [self.contentView viewWithTag:51];
        [dropDown performSelector:@selector(setHidden:) withObject:self afterDelay:0.3];
    } else
    {
        self.controller.selectedRow = self.cellPath;
        [[self.controller tableView] beginUpdates];
        [[self.controller tableView] endUpdates];
        [[self dropDown] setHidden:NO];
        self.cellSelected = YES;
        [[self.contentView viewWithTag:51] setHidden:NO];
    }

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DropDownLapCell *dropDownLapCell = [[DropDownLapCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""];
    return dropDownLapCell;
}

@end
