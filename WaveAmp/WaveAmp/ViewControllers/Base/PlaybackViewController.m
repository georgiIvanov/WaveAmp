//
//  PlaybackViewController.m
//  WaveAmp
//
//  Created by Georgi Ivanov on 10/22/15.
//  Copyright © 2015 GeorgiIvanov. All rights reserved.
//

#import "PlaybackViewController.h"
#import "DSPHelpers.h"
#import "AudiogramData.h"
#import "CommonAnimations.h"

@interface PlaybackViewController ()

@end

@implementation PlaybackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
                [wself.audioPlotViewController updateOriginalSpeechBuffer:originalSignal withBufferSize:numFrames];
            }
            
            if(wself.soundModifier.enabled && adjustedSignal != NULL)
            {
                [wself.audioPlotViewController updateAdjustedSpeechBuffer:adjustedSignal withBufferSize:numFrames];
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
}

-(void)pausePlayback
{
    [self.filePlayer pause];
}

-(void)showPlaybackStatus:(BOOL)shouldSimulateLoss
{
    NSString* text;
    
    if(self.filePlayer.playing == NO)
    {
        text = @"Paused";
    }
    else if(shouldSimulateLoss)
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

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if([segue.identifier isEqualToString:@"AudioPlotSegue"])
    {
        self.audioPlotViewController = (AudioPlotViewController*)segue.destinationViewController;
    }
    
}

@end
