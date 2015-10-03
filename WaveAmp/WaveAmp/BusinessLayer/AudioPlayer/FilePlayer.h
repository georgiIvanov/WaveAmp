//
//  FilePlayer.h
//  WaveAmp
//
//  Created by Georgi Ivanov on 7/23/15.
//  Copyright (c) 2015 GeorgiIvanov. All rights reserved.
//

#import "AudioPlayer.h"

@interface FilePlayer : AudioPlayer

@property(nonatomic) float duration;

-(void)openFileWithURL:(NSURL*)url;

@end
