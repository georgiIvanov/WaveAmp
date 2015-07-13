//
//  PopOutAnimation.m
//  GTalkClient
//
//  Created by Georgi Ivanov on 6/13/15.
//  Copyright (c) 2015 GeorgiIvanov. All rights reserved.
//

#import <POP.h>

#import "UIView+PopAnimations.h"

@implementation UIView (PopAnimations)

-(void)addPopOutAnimationDelay:(CGFloat)delay bounciness:(CGFloat)bounciness
{
    POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(1.0, 1.0)];
    scaleAnimation.springBounciness = bounciness;
    scaleAnimation.dynamicsTension = 300.;
    scaleAnimation.completionBlock = ^(POPAnimation* animation, BOOL finished){
        [self layoutIfNeeded];
    };
    
    self.transform = CGAffineTransformMakeScale(0.0001f, 0.0001f);
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.layer pop_addAnimation:scaleAnimation forKey:@"scaleUp"];
    });
}

-(void)addStretchAnimationBounciness:(CGFloat)bounciness velocity:(CGPoint)velocity
{
    POPSpringAnimation *springAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
    springAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(1, 1)];
    springAnimation.velocity = [NSValue valueWithCGPoint:velocity];
    springAnimation.springBounciness = bounciness;
    [self pop_addAnimation:springAnimation forKey:@"springAnimation"];
}
@end
