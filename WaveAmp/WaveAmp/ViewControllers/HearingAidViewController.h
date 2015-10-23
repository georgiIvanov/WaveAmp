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
#import "SpinningButton.h"
#import "BaseLabel.h"

@interface HearingAidViewController : PlaybackViewController
@property (weak, nonatomic) IBOutlet BouncyButton *microphoneButton;
@property (weak, nonatomic) IBOutlet BaseLabel *deviceStateLabel;
@property (weak, nonatomic) IBOutlet SpinningButton *switchButton;

- (IBAction)microphoneTap:(UIButton*)sender;
- (IBAction)switchInputSourceTap:(SpinningButton *)sender;

@end
