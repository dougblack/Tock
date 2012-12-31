//
//  CommonCLUitility.m
//  Times
//
//  Created by Douglas Black on 12/28/12.
//  Copyright (c) 2012 Doug Black. All rights reserved.
//

#import "CommonCLUtility.h"

@implementation CommonCLUtility

+ (UIImage *) imageFromColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    //  [[UIColor colorWithRed:222./255 green:227./255 blue: 229./255 alpha:1] CGColor]) ;
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+(UIColor*) selectedColor
{
    static UIColor* selected = nil;
    if (!selected) selected = [UIColor colorWithRed:0.15 green:0.15 blue:0.15 alpha:1];
    return selected;
}

+(UIColor*) backgroundColor
{
    static UIColor* background = nil;
    if (!background) background = [UIColor colorWithRed:0.26 green:0.26 blue:0.26 alpha:1];
    return background;
}

+(UIColor*) outlineColor
{
    static UIColor *outline = nil;
    if (!outline) outline = [UIColor blackColor];
    return outline;
}

+(UIColor*) highlightColor
{
    static UIColor *highlight = nil;
    if (!highlight) highlight = [UIColor colorWithRed:0.35 green:0.35 blue:0.35 alpha:1];
    return highlight;
}

+(UIColor*) weakTextColor
{
    static UIColor *weakText = nil;
    if (!weakText) weakText = [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1];
    return weakText;
}

@end
