//
//  AbsThresholdViewController.m
//  WaveAmp
//
//  Created by Georgi Ivanov on 7/9/15.
//  Copyright (c) 2015 GeorgiIvanov. All rights reserved.
//

#import "AbsThresholdViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <Novocaine.h>
#import "PureToneAudiometer.h"

@interface AbsThresholdViewController() <ToneAudiometerDelegate>

@property(nonatomic) Novocaine* audioManager;
@property(nonatomic) PureToneAudiometer* hearingExam;

@end

@implementation AbsThresholdViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    __weak AbsThresholdViewController * wself = self;
    self.audioManager = [Novocaine audioManager];
    self.hearingExam = [[PureToneAudiometer alloc] init];
    self.hearingExam.delegate = self;
    
    __block float phase = 0.0;
    [self.audioManager setOutputBlock:^(float *data, UInt32 numFrames, UInt32 numChannels)
     {
         float samplingRate = wself.audioManager.samplingRate;
         for (int i=0; i < numFrames; ++i)
         {
             for (int iChannel = 0; iChannel < numChannels; ++iChannel)
             {
                 float theta = phase * M_PI * 2;
                 data[i*numChannels + iChannel] = sin(theta) * 0.1;
             }
             
             phase += 1.0 / (samplingRate / wself.hearingExam.currentFrequency);
             if (phase > 1.0){
                 phase = -1;
             }
         }
     }];
    
    [self.hearingExam start];
}

@end
