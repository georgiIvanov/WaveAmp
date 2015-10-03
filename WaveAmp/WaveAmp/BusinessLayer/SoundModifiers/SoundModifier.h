//
//  SoundModifier.h
//  WaveAmp
//
//  Created by Georgi Ivanov on 7/25/15.
//  Copyright (c) 2015 GeorgiIvanov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AudiogramData.h"
#import "AudioTypes.h"

@interface SoundModifier : NSObject

@property(nonatomic) BOOL enabled;
@property(nonatomic, readonly) Float64 samplingRate;
@property(nonatomic, copy) AudioOutputBlock modifierBlock;

-(id)init UNAVAILABLE_ATTRIBUTE;
-(instancetype)initWithAudiogram:(AudiogramData*)audiogramData samplingRate:(Float64)samplingRate;

@end
