//
//  SpinningButton.m
//  WaveAmp
//
//  Created by Georgi Ivanov on 10/23/15.
//  Copyright © 2015 GeorgiIvanov. All rights reserved.
//

#import "SpinningButton.h"
#import "UIView+PopAnimations.h"

@implementation SpinningButton

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self addTarget:self action:@selector(spinButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

-(void)spinButton
{
    self.userInteractionEnabled = NO;
    [self spinViewWithRotations:1 bounciness:3 speed:5 onCompleted:^(BOOL finished) {
        self.userInteractionEnabled = YES;
    }];
}

@end
