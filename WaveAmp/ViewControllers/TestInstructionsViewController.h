//
//  TestInstructionsViewController.h
//  WaveAmp
//
//  Created by Georgi Ivanov on 7/13/15.
//  Copyright (c) 2015 GeorgiIvanov. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TestInstructionsDelegate <NSObject>

-(void)userIsReady;

@end

@interface TestInstructionsViewController : UIViewController

@property(nonatomic, weak) id<TestInstructionsDelegate> delegate;

- (IBAction)cancelTap:(id)sender;

@end
