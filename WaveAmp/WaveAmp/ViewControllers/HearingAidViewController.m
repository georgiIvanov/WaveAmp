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

@interface HearingAidViewController ()

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
        self.audioDevices = [[AudioDevices alloc] init];
        [self.microphonePlayer setInputDevice:self.audioDevices.currentInputDevice];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self showPlaybackStatus:NO];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if(_microphonePlayer.playing)
    {
        [self microphoneTap:self.microphoneButton];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UI Ations

- (IBAction)microphoneTap:(UIButton*)sender
{
    NSString* newImage = nil;
    if (self.microphonePlayer.playing)
    {
        [self.microphonePlayer pause];
        newImage = @"Microphone";
    }
    else
    {
        [self.microphonePlayer play];
        newImage = @"MicrophoneMuted";
    }
    
    [self showPlaybackStatus:NO];
    [CommonAnimations animate:sender
                 withNewImage:newImage
                      options:UIViewAnimationOptionTransitionCrossDissolve
                     duration:0.12f];
}
@end
