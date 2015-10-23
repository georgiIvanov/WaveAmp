//
//  DrawerButton.m
//  WaveAmp
//
//  Created by Georgi Ivanov on 7/27/15.
//  Copyright (c) 2015 GeorgiIvanov. All rights reserved.
//

#import "DrawerButton.h"

@interface DrawerButton()

@property(nonatomic) CGFloat originalConstraint;
@property(nonatomic, weak) UIView* controlledView;

@end

@implementation DrawerButton

-(void)setupButton:(UIView*)view
{
    self.originalConstraint = self.drawerConstraint.constant;
    self.drawerConstraint.constant = 0;
    self.controlledView = view;
    
    [self addTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)buttonTap:(DrawerButton*)sender
{
    [self animateChanges:^{
        if(self.drawerConstraint.constant)
        {
            self.drawerConstraint.constant = 0;
            [self rotateImage:NO];
        }
        else
        {
            self.drawerConstraint.constant = self.originalConstraint;
            [self rotateImage:YES];
        }
        
        [self.controlledView layoutIfNeeded];
        [self layoutIfNeeded];
    }];
}

-(void)closeView
{
    if(self.isOpen == YES)
    {
        [self animateChanges:^{
            self.drawerConstraint.constant = 0;
            [self.controlledView layoutIfNeeded];
            [self layoutIfNeeded];
        }];
    }
}

-(void)animateChanges:(void(^)())changesBlock
{
    [UIView animateWithDuration:0.5
                          delay:0
         usingSpringWithDamping:0.6
          initialSpringVelocity:1
                        options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         changesBlock();
                     } completion:nil];
}

-(BOOL)isOpen
{
    return self.drawerConstraint.constant != 0;
}

-(void)rotateImage:(BOOL)isDown
{
    int direction = isDown ? -1 : 1;
    CGFloat radians = atan2f(self.imageView.transform.b, self.imageView.transform.a);
    CGFloat degrees = radians * (180 / M_PI) * direction;
    CGAffineTransform transform = CGAffineTransformMakeRotation(( 180 + degrees) * M_PI/180);
    self.imageView.transform = transform;
}

@end
