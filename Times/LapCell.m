//
//  LapCell.m
//  Times
//
//  Created by Douglas Black on 12/30/12.
//  Copyright (c) 2012 Doug Black. All rights reserved.
//

#import "LapCell.h"
#import "CommonCLUtility.h"

@implementation LapCell

@synthesize lap;
@synthesize lapNumber;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIFont *cellFont = [UIFont fontWithName:@"HelveticaNeue-Bold" size:30.0];
        
        UIView *shadowView = [[UIView alloc] initWithFrame:CGRectMake(7.0, 3.0, 306, 62)];
        [shadowView setBackgroundColor:[CommonCLUtility outlineColor]];
        [self addSubview:shadowView];
        
        UIView *lapLightView = [[UIView alloc] initWithFrame:CGRectMake(9.0, 5, 65, 58)];
        [lapLightView setBackgroundColor:[CommonCLUtility highlightColor]];
        UIView *lapBackView = [[UIView alloc] initWithFrame:CGRectMake(10.0, 6, 63, 56)];
        [lapBackView setBackgroundColor:[CommonCLUtility backgroundColor]];
        [self addSubview:lapLightView];
        [self addSubview:lapBackView];
        
        UIView *splitLightview = [[UIView alloc] initWithFrame:CGRectMake(76, 5, 235, 58)];
        [splitLightview setBackgroundColor:[CommonCLUtility highlightColor]];
        UIView *splitBackView = [[UIView alloc] initWithFrame:CGRectMake(77, 6, 233, 56)];
        [splitBackView setBackgroundColor:[CommonCLUtility backgroundColor]];
        
        [self addSubview:splitLightview];
        [self addSubview:splitBackView];
        
        UILabel *lapNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 6, 63, 56)];
        [lapNumberLabel setTextColor:[UIColor whiteColor]];
        [lapNumberLabel setBackgroundColor:[UIColor clearColor]];
        [lapNumberLabel setTextAlignment:NSTextAlignmentCenter];
        [lapNumberLabel setFont:cellFont];
        [lapNumberLabel setTag:21];
        [self addSubview:lapNumberLabel];
        
        UILabel *splitLabel = [[UILabel alloc] initWithFrame:CGRectMake(77, 6, 225, 56)];
        [splitLabel setTextColor:[UIColor whiteColor]];
        [splitLabel setBackgroundColor:[UIColor clearColor]];
        [splitLabel setTextAlignment:NSTextAlignmentRight];
        [splitLabel setFont:cellFont];
        [splitLabel setTag:22];
        [self addSubview:splitLabel];
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        self.opaque = YES;
        
    }
    return self;
}

-(void)refresh
{
    [(UILabel*)[self viewWithTag:21] setText:[NSString stringWithFormat:@"%d", [self lapNumber]]];
    [(UILabel*)[self viewWithTag:22] setText:[self lapString]];
}

+(NSString*)stringForTimeInterval:(NSTimeInterval)interval
{
    int mins = (int) (interval / 60.0);
    interval = interval - (mins * 60);
    int secs = (int) (interval);
    interval = interval - (secs);
    int tenths = interval * 10.0;
    interval = interval - tenths;
    
    return [NSString stringWithFormat: @"%02u:%02u.%u", mins, secs, tenths];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
