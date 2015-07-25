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

@property(nonatomic, copy) AudioOutputBlock modifierBlock;

@end
