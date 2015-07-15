//
//  PlaybackButton.m
//  WaveAmp
//
//  Created by Georgi Ivanov on 7/15/15.
//  Copyright (c) 2015 GeorgiIvanov. All rights reserved.
//

#import "PlaybackButton.h"

@implementation PlaybackButton

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        _playing = NO;
        [self addTarget:self action:@selector(togglePlayState) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}


-(void)togglePlayState
{
    _playing = !_playing;
    
    NSString* imageName;
    if(_playing)
    {
        imageName = @"Pause";
    }
    else
    {
        imageName = @"Play";
    }
    
    [UIView transitionWithView:self
                      duration:0.12
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        [self setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
                    } completion:nil];
}

@end
