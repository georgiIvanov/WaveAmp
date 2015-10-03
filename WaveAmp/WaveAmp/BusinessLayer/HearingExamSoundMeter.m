//
//  HearingExamSoundMeter.m
//  WaveAmp
//
//  Created by Georgi Ivanov on 7/10/15.
//  Copyright (c) 2015 GeorgiIvanov. All rights reserved.
//

#import "HearingExamSoundMeter.h"

#define DBOFFSET 81.0

@implementation HearingExamSoundMeter

-(float)getdBLevel:(float *)data numFrames:(UInt32)numFrames numChannels:(UInt32)numChannels
{
    float outputDb = [super getdBLevel:data numFrames:numFrames numChannels:numChannels];
    
    if (outputDb == -INFINITY || outputDb == -50) {
        return 0;
    }
    
    return outputDb + DBOFFSET;
}

@end
