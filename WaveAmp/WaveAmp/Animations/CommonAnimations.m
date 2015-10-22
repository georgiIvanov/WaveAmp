//
//  UILabel+TextAnimations.m
//  WaveAmp
//
//  Created by Georgi Ivanov on 7/13/15.
//  Copyright (c) 2015 GeorgiIvanov. All rights reserved.
//

#import "CommonAnimations.h"

@implementation CommonAnimations

+(void)animate:(UILabel*)label withNewText:(NSString*)newText duration:(float)duration completionBlock:(void (^)(BOOL finished))completion
{
    [UIView transitionWithView:label
                      duration:duration
                       options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        label.text = newText;
                    }
                    completion:completion];
}

+(void)animate:(UIButton*)button withNewImage:(NSString*)imageName options:(UIViewAnimationOptions)options duration:(float)duration
{
    [UIView transitionWithView:button
                      duration:duration
                       options:options
                    animations:^{
                        [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
                    } completion:nil];
}

@end
