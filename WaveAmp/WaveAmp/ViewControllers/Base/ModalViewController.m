//
//  ModalViewController.m
//  WaveAmp
//
//  Created by Georgi Ivanov on 10/25/15.
//  Copyright © 2015 GeorgiIvanov. All rights reserved.
//

#import "ModalViewController.h"
#import "BaseView.h"

@implementation ModalViewController

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    for (id<BaseView> baseView in self.childViews)
    {
        if([baseView respondsToSelector:@selector(viewControllerDidAppear)])
        {
            [baseView viewControllerDidAppear];
        }
    }
}

- (IBAction)dismissButtonTap:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
