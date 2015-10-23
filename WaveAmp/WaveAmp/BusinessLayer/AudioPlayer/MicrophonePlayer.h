//
//  MicrophonePlayer.h
//  WaveAmp
//
//  Created by Georgi Ivanov on 10/22/15.
//  Copyright © 2015 GeorgiIvanov. All rights reserved.
//

#import "AudioPlayer.h"
#import <EZAudioDevice.h>

@interface MicrophonePlayer : AudioPlayer

-(void)setInputDevice:(EZAudioDevice*)inputDevice;

@end
