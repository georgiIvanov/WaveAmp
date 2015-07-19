//
//  AudiogramView.h
//  WaveAmp
//
//  Created by Georgi Ivanov on 7/19/15.
//  Copyright (c) 2015 GeorgiIvanov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AudiogramData.h"
#import "AudiogramMarkerView.h"

@interface AudiogramView : UIView

@property (strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray* dBVerticalConstraints;
@property (strong, nonatomic) IBOutletCollection(AudiogramMarkerView) NSArray* leftMarkers;
@property (strong, nonatomic) IBOutletCollection(AudiogramMarkerView) NSArray* rightMarkers;

-(void)setupView;
-(void)showAudiogram:(AudiogramData*)audiogramData;

@end
