//
//  AdjustedSpeechViewController.m
//  WaveAmp
//
//  Created by Georgi Ivanov on 7/15/15.
//  Copyright (c) 2015 GeorgiIvanov. All rights reserved.
//

#import "AdjustedSpeechViewController.h"
#import "CommonAnimations.h"
#import "FilePlayer.h"
#import "SoundModifiersFactory.h"
#import "SoundFile.h"
#import "DSPHelpers.h"

@interface AdjustedSpeechViewController () <UIPickerViewDataSource, UIPickerViewDelegate>

@property(nonatomic) FilePlayer* filePlayer;
@property(nonatomic) SoundModifier* soundModifier;
@property(nonatomic) NSArray* speechFiles;
@property(nonatomic) SoundModType soundModifierType;

@end

@implementation AdjustedSpeechViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        _filePlayer = [[FilePlayer alloc] init];
        _soundModifierType = kToneEqualizer;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
        
    [self loadSpeechPaths];
    [self.playbackButton setScalingTouchDown:1.7 touchUp:1];
    [self showPlaybackStatus];
    
    self.audioPlot.plotType = EZPlotTypeRolling;
    self.audioPlot.shouldFill = YES;
    self.audioPlot.shouldMirror = YES;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if(self.playbackButton.playing)
    {
        [self.playbackButton togglePlayState];
        [self playbackTap:self.playbackButton];
    }
    
    [self.audioPlot clearPlot];
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
    self.soundModifier = [SoundModifiersFactory soundModifier:self.soundModifierType withAudiogramData:audiogramData samplingRage:self.filePlayer.samplingRate];
    
    __weak typeof(self) wself = self;
    self.filePlayer.outputBlock = ^void(float *data, UInt32 numFrames, UInt32 numChannels){
        
        float* originalSignal = NULL;
        float* adjustedSignal = NULL;
        
        [DSPHelpers channelData:&originalSignal fromInterleavedData:data channel:kLeftChannel amplifySignal:2.5f length:numFrames];
        
        if(wself.soundModifier.enabled)
        {
            wself.soundModifier.modifierBlock(data, numFrames, numChannels);
            [DSPHelpers channelData:&adjustedSignal fromInterleavedData:data channel:kLeftChannel amplifySignal:2.5f length:numFrames];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            // TODO: Try updating plots in one CATransaction to prevent
            // occasional flickering of the plot (its less visible on real device than the simulator)
            if(originalSignal != NULL)
            {
                [wself.audioPlot updateOriginalSpeechBuffer:originalSignal withBufferSize:numFrames];
            }
            
            if(wself.soundModifier.enabled && adjustedSignal != NULL)
            {
                [wself.audioPlot updateAdjustedSpeechBuffer:adjustedSignal withBufferSize:numFrames];
                free(adjustedSignal);
            }
            free(originalSignal);
        });
        
    };
}

-(void)startPlayingFile:(SoundFile*)sf
{    
    if(self.filePlayer.playing)
    {
        [self.filePlayer pause];
    }
    
    NSURL* url = [NSURL URLWithString:sf.path];
    [self.filePlayer openFileWithURL:url];
    [self.filePlayer play];
    [self showPlaybackStatus];
}

-(void)pausePlayback
{
    [self.filePlayer pause];
    [self showPlaybackStatus];
}

-(void)showPlaybackStatus
{
    NSString* text;
    
    if(self.filePlayer.playing == NO)
    {
        text = @" ";
    }
    else if(self.simulateLossCheckbox.isChecked)
    {
        text = @"Simulated Loss";
    }
    else if(self.audiogramData == nil || [self.audiogramData isWithinNormalLoss])
    {
        text = @"Normal";
    }
    else
    {
        text = @"Amplified speech";
    }
    
    [CommonAnimations animate:self.playbackStatus
                  withNewText:text
                     duration:0.3
              completionBlock:nil];
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
        [self pausePlayback];
    }
}

- (IBAction)checkBoxValueChanged:(BFPaperCheckbox *)sender
{
    self.soundModifierType = sender.isChecked ? kHearingLoss : kToneEqualizer;
    self.soundModifier = [SoundModifiersFactory soundModifier:self.soundModifierType
                                            withAudiogramData:self.audiogramData
                                                 samplingRage:self.filePlayer.samplingRate];
    [self.audioPlot clearPlot];
    [self.audioPlot showAdjustedPlotInFront:sender.isChecked];
    [self showPlaybackStatus];
}
@end
