//
//  HearingAidViewController.h
//  WaveAmp
//
//  Created by Georgi Ivanov on 10/22/15.
//  Copyright © 2015 GeorgiIvanov. All rights reserved.
//

#import "PlaybackViewController.h"
#import "MicrophonePlayer.h"
#import "BouncyButton.h"

@interface HearingAidViewController : PlaybackViewController
@property (weak, nonatomic) IBOutlet BouncyButton *microphoneButton;

- (IBAction)microphoneTap:(UIButton*)sender;

@end
