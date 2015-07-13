//
//  TestInstructionsViewController.m
//  WaveAmp
//
//  Created by Georgi Ivanov on 7/13/15.
//  Copyright (c) 2015 GeorgiIvanov. All rights reserved.
//

#import "TestInstructionsViewController.h"

@implementation TestInstructionsViewController

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (IBAction)cancelTap:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
