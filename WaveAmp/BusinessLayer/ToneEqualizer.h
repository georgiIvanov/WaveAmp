//
//  ToneEqualizer.h
//  WaveAmp
//
//  Created by Georgi Ivanov on 7/15/15.
//  Copyright (c) 2015 GeorgiIvanov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AudiogramData.h"

@interface ToneEqualizer : NSObject

-(id)init UNAVAILABLE_ATTRIBUTE;
-(instancetype)initWithAudiogram:(AudiogramData*)audiogramData samplingRate:(Float64)samplingRage;

-(void)applyFilters:(float *)buffer numFrames:(UInt32)framesCount numChannels:(UInt32)channels;
@end
