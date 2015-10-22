//
//  PlaybackViewController.h
//  WaveAmp
//
//  Created by Georgi Ivanov on 10/22/15.
//  Copyright © 2015 GeorgiIvanov. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AudioPlotViewController.h"
#import "SoundModifiersFactory.h"
#import "SoundFile.h"
#import "AudiogramData.h"
#import "FilePlayer.h"
#import "SoundModifier.h"

@interface PlaybackViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *playbackStatus;

@property(nonatomic) FilePlayer* filePlayer;
@property(nonatomic) SoundModifier* soundModifier;
@property(nonatomic) SoundModType soundModifierType;
@property(nonatomic) AudiogramData* audiogramData;
@property(nonatomic, weak) AudioPlotViewController* audioPlotViewController;

-(void)showPlaybackStatus:(BOOL)shouldSimulateLoss;
-(void)startPlayingFile:(SoundFile*)sf;
-(void)pausePlayback;

@end
