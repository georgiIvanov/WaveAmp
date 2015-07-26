//
//  AbsThresholdViewController.h
//  WaveAmp
//
//  Created by Georgi Ivanov on 7/9/15.
//  Copyright (c) 2015 GeorgiIvanov. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ThresholdExamDelegate <NSObject>

-(void)examIsSuccessfullyCompleted;

@end

@interface AbsThresholdViewController : UIViewController

@property(nonatomic, weak) id<ThresholdExamDelegate> delegate;

@property (weak, nonatomic) IBOutlet UILabel *testNumberLabel;
@property (weak, nonatomic) IBOutlet UIButton *leftButton;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;
@property (weak, nonatomic) IBOutlet UIButton *stopTestButton;

@property (weak, nonatomic) IBOutlet UIView *instructionsContainer;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *testUI;

- (IBAction)buttonHeld:(UIButton *)sender;
- (IBAction)buttonReleased:(UIButton *)sender;
- (IBAction)stopTestTap:(id)sender;

@end
