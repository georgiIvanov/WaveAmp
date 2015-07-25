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
#import <NVClippingDetection.h>
#import <AVFoundation/AVFoundation.h>

@interface ToneEqualizer()

@property(nonatomic) NSMutableArray* eqs;
@property(nonatomic) NVClippingDetection* clippingDetection;

@end

@implementation ToneEqualizer

-(instancetype)initWithAudiogram:(AudiogramData*)audiogramData samplingRate:(Float64)samplingRate
{
    self = [super initWithAudiogram:audiogramData samplingRate:samplingRate];
    if (self) {
        self.eqs = [NSMutableArray new];
        self.clippingDetection = [[NVClippingDetection alloc] initWithSamplingRate:samplingRate];
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
        
        if(maxThreshold > 20)
        {
            NVPeakingEQFilter* filter = [[NVPeakingEQFilter alloc] initWithSamplingRate:self.samplingRate];
            filter.Q = 3.0f;
            filter.centerFrequency = [ft1.frequency floatValue];
            
            float baseGain = [AmplitudeMultiplier multiplierForWaveDb:@(10)];
            float adjustedGain = ([AmplitudeMultiplier multiplierForWaveDb:@(maxThreshold)] - baseGain) * 6;
            
            filter.G = MAX(adjustedGain + vol, 3.0f);
            
            [self.eqs addObject:filter];
        }
    }
    
    self.enabled = self.eqs.count > 0 ? YES : NO;
    
    __weak typeof(self) wself = self;
    self.modifierBlock = ^void(float *data, UInt32 numFrames, UInt32 numChannels){
        [wself applyFilters:data numFrames:numFrames numChannels:numChannels];
    };
}

-(void)applyFilters:(float *)buffer numFrames:(UInt32)framesCount numChannels:(UInt32)channels
{
    for (NVPeakingEQFilter* filter in self.eqs)
    {
        [filter filterData:buffer numFrames:framesCount numChannels:channels];
    }
    
    [self.clippingDetection counterClipping:buffer numFrames:framesCount numChannels:channels];
}

@end
