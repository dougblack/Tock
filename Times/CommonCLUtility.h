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
