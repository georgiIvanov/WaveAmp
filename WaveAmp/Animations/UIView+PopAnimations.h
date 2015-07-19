//
//  PopOutAnimation.h
//  GTalkClient
//
//  Created by Georgi Ivanov on 6/13/15.
//  Copyright (c) 2015 GeorgiIvanov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIView.h>

@interface UIView (PopAnimations)

-(void)addPopOutAnimationDelay:(CGFloat)delay bounciness:(CGFloat)bounciness;
-(void)addStretchAnimationBounciness:(CGFloat)bounciness velocity:(CGPoint)velocity;
-(void)animateConstraint:(NSLayoutConstraint*)constraint toValue:(CGFloat)constant;

@end
