//
//  DSPHelpers.h
//  WaveAmp
//
//  Created by Georgi Ivanov on 7/24/15.
//  Copyright (c) 2015 GeorgiIvanov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Accelerate/Accelerate.h>
#import "AudioTypes.h"

@interface DSPHelpers : NSObject

/**
    Deinterleaves data from output stream. Caller is the owner of output buffers.
    @param data Interleaved data buffer.
    @param left Data for left channel.
    @param right Data for right channel.
    @param length Length of data buffer.
 */
+(void)deinterleave:(float *)data left:(float**)left right:(float**)right length:(vDSP_Length)length;

/**
 Gets data from output stream. Caller is the owner of output buffer.
 @param deinterleavedData Extracted data buffer.
 @param data Interleaved data buffer.
 @param addedScalar Scalar number added to the output buffer.
 @param length Length of data buffer.
 */
+(void)channelData:(float**)deinterleavedData fromInterleavedData:(float*)data channel:(AudioChannel)channel amplifySignal:(float)multiplicand length:(vDSP_Length)length;

@end
