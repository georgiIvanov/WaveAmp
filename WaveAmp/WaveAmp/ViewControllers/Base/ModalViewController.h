//
//  ModalViewController.h
//  WaveAmp
//
//  Created by Georgi Ivanov on 10/25/15.
//  Copyright © 2015 GeorgiIvanov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseView.h"

@interface ModalViewController : UIViewController

@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *childViews;

- (IBAction)dismissButtonTap:(id)sender;
@end
