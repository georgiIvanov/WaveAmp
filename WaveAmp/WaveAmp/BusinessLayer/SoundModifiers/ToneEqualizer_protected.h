//
//  ToneEqualizer_protected.h
//  WaveAmp
//
//  Created by Georgi Ivanov on 7/25/15.
//  Copyright (c) 2015 GeorgiIvanov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <NVPeakingEQFilter.h>

#import "ToneEqualizer.h"
#import "AudiogramData.h"

@interface ToneEqualizer()

@property(nonatomic) NSMutableArray* eqs;

-(NVPeakingEQFilter*)createFilterForFrequency:(float)frequency withThreshold:(float)threshold;
-(void)applyFilters:(float *)buffer numFrames:(UInt32)framesCount numChannels:(UInt32)channels;

@end
