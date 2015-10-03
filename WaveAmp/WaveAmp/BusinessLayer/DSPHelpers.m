//
//  DSPHelpers.m
//  WaveAmp
//
//  Created by Georgi Ivanov on 7/24/15.
//  Copyright (c) 2015 GeorgiIvanov. All rights reserved.
//

#import "DSPHelpers.h"

const float Zero = 0.0f;

@implementation DSPHelpers

+(void)deinterleave:(float *)data left:(float**)left right:(float**)right length:(vDSP_Length)length
{
    float* leftChannel = (float *)malloc((length + 2) * sizeof(float));
    float* rightChannel = (float *)malloc((length + 2) * sizeof(float));
    
    vDSP_vsadd(data, 2, &Zero, leftChannel, 1, length);
    vDSP_vsadd(data + 1, 2, &Zero, rightChannel, 1, length - 1);
    
    *left = leftChannel;
    *right = rightChannel;
}

+(void)channelData:(float**)deinterleavedData fromInterleavedData:(float*)data channel:(AudioChannel)channel amplifySignal:(float)multiplicand length:(vDSP_Length)length
{
    float* extractedData = (float *)malloc((length + 2) * sizeof(float));
    int position = (channel == kLeftChannel) ? 0 : 1;
    
    vDSP_vsmul(data + position, 2, &multiplicand, extractedData, 1, length - position);
    
    *deinterleavedData = extractedData;
}

@end
