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

NSString* const kAudiogramKey = @"AudiogramData";
NSTimeInterval const TimerUpdateInterval = 0.1f;

@interface PureToneAudiometer()

@property(nonatomic) NSTimeInterval nextTest;
@property(nonatomic) NSTimeInterval testSignalLength;
@property(nonatomic) NSTimer* timer;
@property(nonatomic) int testIndex;
@property(nonatomic) NSMutableArray* punchCards;
@property(nonatomic) int currentPunchCard;

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
    [self.delegate testsAreOver];
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
    self.currentPunchCard = arc4random() % self.punchCards.count;
    ExamPunchCard* pc = self.punchCards[self.currentPunchCard];
    self.currentChannel = pc.channel;
    self.signalMultiplier = [AmplitudeMultiplier multiplierForWaveDb:pc.currentIntensity];
    self.currentFrequency = [self.frequencies[_testIndex] floatValue];
}

-(void)buttonHeldForChannel:(AudioChannel)channel
{
    // debug stuff
    if (self.punchCards.count > 0)
    {
        ExamPunchCard* pc = self.punchCards[self.currentPunchCard];
        if([pc addAnswer:NO])
        {
            [self.punchCards removeObject:pc];
        }
    }
}

-(void)buttonReleasedForChannel:(AudioChannel)channel
{
    
}

@end
