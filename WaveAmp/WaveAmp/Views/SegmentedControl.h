//
//  SegmentedControl.h
//  WaveAmp
//
//  Created by Georgi Ivanov on 8/16/15.
//  Copyright (c) 2015 GeorgiIvanov. All rights reserved.
//

#import "HMSegmentedControl.h"

@interface SegmentedControl : HMSegmentedControl

@property(nonatomic) IBInspectable float fontSize;
@property(nonatomic) IBInspectable float fontSizePad;
@property(nonatomic) IBInspectable NSString* fontName;
@property(nonatomic) IBInspectable UIColor* fontColor;

@property(nonatomic) IBInspectable BOOL verticalDivider;
@property(nonatomic) IBInspectable float vDividerWidth;
@property(nonatomic) IBInspectable UIColor* vDividerColor;

@property(nonatomic) IBInspectable UIColor* selectionColor;
@property(nonatomic) IBInspectable UIColor* background;

-(void)viewControllerDidLoad;

@end
