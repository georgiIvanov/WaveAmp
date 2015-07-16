//
//  AudiogramViewController.h
//  WaveAmp
//
//  Created by Georgi Ivanov on 7/9/15.
//  Copyright (c) 2015 GeorgiIvanov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AudiogramData.h"

@interface AudiogramViewController : UIViewController

@property(nonatomic) AudiogramData* audiogramData;
@property(nonatomic, copy) void(^audiogramUpdated)(AudiogramData* audiogramData);

@property (weak, nonatomic) IBOutlet UIView *noContentView;
@property (weak, nonatomic) IBOutlet UIButton *hearingTestButton;

- (IBAction)hearingTestTap:(id)sender;

@end
