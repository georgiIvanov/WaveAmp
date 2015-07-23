//
//  PureTonePlayer.h
//  WaveAmp
//
//  Created by Georgi Ivanov on 7/23/15.
//  Copyright (c) 2015 GeorgiIvanov. All rights reserved.
//

#import "AudioPlayer.h"
#import "AudiometerProtocols.h"

@interface PureTonePlayer : AudioPlayer <AudiometerPlayerDelegate>

@property(nonatomic) AudioChannel channel;
@property(nonatomic) float frequency;
@property(nonatomic) float signalMultiplier;

@end
