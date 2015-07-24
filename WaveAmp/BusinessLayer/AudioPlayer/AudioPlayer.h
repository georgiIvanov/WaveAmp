//
//  AudioPlayer.h
//  WaveAmp
//
//  Created by Georgi Ivanov on 7/23/15.
//  Copyright (c) 2015 GeorgiIvanov. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^AudioOutputBlock)(float *data, UInt32 numFrames, UInt32 numChannels);

@interface AudioPlayer : NSObject

@property(nonatomic, copy) AudioOutputBlock outputBlock;
@property(nonatomic, readonly) float samplingRate;
@property(nonatomic, readonly) BOOL playing;

-(void)play;
-(void)pause;
-(void)handOverOutput;

@end
