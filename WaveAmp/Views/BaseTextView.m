//
//  BaseTextView.m
//  WaveAmp
//
//  Created by Georgi Ivanov on 8/16/15.
//  Copyright (c) 2015 GeorgiIvanov. All rights reserved.
//

#import "BaseTextView.h"

NSString* const ContentSizePath = @"contentSize";

@implementation BaseTextView

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
        UIFont* font = [UIFont fontWithName:self.fontName size:self.font.pointSize];
        
        // Font name set through interface builder is not correct
        assert(font != nil);
        
        if([self.font isEqual:font] == NO && font != nil)
        {
            [self setFont:font];
        }
    }
}

-(void)centerVerticallyTextViewContent:(BOOL)center
{
    if(center)
    {
        CGFloat topoffset = ([self bounds].size.height - [self contentSize].height * [self zoomScale])/2.0;
        topoffset = ( topoffset < 0.0 ? 0.0 : topoffset );
        self.contentOffset = (CGPoint){.x = 0, .y = -topoffset};
    }
    else
    {
        self.contentOffset = CGPointZero;
    }
}

-(void)setCenterVertically:(BOOL)centerVertically
{
    if(centerVertically && _centerVertically == NO)
    {
        [self addObserver:self forKeyPath:ContentSizePath options:(NSKeyValueObservingOptionNew) context:NULL];
    }
    else if(_centerVertically == YES)
    {
        @try {
            [self removeObserver:self forKeyPath:ContentSizePath];
        }
        @catch (NSException * __unused exception) {}
        @finally{
            [self centerVerticallyTextViewContent:NO];
        }
    }
    
    _centerVertically = centerVertically;
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if([keyPath isEqualToString:ContentSizePath])
    {
        [self centerVerticallyTextViewContent:YES];
    }
}

-(void)dealloc
{
    @try {
        [self removeObserver:self forKeyPath:ContentSizePath];
    }
    @catch (NSException * __unused exception) {}
}

@end
