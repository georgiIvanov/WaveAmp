//
//  PlaybackButton.m
//  WaveAmp
//
//  Created by Georgi Ivanov on 7/15/15.
//  Copyright (c) 2015 GeorgiIvanov. All rights reserved.
//

#import "PlaybackButton.h"
#import "CommonAnimations.h"

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
    
    [CommonAnimations animate:self
                 withNewImage:imageName
                      options:UIViewAnimationOptionTransitionCrossDissolve
                     duration:0.12f];
}

@end
