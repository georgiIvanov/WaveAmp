//
//  BaseButton.h
//  WaveAmp
//
//  Created by Georgi Ivanov on 8/15/15.
//  Copyright © 2015 GeorgiIvanov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseButton : UIButton

@property(nonatomic) IBInspectable NSString* fontName;
@property(nonatomic) IBOutletCollection(UIView) NSArray* outerElements;

@end
