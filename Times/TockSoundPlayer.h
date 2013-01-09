//
//  TockSoundPlayer.h
//  Tock
//
//  Created by Douglas Black on 1/8/13.
//  Copyright (c) 2013 Doug Black. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface TockSoundPlayer : NSObject

+(void)playSoundWithName:(NSString *)name andExtension:(NSString *)extension andVolume:(CGFloat)volume;

@end
