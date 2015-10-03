//
//  PlaybackButton.h
//  WaveAmp
//
//  Created by Georgi Ivanov on 7/15/15.
//  Copyright (c) 2015 GeorgiIvanov. All rights reserved.
//

#import "BouncyButton.h"

@interface PlaybackButton : BouncyButton

@property(nonatomic, readonly) BOOL playing;

-(void)togglePlayState;

@end
