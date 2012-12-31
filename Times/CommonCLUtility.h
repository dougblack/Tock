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

@end
