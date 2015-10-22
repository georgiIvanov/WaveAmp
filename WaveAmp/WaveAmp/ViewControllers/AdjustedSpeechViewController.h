//
//  AdjustedSpeechViewController.h
//  WaveAmp
//
//  Created by Georgi Ivanov on 7/15/15.
//  Copyright (c) 2015 GeorgiIvanov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BFPaperCheckbox.h>
#import "PlaybackViewController.h"
#import "SegmentedControl.h"
#import "PlaybackButton.h"

@interface AdjustedSpeechViewController : PlaybackViewController

@property (weak, nonatomic) IBOutlet SegmentedControl *speechFilePicker;
@property (weak, nonatomic) IBOutlet PlaybackButton *playbackButton;
@property (weak, nonatomic) IBOutlet BFPaperCheckbox *simulateLossCheckbox;

- (IBAction)segmentedControlChangedValue:(HMSegmentedControl*)sender;
- (IBAction)playbackTap:(id)sender;
- (IBAction)checkBoxValueChanged:(BFPaperCheckbox *)sender;

@end
