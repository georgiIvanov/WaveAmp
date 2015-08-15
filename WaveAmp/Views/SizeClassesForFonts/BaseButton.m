//
//  BaseButton.m
//  WaveAmp
//
//  Created by Georgi Ivanov on 8/15/15.
//  Copyright © 2015 GeorgiIvanov. All rights reserved.
//

#import "BaseButton.h"

@implementation BaseButton

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
    }
    return self;
}

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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
