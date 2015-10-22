//
//  MicrophonePlayer.m
//  WaveAmp
//
//  Created by Georgi Ivanov on 10/22/15.
//  Copyright © 2015 GeorgiIvanov. All rights reserved.
//

#import "MicrophonePlayer.h"
#import <EZAudio/EZMicrophone.h>

@interface MicrophonePlayer () <EZMicrophoneDelegate, EZOutputDataSource>

@property(nonatomic) BOOL isPlaying;
@property(nonatomic) float sampleRate;
@property(nonatomic) EZMicrophone* microphone;
@property(nonatomic) EZOutput* output;
@property(nonatomic) AudioBufferList* microphoneBufferList;
@property(nonatomic) UInt32 bufferListSize;

@end

@implementation MicrophonePlayer

- (instancetype)init
{
    self = [super init];
    if (self) {
        _microphone = [EZMicrophone microphoneWithDelegate:self];
    }
    return self;
}

-(void)play
{
    [self.microphone startFetchingAudio];
    [self.output startPlayback];
}

-(void)pause
{
    [self.microphone stopFetchingAudio];
    [self.output stopPlayback];
}


#pragma mark - Microphone Delegate

-(BOOL)playing
{
    return _isPlaying;
}

-(float)samplingRate
{
    return _sampleRate;
}

-(void)microphone:(EZMicrophone *)microphone changedPlayingState:(BOOL)isPlaying
{
    _isPlaying = isPlaying;
}

-(void)microphone:(EZMicrophone *)microphone hasAudioStreamBasicDescription:(AudioStreamBasicDescription)audioStreamBasicDescription
{
    _output = [EZOutput outputWithDataSource:self];
    _sampleRate = _output.clientFormat.mSampleRate;
}

-(void)microphone:(EZMicrophone *)microphone hasBufferList:(AudioBufferList *)bufferList withBufferSize:(UInt32)bufferSize withNumberOfChannels:(UInt32)numberOfChannels
{
    @synchronized(self)
    {
        self.microphoneBufferList = bufferList;
        self.bufferListSize = bufferSize;
    }
}

#pragma mark - Output

-(OSStatus)output:(EZOutput *)output shouldFillAudioBufferList:(AudioBufferList *)audioBufferList withNumberOfFrames:(UInt32)frames timestamp:(const AudioTimeStamp *)timestamp
{
    @synchronized(self)
    {
        if(_microphoneBufferList == nil)
        {
            return noErr;
        }
        
        AudioBuffer micAudioBuffer = _microphoneBufferList->mBuffers[0];
        Float32* micBuffer = (Float32*)micAudioBuffer.mData;
        
        if(self.outputBlock)
        {
            self.outputBlock(micBuffer, frames, 1);
        }
        
        for (int i = 0; i < audioBufferList->mNumberBuffers; i++)
        {
            AudioBuffer audioBuffer = audioBufferList->mBuffers[i];
            Float32* buffer = (Float32*)audioBuffer.mData;
            
            for (int frame = 0; frame < frames; frame++)
            {
                buffer[frame] = micBuffer[frame];
            }
        }
        
        _microphoneBufferList = nil;
    }
    
    return noErr;
}

@end
