//
//  AudioPlot.m
//  WaveAmp
//
//  Created by Georgi Ivanov on 7/25/15.
//  Copyright (c) 2015 GeorgiIvanov. All rights reserved.
//

#import "AudioPlot.h"

@implementation AudioPlot

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
        [self bringSubviewToFront:self.adjustedPlot];
    }
    else
    {
        [self sendSubviewToBack:self.adjustedPlot];
    }
}

@end
