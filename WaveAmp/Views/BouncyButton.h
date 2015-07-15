//
//  RoundedButton.h
//  TestYL
//
//  Created by Georgi Ivanov on 7/5/14.
//  Copyright (c) 2014 YL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BouncyButton : UIButton

-(void)setScalingTouchDownX:(CGFloat)xDown downY:(CGFloat)yDown touchUpX:(CGFloat)xUp upY:(CGFloat)yUp;
-(void)setScalingTouchDown:(CGFloat)down touchUp:(CGFloat)up;

@end
