//
//  ToneEqualizer.m
//  WaveAmp
//
//  Created by Georgi Ivanov on 7/15/15.
//  Copyright (c) 2015 GeorgiIvanov. All rights reserved.
//

#import "ToneEqualizer.h"
#import "FrequencyThreshold.h"
#import "AmplitudeMultiplier.h"
#import <NVPeakingEQFilter.h>
#import <AVFoundation/AVFoundation.h>

@interface ToneEqualizer()

@property(nonatomic) NSMutableArray* eqs;
@property(nonatomic) Float64 samplingRate;

@end

@implementation ToneEqualizer

-(instancetype)initWithAudiogram:(AudiogramData*)audiogramData samplingRate:(Float64)samplingRage
{
    self = [super init];
    if (self) {
        self.eqs = [NSMutableArray new];
        _samplingRate = samplingRage;
        [self createFilters:audiogramData];
    }
    return self;
}

-(void)createFilters:(AudiogramData*)ad
{
    float vol = [[AVAudioSession sharedInstance] outputVolume];
    
    // TODO: create equalizers for each channel
    for (int i = 0; i < ad.leftEar.count; i++)
    {
        FrequencyThreshold* ft1 = ad.leftEar[i];
        FrequencyThreshold* ft2 = ad.rightEar[i];
        
        float maxThreshold = MAX(ft1.thresholdDb.floatValue, ft2.thresholdDb.floatValue);
        
        if(maxThreshold > 25)
        {
            NVPeakingEQFilter* filter = [[NVPeakingEQFilter alloc] initWithSamplingRate:_samplingRate];
            filter.Q = 100.0f;
            filter.centerFrequency = [ft1.frequency floatValue];
            
            float baseGain = [AmplitudeMultiplier multiplierForWaveDb:@(10)];
            float adjustedGain = ([AmplitudeMultiplier multiplierForWaveDb:@(maxThreshold)] - baseGain) * 5;
            
            filter.G = adjustedGain + vol;
            
            [self.eqs addObject:filter];
        }
    }
    
    __weak typeof(self) wself = self;
    self.equalizerBlock = ^void(float *data, UInt32 numFrames, UInt32 numChannels){
        [wself applyFilters:data numFrames:numFrames numChannels:numChannels];
    };
}

-(void)applyFilters:(float *)buffer numFrames:(UInt32)framesCount numChannels:(UInt32)channels
{
    for (NVPeakingEQFilter* filter in self.eqs)
    {
        [filter filterData:buffer numFrames:framesCount numChannels:channels];
    }
}

@end
