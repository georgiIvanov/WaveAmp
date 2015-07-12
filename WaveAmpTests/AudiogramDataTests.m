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
    AudiogramData* ad = [[AudiogramData alloc] initWithThresholds:[self thresholds]];
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

-(NSArray*)thresholds
{
//    @[@(1000), @(2000), @(3000), @(4000), @(6000), @(8000), @(1000), @(500), @(250)];
    NSMutableArray* thresholds = [NSMutableArray new];
    
    [thresholds addObject:[FrequencyThreshold thresholdDb:20 frequency:1000 channel:0]];
    [thresholds addObject:[FrequencyThreshold thresholdDb:20 frequency:1000 channel:1]];
    
    [thresholds addObject:[FrequencyThreshold thresholdDb:20 frequency:2000 channel:1]];
    [thresholds addObject:[FrequencyThreshold thresholdDb:20 frequency:2000 channel:0]];
    
    [thresholds addObject:[FrequencyThreshold thresholdDb:20 frequency:3000 channel:0]];
    [thresholds addObject:[FrequencyThreshold thresholdDb:20 frequency:3000 channel:1]];
    
    [thresholds addObject:[FrequencyThreshold thresholdDb:20 frequency:4000 channel:0]];
    [thresholds addObject:[FrequencyThreshold thresholdDb:20 frequency:4000 channel:1]];
    
    [thresholds addObject:[FrequencyThreshold thresholdDb:20 frequency:6000 channel:1]];
    [thresholds addObject:[FrequencyThreshold thresholdDb:20 frequency:6000 channel:0]];
    
    [thresholds addObject:[FrequencyThreshold thresholdDb:20 frequency:8000 channel:1]];
    [thresholds addObject:[FrequencyThreshold thresholdDb:20 frequency:8000 channel:0]];
    
    [thresholds addObject:[FrequencyThreshold thresholdDb:20 frequency:500 channel:0]];
    [thresholds addObject:[FrequencyThreshold thresholdDb:20 frequency:500 channel:1]];
    
    [thresholds addObject:[FrequencyThreshold thresholdDb:20 frequency:250 channel:0]];
    [thresholds addObject:[FrequencyThreshold thresholdDb:20 frequency:250 channel:1]];
    
    return thresholds;
}

@end
