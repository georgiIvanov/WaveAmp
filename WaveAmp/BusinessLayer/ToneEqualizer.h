//
//  ToneEqualizer.h
//  WaveAmp
//
//  Created by Georgi Ivanov on 7/15/15.
//  Copyright (c) 2015 GeorgiIvanov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AudiogramData.h"
#import "AudioTypes.h"

@interface ToneEqualizer : NSObject

@property(nonatomic, copy) AudioOutputBlock equalizerBlock;
@property(nonatomic, readonly) BOOL adjustingSpeech;

-(id)init UNAVAILABLE_ATTRIBUTE;
-(instancetype)initWithAudiogram:(AudiogramData*)audiogramData samplingRate:(Float64)samplingRage;

@end
