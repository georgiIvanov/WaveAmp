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
                 data[i*numChannels + iChannel] = iChannel == channel ? sin(theta) * [AmplitudeMultiplier multiplierForWaveDb:@(25)] : 0;
             }

             phase += 1.0 / (samplingRate / wself.hearingExam.currentFrequency);
             if (phase > 1.0){
                 phase = -1;
             }
         }
         
         dB = [soundMeter getdBLevel:data numFrames:numFrames numChannels:numChannels];
//         NSLog(@"dB level: %f", dB);
     }];
    
    [self.hearingExam start];
}

#pragma mark - ToneAudiometerDelegate

-(void)startingTest:(int)number
{
    self.testNumberLabel.text = [NSString stringWithFormat:@"Test %d of %lu", number, (unsigned long)self.hearingExam.frequencies.count];
}

-(void)testsAreOver
{
    self.testNumberLabel.text = @"Tests are completed.\nWell done!";
}

#pragma mark - UI Actions

- (IBAction)buttonHeld:(UIButton *)sender {
    NSLog(@"held %ld",(long)sender.tag);
    [self.hearingExam buttonHeldForChannel:(int)sender.tag];
}

- (IBAction)buttonReleased:(UIButton *)sender {
    NSLog(@"released %ld",(long)sender.tag);
    [self.hearingExam buttonReleasedForChannel:(int)sender.tag];
}
@end
