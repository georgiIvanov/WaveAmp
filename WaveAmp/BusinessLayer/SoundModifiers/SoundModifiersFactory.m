//
//  SoundModifiersFactory.m
//  WaveAmp
//
//  Created by Georgi Ivanov on 7/25/15.
//  Copyright (c) 2015 GeorgiIvanov. All rights reserved.
//

#import "SoundModifiersFactory.h"
#import "ToneEqualizer.h"

@implementation SoundModifiersFactory

+(SoundModifier*)soundModifier:(SoundModType)soundMod withAudiogramData:(AudiogramData*)audiogramData samplingRage:(float)samplingRate
{
    SoundModifier* result;
    switch (soundMod) {
        case kToneEqualizer:
            result = [[ToneEqualizer alloc] initWithAudiogram:audiogramData samplingRate:samplingRate];
            break;
        case kHearingLoss:
            
            break;
        default:
            [NSException raise:@"Invalid sound modifier type chosen" format:@"Invalid options of %d were set.", soundMod];
            break;
    }
    
    return result;
}

@end
