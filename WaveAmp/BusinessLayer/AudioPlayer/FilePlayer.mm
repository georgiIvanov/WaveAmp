//
//  FilePlayer.m
//  WaveAmp
//
//  Created by Georgi Ivanov on 7/23/15.
//  Copyright (c) 2015 GeorgiIvanov. All rights reserved.
//

#import "FilePlayer.h"
#import "AudioPlayer_protected.h"
#import <AudioFileReader.h>

@interface FilePlayer()

@property(nonatomic) AudioFileReader* fileReader;

@end

@implementation FilePlayer

-(void)play
{
    __weak FilePlayer * wself = self;
    [self.audioManager setOutputBlock:^(float *data, UInt32 numFrames, UInt32 numChannels) {
        
        if(wself.fileReader.currentTime + 0.1 >= wself.duration && wself.fileReader != nil)
        {
            wself.fileReader.currentTime = 0;
            memset(data, 0, numChannels * numFrames * sizeof(float));
            return;
        }
        
        if(_fileReader.playing)
        {
            [wself.fileReader retrieveFreshAudio:data numFrames:numFrames numChannels:numChannels];
            if(wself.outputBlock)
            {
                wself.outputBlock(data, numFrames, numChannels);
            }
        }
        else
        {
            memset(data, 0, numChannels * numFrames * sizeof(float));
        }
    }];
    
    [self.fileReader play];
    [self.audioManager play];
}

-(void)pause
{
    [super pause];
    [self.fileReader pause];
}

-(void)openFileWithURL:(NSURL*)url
{
    self.fileReader = [[AudioFileReader alloc]
                       initWithAudioFileURL:url
                       samplingRate:self.audioManager.samplingRate
                       numChannels:self.audioManager.numOutputChannels];
    self.fileReader.currentTime = 0;
    self.duration = [self.fileReader getDuration];
}

-(BOOL)playing
{
    BOOL isPlaying = self.fileReader.playing | self.audioManager.playing;
    return isPlaying;
}

@end
