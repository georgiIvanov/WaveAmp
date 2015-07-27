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
#import "FrequencyThreshold.h"
#import "AbsThresholdViewController.h"

@interface AudiogramViewController() <ThresholdExamDelegate>

@end

@implementation AudiogramViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self setupGestures];
    [self.audiogramView setupView];
    self.audiogramData = [AudiogramData loadAudiogram];
    
    self.audiogramPresets.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    [self setupSegmentedControlTitles:(self.audiogramData != nil)];
    [self.drawerButton setupButton:self.audiogramPresets];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.drawerButton closeView];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.drawerButton closeView];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.drawerButton closeView];
}

-(void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        [self.drawerButton closeView];
    } completion:nil];
}

-(void)setupContentViews
{
    if(self.audiogramData == nil)
    {
        self.noContentView.hidden = NO;
        self.audiogramView.hidden = YES;
        self.retakeTestButton.hidden = YES;
        [self.hearingTestButton addPopOutAnimationDelay:0.3f bounciness:10];
    }
    else
    {
        self.noContentView.hidden = YES;
        self.audiogramView.hidden = NO;
        self.retakeTestButton.hidden = NO;
        [self.audiogramView showAudiogram:self.audiogramData];
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

-(void)setupSegmentedControlTitles:(BOOL)hasSavedAudiogram
{
    NSString* first = hasSavedAudiogram ? @"Saved" : @"None";
    NSArray* titles = @[first, @"Normal", @"Mild", @"Severe"];
    [self.audiogramPresets setSectionTitles:titles];
}

-(void)setAudiogramData:(AudiogramData *)audiogramData
{
    _audiogramData = audiogramData;
    [self setupContentViews];
    if(self.audiogramUpdated)
    {
        self.audiogramUpdated(audiogramData);
    }
    [self.audiogramView layoutSubviews];
}

-(void)examIsSuccessfullyCompleted
{
    self.audiogramData = [AudiogramData loadAudiogram];
    [self setupSegmentedControlTitles:(self.audiogramData != nil)];
}

-(void)displayAudiogramPresets
{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Audiogram Data"
                                                                   message:@"Load a preset audiogram."
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction* alertAction;
    
    
    AudiogramData* ad = [AudiogramData loadAudiogram];
    if(ad)
    {
        alertAction = [UIAlertAction actionWithTitle:@"Original" style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction * action) {
                                                           self.audiogramData = [AudiogramData loadAudiogram];
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

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"AbsThresholdSegue"])
    {
        AbsThresholdViewController* vc = (AbsThresholdViewController*)segue.destinationViewController;
        vc.delegate = self;
    }
}

#pragma mark - UI Actions

- (IBAction)hearingTestTap:(id)sender
{
    [self performSegueWithIdentifier:@"AbsThresholdSegue" sender:self];
}

- (IBAction)segmentedControlChangedValue:(HMSegmentedControl*)sender
{
    
}
@end
