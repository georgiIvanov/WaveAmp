//
//  AbsThresholdViewController.m
//  WaveAmp
//
//  Created by Georgi Ivanov on 7/9/15.
//  Copyright (c) 2015 GeorgiIvanov. All rights reserved.
//

#import "AbsThresholdViewController.h"

#import "HearingExamSoundMeter.h"
#import "PureToneAudiometer.h"
#import "PureTonePlayer.h"
#import "TestInstructionsViewController.h"
#import "CommonAnimations.h"

@interface AbsThresholdViewController() <ToneAudiometerDelegate, TestInstructionsDelegate>

@property(nonatomic) PureTonePlayer* pureTonePlayer;
@property(nonatomic) PureToneAudiometer* hearingExam;

@end

@implementation AbsThresholdViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.pureTonePlayer = [[PureTonePlayer alloc] init];
    
    self.hearingExam = [[PureToneAudiometer alloc] initWithExamOptions:kShortExam];
    self.hearingExam.delegate = self;
    self.hearingExam.playerDelegate = self.pureTonePlayer;
    
    [self setupViewsForInstructions];
    self.testNumberLabel.text = @"Starting soon";
    self.stopTestButton.hidden = YES;
}

-(void)setupViewsForInstructions
{
    for (UIView* v in self.testUI) {
        v.hidden = YES;
    }
    
    self.instructionsContainer.hidden = NO;
}

-(void)prepareViewsForStartingTests
{
    for (UIView* v in self.testUI) {
        v.hidden = NO;
        v.alpha = 0;
        [UIView animateWithDuration:0.2f animations:^{
            v.alpha = 1;
        }];
    }
    
    [UIView animateWithDuration:0.2f animations:^{
        self.instructionsContainer.alpha = 0;
    } completion:^(BOOL finished) {
        self.instructionsContainer.hidden = YES;
    }];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"instructionsSegue"])
    {
        TestInstructionsViewController* vc = (TestInstructionsViewController*)segue.destinationViewController;
        vc.delegate = self;
    }
}

-(void)startExam
{
    // TODO: use sound meter to measure output volume
//    HearingExamSoundMeter* soundMeter = [[HearingExamSoundMeter alloc] init];
    
    self.stopTestButton.hidden = NO;
    
    [self.hearingExam start];
    [self.pureTonePlayer play];
}

#pragma mark - ToneAudiometerDelegate

-(void)startingTest:(int)number
{
    [CommonAnimations animate:self.testNumberLabel
                  withNewText:[NSString stringWithFormat:@"%d of %lu", number, (unsigned long)self.hearingExam.frequencies.count]
                     duration:0.2f
              completionBlock:nil];
}

-(void)testsAreOver:(AudiogramData *)audiogramData
{
    self.testNumberLabel.text = @"Well done!";
    
    [self.pureTonePlayer pause];
    [audiogramData saveAudiogram];
    [self.delegate examIsSuccessfullyCompleted];
    self.leftButton.enabled = NO;
    self.rightButton.enabled = NO;
    // TODO: redirect user with UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self dismissViewControllerAnimated:YES completion:nil];
    });
}

#pragma mark - TestInstructionsDelegate

-(void)userIsReady
{
    [self prepareViewsForStartingTests];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self startExam];
    });
}

#pragma mark - UI Actions

- (IBAction)buttonHeld:(UIButton *)sender {
    [self.hearingExam buttonHeldForChannel:(int)sender.tag];
}

- (IBAction)buttonReleased:(UIButton *)sender {
    [self.hearingExam buttonReleasedForChannel:(int)sender.tag];
}

- (IBAction)stopTestTap:(id)sender {
    [self.pureTonePlayer pause];
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
