//
//  RoundedButton.m
//  WaveAmp
//
//  Created by Georgi Ivanov on 8/15/15.
//  Copyright (c) 2015 GeorgiIvanov. All rights reserved.
//

#import "RoundedButton.h"

@implementation RoundedButton

-(void)setRoundedness:(float)roundedness
{
    float longerSide = MAX(self.frame.size.width, self.frame.size.height);
    float shorterSide = MIN(self.frame.size.width, self.frame.size.height);
    float cornerRadius = (longerSide / shorterSide) * roundedness;
    self.layer.cornerRadius = cornerRadius;
}

@end
