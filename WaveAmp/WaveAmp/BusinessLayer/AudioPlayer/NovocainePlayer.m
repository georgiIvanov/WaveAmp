//
//  AudioPlayer.m
//  WaveAmp
//
//  Created by Georgi Ivanov on 7/23/15.
//  Copyright (c) 2015 GeorgiIvanov. All rights reserved.
//

#import "NovocainePlayer.h"
#import "NovocainePlayer_protected.h"

@interface NovocainePlayer()

@end

@implementation NovocainePlayer

- (instancetype)init
{
    self = [super init];
    if (self) {
        _audioManager = [Novocaine audioManager];
    }
    return self;
}

-(void)play
{
    [NSException raise:NSInternalInconsistencyException
                format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
}

-(void)pause
{
    [self.audioManager pause];
}

-(float)samplingRate
{
    return _audioManager.samplingRate;
}

-(BOOL)playing
{
    return _audioManager.playing;
}

-(void)dealloc
{
    _audioManager.outputBlock = nil;
}

@end
