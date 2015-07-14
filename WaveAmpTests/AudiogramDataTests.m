//
//  AudiogramDataTests.m
//  WaveAmp
//
//  Created by Georgi Ivanov on 7/12/15.
//  Copyright (c) 2015 GeorgiIvanov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "AudiogramData.h"
#import "FrequencyThreshold.h"

@interface AudiogramDataTests : XCTestCase

@end

@implementation AudiogramDataTests

-(void)testCorrectInitialization
{
    AudiogramData* ad = [AudiogramData audiogramNormalLoss];
    NSNumber* previousNumber = nil;
    
    for (FrequencyThreshold* ft in ad.leftEar)
    {
        XCTAssertEqual([ft.channel integerValue], 0);
        if(previousNumber != nil)
        {
            XCTAssertGreaterThan([ft.frequency integerValue], [previousNumber integerValue]);
        }
        previousNumber = ft.frequency;
    }
    
    previousNumber = nil;
    for (FrequencyThreshold* ft in ad.rightEar)
    {
        XCTAssertEqual([ft.channel integerValue], 1);
        if(previousNumber != nil)
        {
            XCTAssertGreaterThan([ft.frequency integerValue], [previousNumber integerValue]);
        }
        previousNumber = ft.frequency;
    }
}

@end
