//
//  AudiogramViewController.m
//  WaveAmp
//
//  Created by Georgi Ivanov on 7/9/15.
//  Copyright (c) 2015 GeorgiIvanov. All rights reserved.
//

#import "AudiogramViewController.h"
#import "PureToneAudiometer.h"
#import "UIView+PopAnimations.h"

@interface AudiogramViewController()

@end

@implementation AudiogramViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    if(self.audiogramData == nil)
    {
        self.noContentView.hidden = NO;
        [self.hearingTestButton addPopOutAnimationDelay:0.3f bounciness:10];
    }
    
    self.audiogramData = [AudiogramData audiogramMildLoss]; // [[NSUserDefaults standardUserDefaults] objectForKey:kAudiogramKey];
}

-(void)setAudiogramData:(AudiogramData *)audiogramData
{
    _audiogramData = audiogramData;
    if(self.audiogramUpdated)
    {
        self.audiogramUpdated(audiogramData);
    }
}

- (IBAction)hearingTestTap:(id)sender
{
    [self performSegueWithIdentifier:@"AbsThresholdSegue" sender:self];
}
@end
