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
    if (!selected) selected = [UIColor colorWithRed:0.1 green:0.1 blue:0.8 alpha:1];
    return selected;
}

+(UIColor*) backgroundColor
{
    static UIColor* background = nil;
    if (!background) background = [UIColor colorWithRed:0.18 green:0.18 blue:0.18 alpha:1];
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
    if (!highlight) highlight = [UIColor colorWithRed:0.25 green:0.25 blue:0.25 alpha:1];
    return highlight;
}

+(UIColor*) weakTextColor
{
    static UIColor *weakText = nil;
    if (!weakText) weakText = [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1];
    return weakText;
}

+(UIColor*) viewBackgroundColor
{
    static UIColor *viewBackground = nil;
    if (!viewBackground) viewBackground = [UIColor colorWithRed:0.15 green:0.15 blue:0.15 alpha:1];
    return viewBackground;
}
+(UIColor*) lapTimerBackColor
{
    static UIColor *lapTimerBack = nil;
    if (!lapTimerBack) lapTimerBack = [UIColor colorWithRed:0.13 green:0.13 blue:0.13 alpha:1];
    return lapTimerBack;
}

+(UIColor*) viewDarkBackColor
{
    static UIColor *viewBack = nil;
    if (!viewBack) viewBack = [UIColor colorWithRed:0.13 green:0.13 blue:0.13 alpha:1];
    return viewBack;
}

+(UIColor*) viewDarkerBackColor
{
    static UIColor *darker = nil;
    if (!darker) darker = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1];
    return darker;
}

+(UIColor*) viewLightBackColor
{
    static UIColor *viewLightBack = nil;
    if (!viewLightBack) viewLightBack = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1];
    return viewLightBack;
}

@end
