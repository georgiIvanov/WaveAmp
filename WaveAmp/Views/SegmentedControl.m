//
//  SegmentedControl.m
//  WaveAmp
//
//  Created by Georgi Ivanov on 8/16/15.
//  Copyright (c) 2015 GeorgiIvanov. All rights reserved.
//

#import "SegmentedControl.h"

@interface SegmentedControl()

@property(nonatomic) UIFont* font;
@property(nonatomic) CGFloat titleFontSize;
@property(nonatomic) NSString* titleFontName;
@property(nonatomic) NSMutableDictionary* titleAttribues;

@end

@implementation SegmentedControl
{
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        _titleAttribues = [[NSMutableDictionary alloc] init];
        _titleFontSize = 0;
        _fontSize = 0;
        _fontSizePad = 0;
        _verticalDivider = NO;
        _selectionColor = nil;
        _titleFontName = nil;
        
        
        __weak typeof(self) wself = self;
        [self setTitleFormatter:^NSAttributedString *(HMSegmentedControl *segmentedControl, NSString *title, NSUInteger index, BOOL selected) {
            NSAttributedString *attString = [[NSAttributedString alloc] initWithString:title attributes:wself.titleAttribues];
            return attString;
        }];
    }
    return self;
}

-(void)viewControllerDidLoad
{
    if(_verticalDivider)
    {
        self.verticalDividerEnabled = _verticalDivider;
        self.verticalDividerColor = _vDividerColor;
        self.verticalDividerWidth = _vDividerWidth;
    }
    
    if(_selectionColor)
    {
        self.selectionIndicatorColor = _selectionColor;
    }
    
    if(_background)
    {
        self.backgroundColor = _background;
    }
    
    self.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    self.selectionStyle = HMSegmentedControlSelectionStyleBox;
}

-(void)setFontSize:(float)fontSize
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        self.titleFontSize = fontSize;
    }
}

-(void)setFontSizePad:(float)fontSizePad
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        self.titleFontSize = fontSizePad;
    }
}

-(void)setFontName:(NSString *)fontName
{
    _titleFontName = fontName;
    if(self.titleFontSize > 0)
    {
        self.font = [UIFont fontWithName:fontName size:self.titleFontSize];
        [self.titleAttribues setObject:self.font forKey:NSFontAttributeName];
    }
}

-(NSString *)fontName
{
    return [self.titleTextAttributes objectForKey:NSFontAttributeName];
}

-(void)setFontColor:(UIColor *)fontColor
{
    [self.titleAttribues setObject:fontColor forKey:NSForegroundColorAttributeName];
    
}

-(UIColor *)fontColor
{
    return [self.titleAttribues objectForKey:NSForegroundColorAttributeName];
}

-(void)setSelectionColor:(UIColor *)selectionColor
{
    _selectionColor = selectionColor;
}

-(void)setVerticalDivider:(BOOL)verticalDivider
{
    _verticalDivider = verticalDivider;
}

-(void)setVDividerColor:(UIColor *)vDividerColor
{
    _vDividerColor = vDividerColor;
}

-(void)setVDividerWidth:(float)vDividerWidth
{
    _vDividerWidth = vDividerWidth;
}

-(void)setBackground:(UIColor *)background
{
    _background = background;
}

-(void)setTitleFontSize:(CGFloat)titleFontSize
{
    _titleFontSize = titleFontSize;
    if(self.font.pointSize == 0)
    {
        [self setFontName:_titleFontName];
    }
}

@end
