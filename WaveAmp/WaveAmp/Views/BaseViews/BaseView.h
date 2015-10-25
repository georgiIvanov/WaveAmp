//
//  BaseView.h
//  WaveAmp
//
//  Created by Georgi Ivanov on 10/25/15.
//  Copyright © 2015 GeorgiIvanov. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BaseView <NSObject>

@optional
-(void)viewControllerDidLoad;
-(void)viewControllerDidAppear;

@end
