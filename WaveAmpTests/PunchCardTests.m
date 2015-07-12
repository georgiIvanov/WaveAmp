//
//  PunchCardTests.m
//  WaveAmp
//
//  Created by Georgi Ivanov on 7/12/15.
//  Copyright (c) 2015 GeorgiIvanov. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ExamPunchCard.h"

@interface PunchCardTests : XCTestCase

@end


@implementation PunchCardTests

// reference image - http://i.imgur.com/1JD4b6Y.png

- (void)testFirstAnswerCorrect
{
    ExamPunchCard* pc = [[ExamPunchCard alloc] init];
    NSInteger initialVolume = [pc.currentIntensity integerValue];
    [pc addAnswerIsAccurate:YES];
    
    XCTAssertEqual([pc.currentIntensity integerValue], initialVolume - 10);
    XCTAssertEqual(pc.ascending, NO);
}

- (void)testFirstAndSecondCorrect
{
    ExamPunchCard* pc = [[ExamPunchCard alloc] init];
    NSInteger initialVolume = [pc.currentIntensity integerValue];
    [pc addAnswerIsAccurate:YES];
    [pc addAnswerIsAccurate:YES];
    
    XCTAssertEqual([pc.currentIntensity integerValue], initialVolume - 20);
    XCTAssertEqual(pc.ascending, NO);
}

- (void)test2Correct1Wrong
{
    ExamPunchCard* pc = [[ExamPunchCard alloc] init];
    NSInteger initialVolume = [pc.currentIntensity integerValue];
    [pc addAnswerIsAccurate:YES];
    [pc addAnswerIsAccurate:YES];
    [pc addAnswerIsAccurate:NO];
    
    XCTAssertEqual([pc.currentIntensity integerValue], initialVolume - 15);
    XCTAssertEqual(pc.ascending, YES);
}

- (void)test2Correct2Wrong
{
    ExamPunchCard* pc = [[ExamPunchCard alloc] init];
    NSInteger initialVolume = [pc.currentIntensity integerValue];
    [pc addAnswerIsAccurate:YES];
    [pc addAnswerIsAccurate:YES];
    [pc addAnswerIsAccurate:NO];
    [pc addAnswerIsAccurate:NO];
    
    XCTAssertEqual([pc.currentIntensity integerValue], initialVolume - 10);
    XCTAssertEqual(pc.ascending, YES);
}

- (void)test2Correct2Wrong1Correct
{
    ExamPunchCard* pc = [[ExamPunchCard alloc] init];
    NSInteger initialVolume = [pc.currentIntensity integerValue];
    [pc addAnswerIsAccurate:YES];
    [pc addAnswerIsAccurate:YES];
    [pc addAnswerIsAccurate:NO];
    [pc addAnswerIsAccurate:NO];
    [pc addAnswerIsAccurate:YES];
    
    XCTAssertEqual([pc.currentIntensity integerValue], initialVolume - 20);
    XCTAssertEqual(pc.ascending, NO);
}

-(void)testAnswerFullyFor20dBThreshold
{
    ExamPunchCard* pc = [[ExamPunchCard alloc] init];
    
    XCTAssertFalse([pc addAnswerIsAccurate:YES]);
    XCTAssertFalse([pc addAnswerIsAccurate:YES]);
    XCTAssertFalse([pc addAnswerIsAccurate:NO]);
    XCTAssertFalse([pc addAnswerIsAccurate:NO]);
    XCTAssertFalse([pc addAnswerIsAccurate:YES]);
    XCTAssertFalse([pc addAnswerIsAccurate:NO]);
    XCTAssertFalse([pc addAnswerIsAccurate:NO]);
    XCTAssertFalse([pc addAnswerIsAccurate:YES]);
    XCTAssertFalse([pc addAnswerIsAccurate:NO]);
    XCTAssertFalse([pc addAnswerIsAccurate:NO]);
    
    XCTAssertTrue([pc addAnswerIsAccurate:YES]);
    // when we have conclusive evidence for the hearing threshold
    // next ascending and intensity values are not important anymore
}


// reference image - http://i.imgur.com/rW2cWYu.png


