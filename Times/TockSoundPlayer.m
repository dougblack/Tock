//
//  TockSoundPlayer.m
//  Tock
//
//  Created by Douglas Black on 1/8/13.
//  Copyright (c) 2013 Doug Black. All rights reserved.
//

#import "TockSoundPlayer.h"

@interface TockSoundPlayer ()

@property AVAudioPlayer *audioPlayer;

@end

@implementation TockSoundPlayer

+(TockSoundPlayer*)getInstance
{
    static TockSoundPlayer *tockSoundPlayer;
    if (tockSoundPlayer == nil) tockSoundPlayer = [TockSoundPlayer new];
    return tockSoundPlayer;
}

+(void)playSoundWithName:(NSString *)name andExtension:(NSString *)extension andVolume:(CGFloat)volume
{
    TockSoundPlayer *tockSoundPlayer = [TockSoundPlayer getInstance];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:extension];
    NSURL *clickURL = [[NSURL alloc] initFileURLWithPath:path];
    NSError *clickError = [NSError new];
    tockSoundPlayer.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:clickURL error:&clickError];
    tockSoundPlayer.audioPlayer.volume = volume;
    [tockSoundPlayer.audioPlayer play];
}

@end
