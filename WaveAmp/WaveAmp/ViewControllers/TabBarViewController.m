//
//  TabBarViewController.m
//  WaveAmp
//
//  Created by Georgi Ivanov on 7/9/15.
//  Copyright (c) 2015 GeorgiIvanov. All rights reserved.
//

#import "TabBarViewController.h"
#import "AudiogramViewController.h"
#import "AdjustedSpeechViewController.h"
#import "ViewConstants.h"
#import "HearingAidViewController.h"

@interface TabBarViewController()

@property(nonatomic, weak) AudiogramViewController* audiogramVc;
@property(nonatomic, weak) AdjustedSpeechViewController* adjustedSpeechVc;
@property(nonatomic, weak) HearingAidViewController* hearingAidVc;

@end

@implementation TabBarViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [[UITabBar appearance] setTintColor:GreenTint];
    
    for (UIViewController* vc in self.viewControllers)
    {
        if([vc isKindOfClass:[AudiogramViewController class]])
        {
            self.audiogramVc = (AudiogramViewController*)vc;
        }
        else if([vc isKindOfClass:[AdjustedSpeechViewController class]])
        {
            self.adjustedSpeechVc = (AdjustedSpeechViewController*)vc;
        }
        else if([vc isKindOfClass:[HearingAidViewController class]])
        {
            self.hearingAidVc = (HearingAidViewController*)vc;
        }
    }
    
    __weak typeof(self) wself = self;
    self.audiogramVc.audiogramUpdated = ^(AudiogramData* ad){
        wself.adjustedSpeechVc.audiogramData = ad;
        wself.hearingAidVc.audiogramData = ad;
    };
}

@end
