//
//  HearingLossSimulator.m
//  WaveAmp
//
//  Created by Georgi Ivanov on 7/25/15.
//  Copyright (c) 2015 GeorgiIvanov. All rights reserved.
//

#import <NVLowpassFilter.h>

#import "ToneEqualizer_protected.h"
#import "HearingLossSimulator.h"
#import "AmplitudeMultiplier.h"

@interface HearingLossSimulator()

@property(nonatomic) NVLowpassFilter* lowPassFilter;

@end

@implementation HearingLossSimulator

-(instancetype)initWithAudiogram:(AudiogramData*)audiogramData samplingRate:(Float64)samplingRate
{
    AudiogramData* usedAudiogram = audiogramData != nil ? audiogramData : [AudiogramData audiogramMildLoss];
    
    self = [super initWithAudiogram:usedAudiogram samplingRate:samplingRate];
    if (self) {        
        self.lowPassFilter = [[NVLowpassFilter alloc] initWithSamplingRate:samplingRate];
        self.lowPassFilter.cornerFrequency = 500.0f;
        self.lowPassFilter.Q = 0.8f;
    }
    return self;
}

-(NVPeakingEQFilter *)createFilterForFrequency:(float)frequency withThreshold:(float)threshold
{
    NVPeakingEQFilter* filter = [[NVPeakingEQFilter alloc] initWithSamplingRate:self.samplingRate];
    filter.Q = 3.0f;
    filter.centerFrequency = frequency;
    
    float adjustedGain = -[AmplitudeMultiplier multiplierForWaveDb:@(threshold)] * 10;
    
    filter.G = adjustedGain;
    return filter;
}

-(void)applyFilters:(float *)buffer numFrames:(UInt32)framesCount numChannels:(UInt32)channels
{
    [self.lowPassFilter filterData:buffer numFrames:framesCount numChannels:channels];
    [super applyFilters:buffer numFrames:framesCount numChannels:channels];
}
@end
