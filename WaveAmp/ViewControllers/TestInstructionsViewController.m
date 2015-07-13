//
//  TestInstructionsViewController.m
//  WaveAmp
//
//  Created by Georgi Ivanov on 7/13/15.
//  Copyright (c) 2015 GeorgiIvanov. All rights reserved.
//

#import "TestInstructionsViewController.h"

@interface TestInstructionsViewController()

@property(nonatomic) NSArray* instructionStrings;
@property(nonatomic) NSInteger stringIndex;

@end

@implementation TestInstructionsViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self setupInstructionStrings];
    self.stringIndex = 0;
    [self updateInstructionsLabel];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

-(void)setupInstructionStrings
{
    self.instructionStrings = @[
                                @"• Find yourself a quiet place.\n\n• Plug in your headphones and increase the volume.\n\n•You are going to hear a series of tones, first in one ear and then in the other.\n\n• The test can take up to 10 minutes.",
                                @"• When you hear a tone, no matter how high or low in pitch, and no matter how loud or soft, please signal that you have heard it.\n\n• Hold the corresponding button when you first hear the tone, and keep it held as long as you hear it.\n\n• Remember to signal every time you hear a tone."
                                ];
}

-(void)updateInstructionsLabel
{
    self.instructionsText.text = self.instructionStrings[self.stringIndex];
}

- (IBAction)cancelTap:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)nextButtonTap:(id)sender {
    
    if(self.stringIndex == self.instructionStrings.count - 1)
    {
        [self.delegate userIsReady];
        return;
    }
    
    self.stringIndex++;
    [self updateInstructionsLabel];
    
    if(self.stringIndex == self.instructionStrings.count - 1)
    {
        [self.nextButton setTitle:@"Start Test" forState:UIControlStateNormal];
    }
}
@end
