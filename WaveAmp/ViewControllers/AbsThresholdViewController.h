//
//  AbsThresholdViewController.h
//  WaveAmp
//
//  Created by Georgi Ivanov on 7/9/15.
//  Copyright (c) 2015 GeorgiIvanov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AbsThresholdViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *testNumberLabel;
@property (weak, nonatomic) IBOutlet UIButton *leftButton;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;

- (IBAction)buttonHeld:(UIButton *)sender;
- (IBAction)buttonReleased:(UIButton *)sender;

@end
