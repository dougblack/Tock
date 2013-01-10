//
//  CommonCLUitility.m
//  Times
//
//  Created by Douglas Black on 12/28/12.
//  Copyright (c) 2012 Doug Black. All rights reserved.
//

#import "CommonCLUtility.h"

@implementation CommonCLUtility


+(UIColor*) moreBack
{
    static UIColor *moreBack = nil;
    if (!moreBack) moreBack = [UIColor colorWithRed:.129411765 green:.129411765 blue:.129411765 alpha:1];
    return moreBack;
}

+(UIColor*) back
{
    static UIColor *back = nil;
    if (!back) back = [UIColor colorWithRed:.164705882 green:.160784314 blue:.149019608 alpha:1];
    return back;
}

+(UIColor*) midBack
{
    static UIColor *back = nil;
    if (!back) back = [UIColor colorWithRed:.211764706 green:.211764706 blue:.211764706 alpha:1];
    return back;
}

+(UIColor*) fore
{
    static UIColor *fore = nil;
    if (!fore) fore = [UIColor colorWithRed:.282352941 green:.282352941 blue:.282352941 alpha:1];
    return fore;
}

+(UIColor*) moreFore
{
    static UIColor *moreFore = nil;
    if (!moreFore) moreFore = [UIColor colorWithRed:.28627451 green:.282352941 blue:.301960784 alpha:1];
    return moreFore;
}

+(UIColor*) moreMoreFore
{
    static UIColor *moreMoreFore = nil;
    if (!moreMoreFore) moreMoreFore = [UIColor colorWithRed:.329411765 green:.329411765 blue:.329411765 alpha:1];
    return moreMoreFore;
}

+(UIColor*) text
{
    static UIColor *text = nil;
    if (!text) text = [UIColor colorWithRed:.560784314 green:.560784314 blue:.560784314 alpha:1];
    return text;
}

+(UIColor*)darkGray
{
    static UIColor *darkGray = nil;
    if (!darkGray) darkGray = [UIColor colorWithRed:.211764706 green:.211764706 blue:.211764706 alpha:.211764706];
    return darkGray;
}

+(UIColor*) darkBlue
{
    static UIColor *darkBlue = nil;
    if (!darkBlue) darkBlue = [UIColor colorWithRed:.180392157 green:.290196078 blue:.647058824 alpha:1];
    return darkBlue;
}

+(UIColor*)lightBlue
{
    static UIColor *lightBlue = nil;
    if (!lightBlue) lightBlue = [UIColor colorWithRed:.239215686 green:.435294118 blue:.717647059 alpha:1];
    return lightBlue;
}

+(UIColor*) black
{
    static UIColor *black = nil;
    if (!black) black = [UIColor colorWithRed:66.0f/255 green:58.0f/255 blue:74.0f/255 alpha:1];
    return black;
}

+(UIColor*) green
{
    static UIColor *green = nil;
    if (!green) green = [UIColor colorWithRed:66.0f/255 green:120.0f/255 blue:33.0f/255 alpha:1];
    return green;
}

+(UIColor*) red
{
    static UIColor *red = nil;
    if (!red) red = [UIColor colorWithRed:149.0f/255 green:0 blue:0 alpha:1];
    return red;
}

+(UIColor*)lighterGreen
{
    static UIColor *lightGreen = nil;
    if (!lightGreen) lightGreen = [UIColor colorWithRed:94.0f/255 green:153.0f/255 blue:57.0f/255 alpha:1];
    return lightGreen;
}

+(UIColor*) yellow
{
    static UIColor *yellow = nil;
    if (!yellow) yellow = [UIColor colorWithRed:239.0f/255 green:188.0f/255 blue:58.0f/255 alpha:1];
    return yellow;
}

+(UIColor*) orange
{
    static UIColor *orange = nil;
    if (!orange) orange = [UIColor colorWithRed:186.0f/255 green:114.0f/255 blue:51.0f/255 alpha:1];
    return orange;
}

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
    if (!background) background = [UIColor colorWithRed:0.13 green:0.13 blue:0.13 alpha:1];
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
    if (!viewBackground) viewBackground = [CommonCLUtility black];
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
    if (!viewBack) viewBack = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1];
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

// Generates a color guaranteed to be different from the previous one.
+(UIColor*)generateNewColor
{
    static UIColor *lastGeneratedColor;
    
    BOOL isDifferentEnough = NO;
    UIColor *color;
    
    do {
        CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
        CGFloat saturation = 1;
        CGFloat brightness = 0.8;  //  0.5 to 1.0, away from black
        
        color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
        
        if (lastGeneratedColor == nil)
            isDifferentEnough = YES;
        else {
            const CGFloat *pickedColorComponents = CGColorGetComponents(color.CGColor);
            const CGFloat *generatedColorComponents = CGColorGetComponents(lastGeneratedColor.CGColor);
            CGFloat delta = fabsf(pickedColorComponents[0] - generatedColorComponents[0]) + fabsf(pickedColorComponents[1] - generatedColorComponents[1]) + fabsf(pickedColorComponents[2] - generatedColorComponents[2]);
            isDifferentEnough = (delta > 0.5);
        }
        
    } while (!isDifferentEnough);
    
    lastGeneratedColor = color;
    return lastGeneratedColor;
}

@end
