//
//  LapCell.h
//  Times
//
//  Created by Douglas Black on 12/30/12.
//  Copyright (c) 2012 Doug Black. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LapCell : UITableViewCell

@property (nonatomic) NSTimeInterval lap;
@property (nonatomic) NSString *lapString;
@property (nonatomic) NSInteger lapNumber;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

-(void)refresh;

+(NSString*)stringForTimeInterval:(NSTimeInterval)interval;

@end
