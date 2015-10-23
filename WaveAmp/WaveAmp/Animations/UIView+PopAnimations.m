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

-(void)animateConstraint:(NSLayoutConstraint*)constraint toValue:(CGFloat)constant
{
    POPSpringAnimation *layoutAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayoutConstraintConstant];
    layoutAnimation.velocity = [NSValue valueWithCGPoint:CGPointMake(0, 1)];
    layoutAnimation.springBounciness = 20;
    layoutAnimation.springSpeed = 5;
    layoutAnimation.dynamicsMass = 0.1;
    layoutAnimation.dynamicsFriction = 0.1;
    layoutAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(constant, 0)];
    [constraint pop_addAnimation:layoutAnimation forKey:@"constraintAnimation"];
    
}

-(void)spinViewWithRotations:(CGFloat)rotations bounciness:(CGFloat)bounciness speed:(CGFloat)speed onCompleted:(OnCompletedAnimation)onCompleted
{
    POPSpringAnimation* spinAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerRotation];
    spinAnimation.springBounciness = bounciness;
    spinAnimation.springSpeed = speed;
    spinAnimation.toValue = @(M_PI * rotations);
    
    if(onCompleted)
    {
        OnCompletedAnimation block = (__bridge OnCompletedAnimation)Block_copy((__bridge void *)onCompleted);
        spinAnimation.completionBlock = ^(POPAnimation* animation, BOOL finished){
            block(finished);
            Block_release((__bridge void *)block);
        };
    }
    
    [self.layer pop_addAnimation:spinAnimation forKey:@"spinAnimation"];
    
}
@end
