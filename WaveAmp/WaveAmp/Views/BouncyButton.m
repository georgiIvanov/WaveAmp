//
//  RoundedButton.m
//  TestYL
//
//  Created by Georgi Ivanov on 7/5/14.
//  Copyright (c) 2014 YL. All rights reserved.
//

#import "BouncyButton.h"
#import <POP.h>

@interface BouncyButton()

@property(nonatomic, assign) CGFloat touchDownXScale;
@property(nonatomic, assign) CGFloat touchDownYScale;
@property(nonatomic, assign) CGFloat touchUpXScale;
@property(nonatomic, assign) CGFloat touchUpYScale;

@end

@implementation BouncyButton

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

-(instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

-(void)setScalingTouchDownX:(CGFloat)xDown downY:(CGFloat)yDown touchUpX:(CGFloat)xUp upY:(CGFloat)yUp
{
    _touchDownXScale = xDown;
    _touchDownYScale = yDown;
    _touchUpXScale = xUp;
    _touchUpYScale = yUp;
}

-(void)setScalingTouchDown:(CGFloat)down touchUp:(CGFloat)up
{
    _touchDownXScale = down;
    _touchDownYScale = down;
    _touchUpXScale = up;
    _touchUpYScale = up;
}

- (void)setup
{
    [self setScalingTouchDown:1.2 touchUp:1];
    
    [self addTarget:self action:@selector(animationOnTouch)
   forControlEvents:UIControlEventTouchDown | UIControlEventTouchDragEnter];
    [self addTarget:self action:@selector(animationOnTouchUp)
   forControlEvents:UIControlEventTouchUpInside];
    [self addTarget:self action:@selector(animationOnCancelTouch)
   forControlEvents:UIControlEventTouchDragExit | UIControlEventTouchCancel];
}

- (void)animationOnTouch
{
    if(self.bounce == NO)
    {
        return;
    }
    
    [self.layer pop_removeAllAnimations];
    POPBasicAnimation *scaleAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(
                                                                 _touchDownXScale ? _touchDownXScale : 0.93f,
                                                                 _touchDownYScale ? _touchDownYScale : 0.95f
                                                                 )];
    scaleAnimation.duration = 0.1f;
    
    [self applyAnimation:scaleAnimation withName:@"layerScaleSmallAnimation"];
}

- (void)animationOnTouchUp
{
    if(self.bounce == NO)
    {
        return;
    }
    
    [self.layer pop_removeAllAnimations];
    POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnimation.velocity = [NSValue valueWithCGSize:CGSizeMake(3.f, 3.f)];
    scaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(
                                                                 _touchUpXScale ? _touchUpXScale : 1.f,
                                                                 _touchUpYScale ? _touchUpYScale : 1.f
                                                                 )];
    scaleAnimation.springBounciness = 8.0f;
    scaleAnimation.springSpeed = 15;
    
    [self applyAnimation:scaleAnimation withName:@"layerScaleSpringAnimation"];
}

- (void)animationOnCancelTouch
{
    if(self.bounce == NO)
    {
        return;
    }
    
    POPBasicAnimation *scaleAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(1.f, 1.f)];
    
    [self applyAnimation:scaleAnimation withName:@"layerScaleDefaultAnimation"];
}

-(void)applyAnimation:(POPAnimation*)animation withName:(NSString*)name
{
    [self.layer pop_addAnimation:animation forKey:name];
    
    for (UIView* view in self.outerElements) {
        [view.layer pop_addAnimation:animation forKey:name];
    }
}

@end
