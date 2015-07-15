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

@end

@implementation AdjustedSpeechViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.audioManager = [Novocaine audioManager];
    AudiogramData* ad = [AudiogramData audiogramMildLoss];
    self.toneEqualizer = [[ToneEqualizer alloc] initWithAudiogram:ad samplingRate:self.audioManager.samplingRate];
    
    [self loadSpeechPaths];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    __weak AdjustedSpeechViewController * wself = self;
    [self.audioManager setOutputBlock:^(float *data, UInt32 numFrames, UInt32 numChannels) {
        [wself.fileReader retrieveFreshAudio:data numFrames:numFrames numChannels:numChannels];
        [wself.toneEqualizer applyFilters:data numFrames:numFrames numChannels:numChannels];
    }];
    [self startPlayingFile:self.speechFiles.firstObject];
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
    self.fileReader.currentTime = 0.1;
    [self.audioManager play];
    [self.fileReader play];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
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
    SoundFile* sf = self.speechFiles[row];
    [self startPlayingFile:sf];
}

@end
