//
//  BaseButton.m
//  WaveAmp
//
//  Created by Georgi Ivanov on 8/15/15.
//  Copyright © 2015 GeorgiIvanov. All rights reserved.
//

#import "BaseButton.h"

@implementation BaseButton

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    if(self.fontName.length > 0)
    {
        UIFont* font = [UIFont fontWithName:self.fontName size:self.titleLabel.font.pointSize];
        
        // Font name set through interface builder is not correct
        assert(font != nil);
        
        if([self.titleLabel.font isEqual:font] == NO && font != nil)
        {
            [self.titleLabel setFont:font];
        }
    }
}

-(void)setHidden:(BOOL)hidden
{
    for (UIView* view in self.outerElements)
    {
        view.hidden = hidden;
    }
    super.hidden = hidden;
}

-(void)setAlpha:(CGFloat)alpha
{
    for (UIView* view in self.outerElements)
    {
        view.alpha = alpha;
    }
    super.alpha = alpha;
}

-(void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    
    float alpha = highlighted ? 0.18f : 1.0f;
    float duration = highlighted ? 0.04f : 0.3f;
    for (UIView* view in self.outerElements)
    {
        [UIView animateWithDuration:duration animations:^{
            view.alpha = alpha;
        }];
    }
}

@end
