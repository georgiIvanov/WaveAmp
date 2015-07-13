//
//  AudiogramViewController.m
//  WaveAmp
//
//  Created by Georgi Ivanov on 7/9/15.
//  Copyright (c) 2015 GeorgiIvanov. All rights reserved.
//

#import "AudiogramViewController.h"
#import "PureToneAudiometer.h"
#import "AudiogramData.h"
#import "UIView+PopAnimations.h"

@interface AudiogramViewController()

@property(nonatomic) AudiogramData* audiogramData;

@end

@implementation AudiogramViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.audiogramData = [[NSUserDefaults standardUserDefaults] objectForKey:kAudiogramKey];
    }
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    if(self.audiogramData == nil)
    {
        self.noContentView.hidden = NO;
        [self.hearingTestButton addPopOutAnimationDelay:0.3f bounciness:10];
    }
}

- (IBAction)hearingTestTap:(id)sender
{
    [self performSegueWithIdentifier:@"AbsThresholdSegue" sender:self];
}
@end
