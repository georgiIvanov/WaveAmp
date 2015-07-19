//
//  AudiogramView.m
//  WaveAmp
//
//  Created by Georgi Ivanov on 7/19/15.
//  Copyright (c) 2015 GeorgiIvanov. All rights reserved.
//

#import "AudiogramView.h"
#import "FrequencyThreshold.h"
#import "UIView+PopAnimations.h"

@interface AudiogramView()

@property(nonatomic) NSArray* dBConstraints;
@property(nonatomic) AudiogramData* audiogramData;

@end

@implementation AudiogramView

-(void)setupView
{
    NSSortDescriptor* sort = [[NSSortDescriptor alloc] initWithKey:@"constant" ascending:YES];
    self.dBConstraints = [self.dBVerticalConstraints sortedArrayUsingDescriptors:@[sort]];
}

-(void)showAudiogram:(AudiogramData*)audiogramData
{
    self.audiogramData = audiogramData;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    if(self.audiogramData)
    {
        [self layoutMarkers:self.leftMarkers forEarThresholds:self.audiogramData.leftEar];
        [self layoutMarkers:self.rightMarkers forEarThresholds:self.audiogramData.rightEar];
    }
}

-(void)layoutMarkers:(NSArray*)markers forEarThresholds:(NSArray*)earThresholds
{
    for (int i = 0; i < markers.count && i < earThresholds.count; i++)
    {
        FrequencyThreshold* ft = (FrequencyThreshold*)earThresholds[i];
        NSInteger dbIndex = (ft.thresholdDb.integerValue - 10) / 10;
        AudiogramMarkerView* marker = (AudiogramMarkerView*)markers[i];
        
        NSLayoutConstraint* constraint = (NSLayoutConstraint*)self.dBConstraints[dbIndex];
        CGFloat verticalSpacing = 0;
        if(ft.thresholdDb.integerValue % 10 > 0)
        {
            verticalSpacing = constraint.constant + 15;
        }
        else
        {
            verticalSpacing = constraint.constant;
        }
        
        [marker animateConstraint:marker.topConstraint toValue:verticalSpacing];
    }
}
@end
