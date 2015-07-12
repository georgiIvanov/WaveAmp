//
//  AmplitudeMultiplierTests.m
//  WaveAmp
//
//  Created by Georgi Ivanov on 7/12/15.
//  Copyright (c) 2015 GeorgiIvanov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "AmplitudeMultiplier.h"

@interface AmplitudeMultiplierTests : XCTestCase

@end

@implementation AmplitudeMultiplierTests

- (void)testDecreaseIntensity30
{
    NSNumber* number = [AmplitudeMultiplier previousIntensity:@(30)];
    XCTAssertEqual([number integerValue], 20);
}

- (void)testDecreaseIntensityEdge1
{
    NSNumber* number = [AmplitudeMultiplier previousIntensity:@(10)];
    XCTAssertEqual([number integerValue], -1);
}

- (void)testDecreaseIntensityEdge2
{
    NSNumber* number = [AmplitudeMultiplier previousIntensity:@(15)];
    XCTAssertEqual([number integerValue], 10);
}

- (void)testDecreaseFromMaxToMin
{
    NSInteger count = [AmplitudeMultiplier intensitySettingsCount] / 2;
    NSNumber* number = @(75); // highest
    
    for (int i = 0; i < count; i++)
    {
        number = [AmplitudeMultiplier previousIntensity:number];
    }
    
    XCTAssertEqual([number integerValue], 10);
}

- (void)testIncreaseIntensity40
{
    NSNumber* number = [AmplitudeMultiplier nextIntensity:@(40)];
    XCTAssertEqual([number integerValue], 45);
}

- (void)testIncreaseIntensityEdge
{
    NSNumber* number = [AmplitudeMultiplier nextIntensity:@(75)];
    XCTAssertEqual([number integerValue], -1);
}

- (void)testIncreaseIntensityNextToHighest
{
    NSNumber* number = [AmplitudeMultiplier nextIntensity:@(70)];
    XCTAssertEqual([number integerValue], 75);
}

- (void)testIncreaseFromMinToMax
{
    NSInteger count = [AmplitudeMultiplier intensitySettingsCount];
    NSNumber* number = @(10); // lowest
    
    for (int i = 1; i < count; i++)
    {
        number = [AmplitudeMultiplier nextIntensity:number];
    }
    
    XCTAssertEqual([number integerValue], 75);
}

@end
