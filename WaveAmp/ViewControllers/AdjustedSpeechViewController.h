//
//  AdjustedSpeechViewController.h
//  WaveAmp
//
//  Created by Georgi Ivanov on 7/15/15.
//  Copyright (c) 2015 GeorgiIvanov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlaybackButton.h"

@interface AdjustedSpeechViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet PlaybackButton *playbackButton;

- (IBAction)playbackTap:(id)sender;

@end
