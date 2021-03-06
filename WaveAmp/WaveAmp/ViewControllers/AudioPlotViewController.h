//
//  AudioPlotViewController.h
//  WaveAmp
//
//  Created by Georgi Ivanov on 10/22/15.
//  Copyright © 2015 GeorgiIvanov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <EZAudioPlot.h>

@interface AudioPlotViewController : UIViewController

@property(nonatomic) EZPlotType plotType;
@property(nonatomic) BOOL shouldFill;
@property(nonatomic) BOOL shouldMirror;

@property (weak, nonatomic) IBOutlet EZAudioPlot *adjustedPlot;
@property (weak, nonatomic) IBOutlet EZAudioPlot *originalPlot;

-(void)updateAdjustedSpeechBuffer:(float *)buffer withBufferSize:(UInt32)bufferSize;
-(void)updateOriginalSpeechBuffer:(float *)buffer withBufferSize:(UInt32)bufferSize;
-(void)clearPlot;
-(void)showAdjustedPlotInFront:(BOOL)adjustedInFront;

@end
