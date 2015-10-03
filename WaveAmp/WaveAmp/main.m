//
//  main.m
//  WaveAmp
//
//  Created by Georgi Ivanov on 7/9/15.
//  Copyright (c) 2015 GeorgiIvanov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    int returnValue;
    
    @autoreleasepool {
        
#ifdef DEBUG
        BOOL inTests = NSClassFromString(@"XCTest") != nil;
        
        if (inTests) {
            //use a special empty delegate when we are inside the tests
            returnValue = UIApplicationMain(argc, argv, nil, @"TestsAppDelegate");
        }
        else {
            //use the normal delegate
            returnValue = UIApplicationMain(argc, argv, nil, @"AppDelegate");
        }
#endif
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
    
    return returnValue;
}
