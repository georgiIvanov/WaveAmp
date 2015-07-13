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
#import "HearingExamSoundMeter.h"
#import "PureToneAudiometer.h"
#import "AmplitudeMultiplier.h"
#import "FrequencyThreshold.h"

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
    HearingExamSoundMeter* soundMeter = [[HearingExamSoundMeter alloc] init];
    
    __block float phase = 0.0;
    __block float dB = 0.0;
    [self.audioManager setOutputBlock:^(float *data, UInt32 numFrames, UInt32 numChannels)
     {
         float samplingRate = wself.audioManager.samplingRate;
         AudioChannel channel = wself.hearingExam.currentChannel;
         
         if(wself.hearingExam.currentFrequency == 0)
         {
             phase = 0;
         }
         
         for (int i = 0; i < numFrames; ++i)
         {
             for (int iChannel = 0; iChannel < numChannels; ++iChannel)
             {
                 float theta = phase * M_PI * 2;
                 data[i*numChannels + iChannel] = iChannel == channel ? sin(theta) * wself.hearingExam.signalMultiplier : 0;
             }

             phase += 1.0 / (samplingRate / wself.hearingExam.currentFrequency);
             if (phase > 1.0){
                 phase = -1;
             }
         }
         
         dB = [soundMeter getdBLevel:data numFrames:numFrames numChannels:numChannels];
         if(dB > 0)
         {
             NSLog(@"dB level: %.2f - %d", dB, channel);
         }
         else
         {
             NSLog(@"dB level: 0.00");
         }
     }];
    
    [self.hearingExam start];
}

#pragma mark - ToneAudiometerDelegate

-(void)startingTest:(int)number
{
    self.testNumberLabel.text = [NSString stringWithFormat:@"Test %d of %lu", number, (unsigned long)self.hearingExam.frequencies.count];
}

-(void)testsAreOver:(AudiogramData *)audiogramData
{
    self.testNumberLabel.text = @"Tests are completed.\nWell done!";
    
    [self.audioManager pause];
    NSLog(@"Results: \n\n");
    for (int i = 0; i < audiogramData.leftEar.count; i++)
    {
        FrequencyThreshold* left = audiogramData.leftEar[i];
        FrequencyThreshold* right = audiogramData.rightEar[i];
        NSLog(@"Frequency - %@; Left Threshold: %@ dB, Right Threshold: %@ dB", left.frequency, left.thresholdDb, right.thresholdDb);
    }
}

#pragma mark - UI Actions

- (IBAction)buttonHeld:(UIButton *)sender {
    [self.hearingExam buttonHeldForChannel:(int)sender.tag];
}

- (IBAction)buttonReleased:(UIButton *)sender {
    [self.hearingExam buttonReleasedForChannel:(int)sender.tag];
}
@end
