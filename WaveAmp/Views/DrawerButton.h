//
//  DrawerButton.h
//  WaveAmp
//
//  Created by Georgi Ivanov on 7/27/15.
//  Copyright (c) 2015 GeorgiIvanov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawerButton : UIButton

@property (strong, nonatomic) IBOutlet NSLayoutConstraint* drawerConstraint;
@property(nonatomic, readonly) BOOL isOpen;

-(void)setupButton:(UIView*)view;
-(void)closeView;

@end
