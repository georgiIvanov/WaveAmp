//
//  AudiogramViewController.h
//  WaveAmp
//
//  Created by Georgi Ivanov on 7/9/15.
//  Copyright (c) 2015 GeorgiIvanov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <HMSegmentedControl.h>

#import "AudiogramData.h"
#import "AudiogramView.h"
#import "DrawerButton.h"

@interface AudiogramViewController : UIViewController

@property(nonatomic) AudiogramData* audiogramData;
@property(nonatomic, copy) void(^audiogramUpdated)(AudiogramData* audiogramData);

@property (weak, nonatomic) IBOutlet UIView *noContentView;
@property (weak, nonatomic) IBOutlet UIButton *hearingTestButton;
@property (weak, nonatomic) IBOutlet UIButton *retakeTestButton;
@property (weak, nonatomic) IBOutlet AudiogramView *audiogramView;
@property (weak, nonatomic) IBOutlet HMSegmentedControl *audiogramPresets;
@property (weak, nonatomic) IBOutlet DrawerButton *drawerButton;


- (IBAction)hearingTestTap:(id)sender;
- (IBAction)segmentedControlChangedValue:(id)sender;

@end
