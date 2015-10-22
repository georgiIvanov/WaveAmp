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
#import "SoundFile.h"
#import "DSPHelpers.h"

@interface AdjustedSpeechViewController ()

@property(nonatomic) NSArray* speechFiles;

@end

@implementation AdjustedSpeechViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.filePlayer = [[FilePlayer alloc] init];
        self.soundModifierType = kToneEqualizer;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.speechFilePicker viewControllerDidLoad];
    self.simulateLossCheckbox.checkmarkColor = [UIColor colorWithRed:0.996 green:1 blue:1 alpha:1];
    
    [self loadSpeechPaths];
    [self.playbackButton setScalingTouchDown:1.7 touchUp:1];
    [self showPlaybackStatus:self.simulateLossCheckbox.isChecked];
    
    self.audioPlotViewController.plotType = EZPlotTypeRolling;
    self.audioPlotViewController.shouldFill = YES;
    self.audioPlotViewController.shouldMirror = YES;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if(self.playbackButton.playing)
    {
        [self.playbackButton togglePlayState];
        [self playbackTap:self.playbackButton];
    }
    
    [self.audioPlotViewController clearPlot];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // TODO: use another checkbox
    // the first time this checkbox draws on iPad its a bit off
    // switching states like this helps to fix this
    [self.simulateLossCheckbox switchStatesAnimated:NO];
    [self.simulateLossCheckbox switchStatesAnimated:NO];
}


-(void)loadSpeechPaths
{
    NSArray* filePaths = [[NSBundle mainBundle] pathsForResourcesOfType:@"wav" inDirectory:@"AudioFiles"];
    NSMutableArray* speechFiles = [[NSMutableArray alloc] initWithCapacity:filePaths.count];
    NSMutableArray* names = [[NSMutableArray alloc] initWithCapacity:filePaths.count];
    
    for (NSString* path in filePaths)
    {
        SoundFile* sf = [[SoundFile alloc] initWithPath:path];
        [speechFiles addObject:sf];
        [names addObject:sf.name];
    }
    
    self.speechFiles = speechFiles;
    [self.speechFilePicker setSectionTitles:names];
}

#pragma mark - Overridden methods

-(void)startPlayingFile:(SoundFile*)sf
{
    [super startPlayingFile:sf];
    [self showPlaybackStatus:self.simulateLossCheckbox.isChecked];
}

-(void)pausePlayback
{
    [super pausePlayback];
    [self showPlaybackStatus:self.simulateLossCheckbox.isChecked];
}

#pragma mark - UI Actions


- (IBAction)segmentedControlChangedValue:(HMSegmentedControl*)sender
{
    if(self.playbackButton.playing)
    {
        SoundFile* sf = self.speechFiles[sender.selectedSegmentIndex];
        [self startPlayingFile:sf];
    }
}

- (IBAction)playbackTap:(id)sender
{
    if(self.playbackButton.playing)
    {
        SoundFile* sf = self.speechFiles[self.speechFilePicker.selectedSegmentIndex];
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
    [self.audioPlotViewController clearPlot];
    [self.audioPlotViewController showAdjustedPlotInFront:sender.isChecked];
    [self showPlaybackStatus:sender.isChecked];
}
@end