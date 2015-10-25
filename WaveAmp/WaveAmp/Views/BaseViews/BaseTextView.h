//
//  BaseTextView.h
//  WaveAmp
//
//  Created by Georgi Ivanov on 8/16/15.
//  Copyright (c) 2015 GeorgiIvanov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseView.h"

@interface BaseTextView : UITextView <BaseView>

@property(nonatomic) IBInspectable NSString* fontName;
@property(nonatomic) IBInspectable BOOL centerVertically;

@end
