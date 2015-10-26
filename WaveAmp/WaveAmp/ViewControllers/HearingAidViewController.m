//
//  HearingAidViewController.m
//  WaveAmp
//
//  Created by Georgi Ivanov on 10/22/15.
//  Copyright © 2015 GeorgiIvanov. All rights reserved.
//

#import "HearingAidViewController.h"
#import "AudioDevices.h"
#import "CommonAnimations.h"
#import "UIView+PopAnimations.h"

@interface HearingAidViewController () <AudioDevicesDelegate>

@property(nonatomic) MicrophonePlayer* microphonePlayer;
@property(nonatomic) AudioDevices* audioDevices;

@end

@implementation HearingAidViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        _microphonePlayer = [[MicrophonePlayer alloc] init];
        super.audioPlayer = _microphonePlayer;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.audioDevices = [[AudioDevices alloc] initWithCurrentAudioDevice:self.microphonePlayer.currentInputDevice];
    self.audioDevices.delegate = self;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self showPlaybackStatusWithSimulatedLoss:NO];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

    [self buttonStartPlaying:YES];
    [self.microphonePlayer pause];
}

-(void)buttonStartPlaying:(BOOL)startPlaying
{
    NSString* newImage = nil;
    if (startPlaying)
    {
        newImage = @"Microphone";
    }
    else
    {
        newImage = @"MicrophoneMuted";
    }
    
    [self showPlaybackStatusWithSimulatedLoss:NO];
    [CommonAnimations animate:self.microphoneButton
                 withNewImage:newImage
                      options:UIViewAnimationOptionTransitionCrossDissolve
                     duration:0.12f];
}

#pragma mark - UI Ations

- (IBAction)microphoneTap:(UIButton*)sender
{
    if(!self.audioDevices.usingHeadphones)
    {
        [self.deviceStateLabel addStretchAnimationBounciness:10 velocity:CGPointMake(2, 2)];
        return;
    }
    
    if(self.microphonePlayer.playing)
    {
        [self.microphonePlayer pause];
    }
    else
    {
        [self.microphonePlayer play];
    }
    
    [self buttonStartPlaying:self.microphonePlayer.playing];
}

- (IBAction)switchInputSourceTap:(SpinningButton *)sender {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        EZAudioDevice* nextDevice = [self.audioDevices nextInputDevice];
        self.microphonePlayer.currentInputDevice = nextDevice;
        dispatch_async(dispatch_get_main_queue(), ^{
            self.deviceStateLabel.text = nextDevice.name;
        });
    });
    
}

#pragma mark - AudioDevices Delegate

-(void)headphonesArePluggedIn:(BOOL)usingHeadphones
{
    self.switchButton.enabled = usingHeadphones;
    if(usingHeadphones)
    {
        self.microphonePlayer.currentInputDevice = self.audioDevices.currentInputDevice;
        self.deviceStateLabel.text = self.audioDevices.currentInputDevice.name;
    }
    else
    {
        if(self.microphonePlayer.playing)
        {
            [self.microphonePlayer pause];
            [self buttonStartPlaying:YES];
        }
        self.deviceStateLabel.text = @"Please plugin headphones.";
    }
}

-(void)applicationInterrupted
{
    [self.microphonePlayer pause];
    [self buttonStartPlaying:NO];
}

-(void)interruptionEndedShouldResume:(BOOL)shouldResume
{
    if(shouldResume && self.audioDevices.usingHeadphones)
    {
        [self.microphonePlayer play];
        [self buttonStartPlaying:YES];
    }
}

@end
