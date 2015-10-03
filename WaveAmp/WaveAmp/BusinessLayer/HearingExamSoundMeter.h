//
//  HearingExamSoundMeter.h
//  WaveAmp
//
//  Created by Georgi Ivanov on 7/10/15.
//  Copyright (c) 2015 GeorgiIvanov. All rights reserved.
//

#import "NVSoundLevelMeter.h"

@interface HearingExamSoundMeter : NVSoundLevelMeter

-(float)getdBLevel:(float *)data numFrames:(UInt32)numFrames numChannels:(UInt32)numChannels;

@end
