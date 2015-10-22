//
//  AudioPlotViewController.m
//  WaveAmp
//
//  Created by Georgi Ivanov on 10/22/15.
//  Copyright © 2015 GeorgiIvanov. All rights reserved.
//

#import "AudioPlotViewController.h"

@interface AudioPlotViewController ()

@end

@implementation AudioPlotViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.adjustedPlot.shouldOptimizeForRealtimePlot = YES;
        self.originalPlot.shouldOptimizeForRealtimePlot = YES;
    }
    return self;
}

-(void)setPlotType:(EZPlotType)plotType
{
    self.adjustedPlot.plotType = plotType;
    self.originalPlot.plotType = plotType;
    _plotType = plotType;
}

-(void)setShouldFill:(BOOL)shouldFill
{
    self.adjustedPlot.shouldFill = shouldFill;
    self.originalPlot.shouldFill = shouldFill;
    _shouldFill = shouldFill;
}

-(void)setShouldMirror:(BOOL)shouldMirror
{
    self.adjustedPlot.shouldMirror = shouldMirror;
    self.originalPlot.shouldMirror = shouldMirror;
    _shouldMirror = shouldMirror;
}

-(void)updateAdjustedSpeechBuffer:(float *)buffer withBufferSize:(UInt32)bufferSize
{
    [self.adjustedPlot updateBuffer:buffer withBufferSize:bufferSize];
}

-(void)updateOriginalSpeechBuffer:(float *)buffer withBufferSize:(UInt32)bufferSize
{
    [self.originalPlot updateBuffer:buffer withBufferSize:bufferSize];
}

-(void)clearPlot
{
    [self.adjustedPlot clear];
    [self.originalPlot clear];
}

-(void)showAdjustedPlotInFront:(BOOL)adjustedInFront
{
    if(adjustedInFront)
    {
        [self.view bringSubviewToFront:self.adjustedPlot];
    }
    else
    {
        [self.view sendSubviewToBack:self.adjustedPlot];
    }
}

@end
