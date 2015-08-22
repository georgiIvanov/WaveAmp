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
#import "FrequencyThreshold.h"

@interface HearingLossSimulator()

@property(nonatomic) NVLowpassFilter* lowPassFilter;

@end

@implementation HearingLossSimulator

-(instancetype)initWithAudiogram:(AudiogramData*)audiogramData samplingRate:(Float64)samplingRate
{
    AudiogramData* usedAudiogram = audiogramData != nil && ![audiogramData isWithinNormalLoss] ? audiogramData : [AudiogramData audiogramMildLoss];
    
    self = [super initWithAudiogram:usedAudiogram samplingRate:samplingRate];
    if (self) {        
        self.lowPassFilter = [[NVLowpassFilter alloc] initWithSamplingRate:samplingRate];
        self.lowPassFilter.cornerFrequency = [self findCornerFrequency:usedAudiogram];
        self.lowPassFilter.Q = 0.8f;
    }
    return self;
}

-(int)findCornerFrequency:(AudiogramData*)audiogramData
{
    int left = 0;
    int right = 0;
    
    for (int i = 0; i < audiogramData.leftEar.count; i++)
    {
        FrequencyThreshold* ft1 = (FrequencyThreshold*)audiogramData.leftEar[i];
        FrequencyThreshold* ft2 = (FrequencyThreshold*)audiogramData.rightEar[i];
        
        if([ft1.thresholdDb integerValue] > 20)
        {
            left = [ft1.thresholdDb floatValue];
        }
        
        if([ft2.thresholdDb integerValue] > 20)
        {
            right = [ft2.thresholdDb floatValue];
        }
        
        if(left > 20 || right > 20)
        {
            return MAX([ft1.frequency intValue], [ft2.frequency intValue]);
        }
    }
    
    return 500;
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
