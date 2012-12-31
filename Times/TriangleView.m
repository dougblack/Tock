//
//  TriangleView.m
//  Times
//
//  Created by Douglas Black on 12/29/12.
//  Copyright (c) 2012 Doug Black. All rights reserved.
//

#import "TriangleView.h"

@implementation TriangleView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setRed:NO];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextBeginPath(ctx);
    CGContextMoveToPoint   (ctx, CGRectGetMinX(rect), CGRectGetMinY(rect));  // top left
    CGContextAddLineToPoint(ctx, CGRectGetMaxX(rect), CGRectGetMinY(rect));  // top right
    CGContextAddLineToPoint(ctx, CGRectGetMaxX(rect), CGRectGetMaxY(rect));  // bottom right
    CGContextClosePath(ctx);
    
    if (self.red == NO)
        CGContextSetRGBFillColor(ctx, 0.1, 0.6, 0.1, 1);
    else
        CGContextSetRGBFillColor(ctx, 0.6, 0.1, 0.1, 1);
    
    CGContextFillPath(ctx);
}


@end
