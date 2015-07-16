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
#import "SoundFile.h"

@interface AdjustedSpeechViewController () <UIPickerViewDataSource, UIPickerViewDelegate>

@property(nonatomic) Novocaine* audioManager;
@property(nonatomic) ToneEqualizer* toneEqualizer;
@property(nonatomic) AudioFileReader* fileReader;
@property(nonatomic) NSArray* speechFiles;

// resume playback if file wasn't changed
// TODO: AudioFileReader.currentTime does not report correct time with the currently used speech files
//       check with different files / formats / sample rates
@property(nonatomic) float currentTime;

@end

@implementation AdjustedSpeechViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.audioManager = [Novocaine audioManager];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
        
    [self loadSpeechPaths];
    [self.playbackButton setScalingTouchDown:1.7 touchUp:1];
    self.currentTime = 0.1;
}

-(void)viewWillAppear:(BOOL)animated
{
    __weak AdjustedSpeechViewController * wself = self;
    [self.audioManager setOutputBlock:^(float *data, UInt32 numFrames, UInt32 numChannels) {
        [wself.fileReader retrieveFreshAudio:data numFrames:numFrames numChannels:numChannels];
        [wself.toneEqualizer applyFilters:data numFrames:numFrames numChannels:numChannels];
    }];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if(self.playbackButton.playing)
    {
        [self.playbackButton togglePlayState];
        [self playbackTap:self.playbackButton];
    }
}


-(void)loadSpeechPaths
{
    NSArray* filePaths = [[NSBundle mainBundle] pathsForResourcesOfType:@"wav" inDirectory:@"AudioFiles"];
    NSMutableArray* speechFiles = [[NSMutableArray alloc] initWithCapacity:filePaths.count];
    
    for (NSString* path in filePaths)
    {
        SoundFile* sf = [[SoundFile alloc] initWithPath:path];
        [speechFiles addObject:sf];
    }
    self.speechFiles = speechFiles;
}

-(void)setAudiogramData:(AudiogramData *)audiogramData
{
    _audiogramData = audiogramData;
    self.toneEqualizer = [[ToneEqualizer alloc] initWithAudiogram:audiogramData samplingRate:self.audioManager.samplingRate];
}

-(void)startPlayingFile:(SoundFile*)sf
{    
    if(self.fileReader.playing || self.audioManager.playing)
    {
        [self.fileReader pause];
        [self.audioManager pause];
    }
    
    NSURL* url = [NSURL URLWithString:sf.path];
    self.fileReader = [[AudioFileReader alloc]
                       initWithAudioFileURL:url
                       samplingRate:self.audioManager.samplingRate
                       numChannels:self.audioManager.numOutputChannels];
    self.fileReader.currentTime = self.currentTime;
    [self.audioManager play];
    [self.fileReader play];
}

-(void)pausePlayback
{
    [self.fileReader pause];
    [self.audioManager pause];
}

#pragma mark - UIPickerView DataSource

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.speechFiles.count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    SoundFile* soundFile = self.speechFiles[row];
    return soundFile.name;
}

#pragma mark - UIPickerView DataSource

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if(self.playbackButton.playing)
    {
        self.currentTime = 0.1;
        SoundFile* sf = self.speechFiles[row];
        [self startPlayingFile:sf];
    }
}

#pragma UI Actions

- (IBAction)playbackTap:(id)sender
{
    if(self.playbackButton.playing)
    {
        SoundFile* sf = self.speechFiles[[self.pickerView selectedRowInComponent:0]];
        [self startPlayingFile:sf];
    }
    else
    {
        self.currentTime = self.fileReader.currentTime > 0 ? self.fileReader.currentTime : 0.1;
        [self pausePlayback];
    }
}
@end
