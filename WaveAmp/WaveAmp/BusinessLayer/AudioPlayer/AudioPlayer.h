//
//  AudioPlayer.h
//  WaveAmp
//
//  Created by Georgi Ivanov on 10/22/15.
//  Copyright © 2015 GeorgiIvanov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AudioTypes.h"

@interface AudioPlayer : NSObject

@property(nonatomic, copy) AudioOutputBlock outputBlock;
@property(nonatomic, readonly) float samplingRate;
@property(nonatomic, readonly) BOOL playing;

-(void)play;
-(void)pause;

@end
