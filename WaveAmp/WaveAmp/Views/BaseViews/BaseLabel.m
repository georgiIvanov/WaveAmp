//
//  BaseLabel.m
//  WaveAmp
//
//  Created by Georgi Ivanov on 8/15/15.
//  Copyright (c) 2015 GeorgiIvanov. All rights reserved.
//

#import "BaseLabel.h"

@implementation BaseLabel

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    if(self.fontName.length > 0)
    {
        UIFont* font = [UIFont fontWithName:self.fontName size:self.font.pointSize];
        
        // Font name set through interface builder is not correct
        assert(font != nil);
        
        if([self.font isEqual:font] == NO && font != nil)
        {
            [self setFont:font];
        }
    }
}

@end
