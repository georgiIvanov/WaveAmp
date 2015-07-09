//
//  AudiogramViewController.m
//  WaveAmp
//
//  Created by Georgi Ivanov on 7/9/15.
//  Copyright (c) 2015 GeorgiIvanov. All rights reserved.
//

#import "AudiogramViewController.h"
#import "PureToneAudiometer.h"

@interface AudiogramViewController()

@property(nonatomic) NSDictionary* audiogramData;

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

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if(!self.audiogramData)
    {
        [self performSegueWithIdentifier:@"AbsThresholdSegue" sender:self];
    }
}

@end
