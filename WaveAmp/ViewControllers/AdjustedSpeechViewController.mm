//
//  AdjustedSpeechViewController.m
//  WaveAmp
//
//  Created by Georgi Ivanov on 7/15/15.
//  Copyright (c) 2015 GeorgiIvanov. All rights reserved.
//

#import "AdjustedSpeechViewController.h"
#import <Novocaine.h>
#import <AudioFileReader.h>
#import "ToneEqualizer.h"

@interface AdjustedSpeechViewController ()

@property(nonatomic) Novocaine* audioManager;
@property(nonatomic) ToneEqualizer* toneEqualizer;
@property(nonatomic) AudioFileReader* fileReader;

@end

@implementation AdjustedSpeechViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.audioManager = [Novocaine audioManager];
    AudiogramData* ad = [AudiogramData audiogramMildLoss];
    self.toneEqualizer = [[ToneEqualizer alloc] initWithAudiogram:ad samplingRate:self.audioManager.samplingRate];
    
    NSURL *inputFileURL = [[NSBundle mainBundle] URLForResource:@"OSR_us_000_0039_8k_m" withExtension:@"wav"];
    
    self.fileReader = [[AudioFileReader alloc]
                       initWithAudioFileURL:inputFileURL
                       samplingRate:self.audioManager.samplingRate
                       numChannels:self.audioManager.numOutputChannels];
    
    __weak AdjustedSpeechViewController * wself = self;
    [self.audioManager setOutputBlock:^(float *data, UInt32 numFrames, UInt32 numChannels) {
        [wself.fileReader retrieveFreshAudio:data numFrames:numFrames numChannels:numChannels];
        [wself.toneEqualizer applyFilters:data numFrames:numFrames numChannels:numChannels];
     }];
    
    [self.fileReader play];
    self.fileReader.currentTime = 0;
    [self.audioManager play];
}

@end
