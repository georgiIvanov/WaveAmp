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
#import "TestInstructionsViewController.h"
#import "CommonAnimations.h"

@interface AbsThresholdViewController() <ToneAudiometerDelegate, TestInstructionsDelegate>

@property(nonatomic) Novocaine* audioManager;
@property(nonatomic) PureToneAudiometer* hearingExam;

@end

@implementation AbsThresholdViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // initializing novocaine asap stalls the transition,
        // we don't need it right away anyway.
        self.audioManager = [Novocaine audioManager];
        self.hearingExam = [[PureToneAudiometer alloc] init];
        self.hearingExam.delegate = self;
    });
    
    [self setupViewsForInstructions];
    self.testNumberLabel.text = @"Tests will start soon.";
}

-(void)setupViewsForInstructions
{
    for (UIView* v in self.testUI) {
        v.hidden = YES;
    }
    
    self.instructionsContainer.hidden = NO;
}

-(void)prepareViewsForStartingTests
{
    for (UIView* v in self.testUI) {
        v.hidden = NO;
        v.alpha = 0;
        [UIView animateWithDuration:0.2f animations:^{
            v.alpha = 1;
        }];
    }
    
    [UIView animateWithDuration:0.2f animations:^{
        self.instructionsContainer.alpha = 0;
    } completion:^(BOOL finished) {
        self.instructionsContainer.hidden = YES;
    }];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"instructionsSegue"])
    {
        TestInstructionsViewController* vc = (TestInstructionsViewController*)segue.destinationViewController;
        vc.delegate = self;
    }
}

-(void)startExam
{
    HearingExamSoundMeter* soundMeter = [[HearingExamSoundMeter alloc] init];
    __weak AbsThresholdViewController * wself = self;
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
    [self.audioManager play];
}

#pragma mark - ToneAudiometerDelegate

-(void)startingTest:(int)number
{
    [CommonAnimations animate:self.testNumberLabel
                  withNewText:[NSString stringWithFormat:@"Test %d of %lu", number, (unsigned long)self.hearingExam.frequencies.count]
                     duration:0.2f
              completionBlock:nil];
}

-(void)testsAreOver:(AudiogramData *)audiogramData
{
    self.testNumberLabel.text = @"Tests are completed.\nWell done!";
    
    [self.audioManager pause];
    // TODO: save audiogram
}

#pragma mark - TestInstructionsDelegate

-(void)userIsReady
{
    [self prepareViewsForStartingTests];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self startExam];
    });
}

#pragma mark - UI Actions

- (IBAction)buttonHeld:(UIButton *)sender {
    [self.hearingExam buttonHeldForChannel:(int)sender.tag];
}

- (IBAction)buttonReleased:(UIButton *)sender {
    [self.hearingExam buttonReleasedForChannel:(int)sender.tag];
}
@end
