//
//  AudiogramView.h
//  WaveAmp
//
//  Created by Georgi Ivanov on 7/19/15.
//  Copyright (c) 2015 GeorgiIvanov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AudiogramData.h"

@interface AudiogramView : UIView

-(void)setupView;
-(void)showAudiogram:(AudiogramData*)audiogramData;

@end
