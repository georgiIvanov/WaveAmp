//
//  AudiogramViewController.m
//  WaveAmp
//
//  Created by Georgi Ivanov on 7/9/15.
//  Copyright (c) 2015 GeorgiIvanov. All rights reserved.
//

#import "AudiogramViewController.h"
#import "PureToneAudiometer.h"
#import "UIView+PopAnimations.h"

@interface AudiogramViewController()

@end

@implementation AudiogramViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self setupGestures];
    self.audiogramData = [[NSUserDefaults standardUserDefaults] objectForKey:kAudiogramKey];
}

-(void)setupContentViews
{
    if(self.audiogramData == nil)
    {
        self.noContentView.hidden = NO;
        [self.hearingTestButton addPopOutAnimationDelay:0.3f bounciness:10];
    }
}

-(void)setupGestures
{
    // !!!: gesture for setting some of the audiogramdata presets
    UILongPressGestureRecognizer* longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressWithThreeFingersAction:)];
#if TARGET_IPHONE_SIMULATOR
    longPress.numberOfTouchesRequired = 2;
#else
    longPress.numberOfTouchesRequired = 3;
#endif
    [self.view addGestureRecognizer:longPress];
}

-(void)longPressWithThreeFingersAction:(UILongPressGestureRecognizer*)sender
{
    if(sender.state == UIGestureRecognizerStateBegan)
    {
        [self displayAudiogramPresets];
    }
}

-(void)setAudiogramData:(AudiogramData *)audiogramData
{
    _audiogramData = audiogramData;
    [self setupContentViews];
    if(self.audiogramUpdated)
    {
        self.audiogramUpdated(audiogramData);
    }
}

-(void)displayAudiogramPresets
{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Audiogram Data"
                                                                   message:@"Load a preset audiogram."
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction* alertAction;
    
    
    AudiogramData* ad = [[NSUserDefaults standardUserDefaults] objectForKey:kAudiogramKey];
    if(ad)
    {
        alertAction = [UIAlertAction actionWithTitle:@"Original" style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction * action) {
                                                           self.audiogramData = [[NSUserDefaults standardUserDefaults] objectForKey:kAudiogramKey];
                                                       }];
        [alert addAction:alertAction];
    }
    
    alertAction = [UIAlertAction actionWithTitle:@"Normal Loss" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                              self.audiogramData = [AudiogramData audiogramNormalLoss];
                                                          }];
    [alert addAction:alertAction];
    
    alertAction = [UIAlertAction actionWithTitle:@"Mild Loss" style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * action) {
                                                       self.audiogramData = [AudiogramData audiogramMildLoss];
                                                   }];
    
    [alert addAction:alertAction];
    
    alertAction = [UIAlertAction actionWithTitle:@"Severe Loss" style:UIAlertActionStyleDefault
                                         handler:^(UIAlertAction * action) {
                                             self.audiogramData = [AudiogramData audiogramSevereLoss];
                                         }];
    
    [alert addAction:alertAction];
    
    if (alert.popoverPresentationController) {
        alert.popoverPresentationController.sourceView = self.noContentView;
        CGRect srcRect = CGRectMake(self.noContentView.frame.origin.x, self.noContentView.frame.origin.y, self.noContentView.frame.size.width, self.noContentView.frame.size.height * 0.6);
        alert.popoverPresentationController.sourceRect = srcRect;
    }
    
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - UI Actions

- (IBAction)hearingTestTap:(id)sender
{
    [self performSegueWithIdentifier:@"AbsThresholdSegue" sender:self];
}
@end
