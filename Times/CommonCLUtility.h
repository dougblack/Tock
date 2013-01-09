//
//  CommonCLUitility.h
//  Times
//
//  Created by Douglas Black on 12/28/12.
//  Copyright (c) 2012 Doug Black. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonCLUtility : NSObject

+ (UIImage *) imageFromColor:(UIColor *)color;
+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;

+(UIColor*) selectedColor;
+(UIColor*) backgroundColor;
+(UIColor*) outlineColor;
+(UIColor*) highlightColor;
+(UIColor*) weakTextColor;
+(UIColor*) viewBackgroundColor;
+(UIColor*) lapTimerBackColor;
+(UIColor*) viewDarkBackColor;
+(UIColor*) viewDarkerBackColor;
+(UIColor*) viewLightBackColor;
+(UIColor*) moreBack;
+(UIColor*) back;
+(UIColor*) midBack;
+(UIColor*) fore;
+(UIColor*) moreFore;
+(UIColor*) moreMoreFore;
+(UIColor*) text;
+(UIColor*) darkGray;
+(UIColor*) darkBlue;
+(UIColor*)lightBlue;
+(UIColor*)black;
+(UIColor*) green;
+(UIColor*) red;
+(UIColor*)lighterGreen;
+(UIColor*) yellow;
+(UIColor*) orange;

+(UIColor*)generateNewColor;

@end

/*
 more back 33	33	33
 Back 42	41	38
 mid back 54	54	54
 Fore 72	72	72
 more fore 73	74	77
 more fore 84	84	84
 text 143	143	143
 different blue 54	54	54
 Dark blue 46	74	165
 LIght blue 61	111	183
 Black 65	58	74
 Green 66	120	33
 Red 149	0	0
 Green 94	153	57
 yellow 239	188	0
 orange 186	114	51
 
 */
