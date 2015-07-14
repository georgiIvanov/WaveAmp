//
//  HearingExamDeclarations.m
//  WaveAmp
//
//  Created by Georgi Ivanov on 7/9/15.
//  Copyright (c) 2015 GeorgiIvanov. All rights reserved.
//

#import "PureToneAudiometer.h"
#import "ExamPunchCard.h"
#import "AmplitudeMultiplier.h"
#import "FrequencyThreshold.h"

@interface PureToneAudiometer()

@property(nonatomic) NSTimeInterval nextTest;
@property(nonatomic) NSTimeInterval testSignalLength;
@property(nonatomic) NSTimer* timer;
@property(nonatomic) int testIndex;
@property(nonatomic) NSMutableArray* punchCards;
@property(nonatomic) int currentPunchCardIndex;
@property(nonatomic) NSMutableArray* thresholds;

@end

@implementation PureToneAudiometer

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frequencies = @[@(1000), @(2000), @(3000), @(4000), @(6000), @(8000), @(1000), @(500), @(250)];
        self.currentFrequency = 0;
        self.testsInterval = NSMakeRange(2, 3);
        self.punchCards = [NSMutableArray new];
    }
    return self;
}

-(void)start
{
    self.testIndex = -1;
    self.nextTest = -1.0f; // starting test without delay for testing purposes
    self.testSignalLength = 0.0f;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:TimerUpdateInterval target:self selector:@selector(update:) userInfo:nil repeats:YES];
    self.thresholds = [[NSMutableArray alloc] initWithCapacity:self.frequencies.count * 2];
}

-(void)prepareForNextFreqency
{
    self.punchCards = [NSMutableArray arrayWithObjects:[ExamPunchCard punchCardForChannel:kLeftChannel],
                                                       [ExamPunchCard punchCardForChannel:kRightChannel], nil];
}

-(void)stop
{
    [self.timer invalidate];
    self.timer = nil;
    
    AudiogramData* ad = [[AudiogramData alloc] initWithThresholds:self.thresholds];
    [self.delegate testsAreOver:ad];
}

-(void)update:(NSTimer*)timer
{
    if(_nextTest > 0)
    {
        _nextTest -= TimerUpdateInterval;
    }
    
    if(_testSignalLength <= 0)
    {
        _currentFrequency = 0;
    }
    
    _testSignalLength -= TimerUpdateInterval;
    if (_testSignalLength <= 0 && _nextTest < 0)
    {
        _testSignalLength = arc4random() % (_testsInterval.length - _testsInterval.location) + _testsInterval.location;
        _nextTest = (_testSignalLength + arc4random() % 2) + 0.5f;// + 2;
        [self nextSignal];
    }
}

-(void)nextSignal
{
    ExamPunchCard* pc = [self currentPunchCard];
    if(pc && pc.wasAcknowledged == NO &&
       [pc addAnswerIsAccurate:NO])
    {
        [self punchCardIsReady:pc];
    }
    
    if(self.punchCards.count > 0)
    {
        [self pickAnEarToTestNext];
    }
    else
    {
        self.testIndex++;
        if(_testIndex >= self.frequencies.count)
        {
            [self stop];
            return;
        }
        
        [self prepareForNextFreqency];
        [self pickAnEarToTestNext];
        [self.delegate startingTest:_testIndex + 1];
    }
}

-(void)pickAnEarToTestNext
{
    for (ExamPunchCard* pc in self.punchCards) {
        pc.wasAcknowledged = NO;
    }
    
    self.currentPunchCardIndex = arc4random() % self.punchCards.count;
    ExamPunchCard* pc = [self currentPunchCard];
    self.currentChannel = pc.channel;
    self.signalMultiplier = [AmplitudeMultiplier multiplierForWaveDb:pc.currentIntensity];
    self.currentFrequency = [self.frequencies[_testIndex] floatValue];
    NSLog(@"presenting new tone");
}

-(void)punchCardIsReady:(ExamPunchCard*)pc
{
    // http://i.imgur.com/1JD4b6Y.png
    FrequencyThreshold* threshold = [FrequencyThreshold thresholdDb:[pc.currentIntensity intValue]
                                                          frequency:self.currentFrequency
                                                            channel:pc.channel];
    
    if(self.thresholds.count > 1 && self.currentFrequency == 1000)
    {
        // TODO: to avoid the duplicating 1000's
        // thresholds should be a NSSet and FrequencyThreshold should implement isEqual:
    }
    else
    {
        [self.thresholds addObject:threshold];
    }
    
    [self.punchCards removeObject:pc];
    self.currentPunchCardIndex = 0;
}

-(ExamPunchCard*)currentPunchCard
{
    if(self.punchCards.count)
    {
        return self.punchCards[self.currentPunchCardIndex];
    }
    return nil;
}

-(void)buttonHeldForChannel:(AudioChannel)channel
{
    ExamPunchCard* pc = [self currentPunchCard];
    if(pc.channel == channel && self.testSignalLength > 0)
    {
        pc.wasAcknowledged = YES;
    }
}

-(void)buttonReleasedForChannel:(AudioChannel)channel
{
    ExamPunchCard* pc = [self currentPunchCard];
    if(pc.wasAcknowledged)
    {
        if([pc addAnswerIsAccurate:YES])
        {
            [self punchCardIsReady:pc];
        }
    }
}

@end