- (void)testFirstWrong
{
    ExamPunchCard* pc = [[ExamPunchCard alloc] init];
    NSInteger initialVolume = [pc.currentIntensity integerValue];
    [pc addAnswerIsAccurate:NO];
    
    XCTAssertEqual([pc.currentIntensity integerValue], initialVolume + 20);
    XCTAssertEqual(pc.ascending, YES);
}

- (void)testFirst2Wrong
{
    ExamPunchCard* pc = [[ExamPunchCard alloc] init];
    NSInteger initialVolume = [pc.currentIntensity integerValue];
    XCTAssertFalse([pc addAnswerIsAccurate:NO]);
    XCTAssertFalse([pc addAnswerIsAccurate:NO]);
    
    XCTAssertEqual([pc.currentIntensity integerValue], initialVolume + 40);
    XCTAssertEqual(pc.ascending, YES);
}

-(void)testFullAnswersFor40dBThreshold
{
    ExamPunchCard* pc = [[ExamPunchCard alloc] init];
    
    XCTAssertFalse([pc addAnswerIsAccurate:NO]);
    XCTAssertFalse([pc addAnswerIsAccurate:YES]);
    XCTAssertFalse([pc addAnswerIsAccurate:NO]);
    XCTAssertFalse([pc addAnswerIsAccurate:YES]);
    XCTAssertFalse([pc addAnswerIsAccurate:NO]);
    XCTAssertFalse([pc addAnswerIsAccurate:YES]);
    XCTAssertFalse([pc addAnswerIsAccurate:NO]);
    XCTAssertFalse([pc addAnswerIsAccurate:NO]);
    XCTAssertFalse([pc addAnswerIsAccurate:YES]);
    XCTAssertFalse([pc addAnswerIsAccurate:NO]);
    XCTAssertFalse([pc addAnswerIsAccurate:NO]);
    
    XCTAssertTrue([pc addAnswerIsAccurate:YES]);
}

- (void)testReachingLowestIntensity
{
    ExamPunchCard* pc = [[ExamPunchCard alloc] init];
    
    XCTAssertFalse([pc addAnswerIsAccurate:YES]);
    XCTAssertFalse([pc addAnswerIsAccurate:YES]);
    XCTAssertFalse([pc addAnswerIsAccurate:YES]);
    XCTAssertEqual(pc.ascending, YES);
    XCTAssertFalse([pc addAnswerIsAccurate:YES]);
    XCTAssertFalse([pc addAnswerIsAccurate:YES]);
    
    XCTAssertTrue([pc addAnswerIsAccurate:YES]);
    
    XCTAssertEqual([pc.currentIntensity integerValue], 10);
    XCTAssertEqual(pc.ascending, YES);
}

- (void)testExceedingHighestIntensity
{
    ExamPunchCard* pc = [[ExamPunchCard alloc] init];
    
    XCTAssertFalse([pc addAnswerIsAccurate:NO]);
    XCTAssertFalse([pc addAnswerIsAccurate:NO]);
    XCTAssertFalse([pc addAnswerIsAccurate:NO]);
    
    XCTAssertTrue([pc addAnswerIsAccurate:NO]);
    
    
    XCTAssertEqual([pc.currentIntensity integerValue], 75);
    XCTAssertEqual(pc.ascending, YES);
}

-(void)test75dBThreshold
{
    ExamPunchCard* pc = [[ExamPunchCard alloc] init];
    
    XCTAssertFalse([pc addAnswerIsAccurate:NO]);
    XCTAssertFalse([pc addAnswerIsAccurate:NO]);
    XCTAssertFalse([pc addAnswerIsAccurate:NO]);
    XCTAssertFalse([pc addAnswerIsAccurate:YES]);
    XCTAssertFalse([pc addAnswerIsAccurate:NO]);
    XCTAssertFalse([pc addAnswerIsAccurate:NO]);
    XCTAssertFalse([pc addAnswerIsAccurate:YES]);
    XCTAssertFalse([pc addAnswerIsAccurate:NO]);
    XCTAssertFalse([pc addAnswerIsAccurate:NO]);
    
    XCTAssertTrue([pc addAnswerIsAccurate:YES]);
    
    XCTAssertEqual([pc.currentIntensity integerValue], 75);
}

@end
