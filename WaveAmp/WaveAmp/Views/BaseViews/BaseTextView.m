//
//  BaseTextView.m
//  WaveAmp
//
//  Created by Georgi Ivanov on 8/16/15.
//  Copyright (c) 2015 GeorgiIvanov. All rights reserved.
//

#import "BaseTextView.h"

@implementation BaseTextView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
    }
    return self;
}

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
    
    [self centerVerticallyTextViewContent:_centerVertically];
}

-(void)viewControllerDidAppear
{
    if(!_centerVertically)
    {
        [self scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
    }
}

-(void)centerVerticallyTextViewContent:(BOOL)center
{
    if(center)
    {
        CGFloat topoffset = ([self bounds].size.height - [self contentSize].height * [self zoomScale])/2.0;
        topoffset = ( topoffset < 0.0 ? 0.0 : topoffset );
        self.contentOffset = (CGPoint){.x = 0, .y = -topoffset};
    }
}

@end
