//
//  SoundModifier.m
//  WaveAmp
//
//  Created by Georgi Ivanov on 7/25/15.
//  Copyright (c) 2015 GeorgiIvanov. All rights reserved.
//

#import "SoundModifier.h"

@implementation SoundModifier

-(instancetype)initWithAudiogram:(AudiogramData*)audiogramData samplingRate:(Float64)samplingRate;
{
    self = [super init];
    if (self) {
        _enabled = YES;
        _samplingRate = samplingRate;
    }
    return self;
}

@end
