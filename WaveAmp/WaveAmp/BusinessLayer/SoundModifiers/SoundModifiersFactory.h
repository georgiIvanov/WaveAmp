//
//  SoundModifiersFactory.h
//  WaveAmp
//
//  Created by Georgi Ivanov on 7/25/15.
//  Copyright (c) 2015 GeorgiIvanov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SoundModifier.h"
#import "AudiogramData.h"

typedef NS_ENUM(int, SoundModType)
{
    kToneEqualizer = 1,
    kHearingLoss = 2
};

@interface SoundModifiersFactory : NSObject

+(SoundModifier*)soundModifier:(SoundModType)soundMod withAudiogramData:(AudiogramData*)audiogramData samplingRage:(float)samplingRate;

@end
