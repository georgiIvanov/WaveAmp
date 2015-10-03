//
//  PureTonePlayer.m
//  WaveAmp
//
//  Created by Georgi Ivanov on 7/23/15.
//  Copyright (c) 2015 GeorgiIvanov. All rights reserved.
//

#import "PureTonePlayer.h"
#import <AVFoundation/AVFoundation.h>
#import "AudioPlayer_protected.h"

@implementation PureTonePlayer

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.signalMultiplier = 1;
    }
    return self;
}

-(void)play
{
    __weak PureTonePlayer* wself = self;
    __block float phase = 0.0;
    [self.audioManager setOutputBlock:^(float *data, UInt32 numFrames, UInt32 numChannels)
     {
         float samplingRate = wself.audioManager.samplingRate;
         
         if(wself.frequency == 0)
         {
             phase = 0;
         }
         
         for (int i = 0; i < numFrames; ++i)
         {
             for (int iChannel = 0; iChannel < numChannels; ++iChannel)
             {
                 float theta = phase * M_PI * 2;
                 data[i*numChannels + iChannel] = iChannel == wself.channel ? sin(theta) * wself.signalMultiplier : 0;
             }
             
             phase += 1.0 / (samplingRate / wself.frequency);
             if (phase > 1.0){
                 phase = -1;
             }
         }
         
         [wself handOverOutput];
     }];
    [self.audioManager play];
}

-(void)testingFrequency:(float)frequency
{
    self.frequency = frequency;
}

-(void)testingWithSignalMultiplier:(float)signalMultiplier
{
    self.signalMultiplier = signalMultiplier;
}

-(void)testingAudioChannel:(AudioChannel)audioChannel
{
    self.channel = audioChannel;
}

@end
