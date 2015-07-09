//
//  HearingExamDeclarations.m
//  WaveAmp
//
//  Created by Georgi Ivanov on 7/9/15.
//  Copyright (c) 2015 GeorgiIvanov. All rights reserved.
//

#import "PureToneAudiometer.h"

NSString* const kAudiogramKey = @"AudiogramData";
NSTimeInterval const TimerUpdateInterval = 0.1f;

@interface PureToneAudiometer()

@property(nonatomic) NSTimeInterval nextTest;
@property(nonatomic) NSTimeInterval testSignalLength;
@property(nonatomic) NSTimer* timer;

@end

@implementation PureToneAudiometer

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frequencies = @[@(1000), @(2000), @(3000), @(4000), @(6000), @(8000), @(1000), @(500), @(250)];
        self.currentFrequency = 0;
        self.testsInterval = NSMakeRange(1, 3);
    }
    return self;
}

-(void)start
{
    self.nextTest = 1.0f;
    self.testSignalLength = 0.0f;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:TimerUpdateInterval target:self selector:@selector(update:) userInfo:nil repeats:YES];
}

-(void)stop
{
    [self.timer invalidate];
    self.timer = nil;
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
        _nextTest = (_testSignalLength + arc4random() % 4) + 1;
        [self makeSignal];
    }
}

-(void)makeSignal
{
    self.currentFrequency = [self.frequencies.firstObject floatValue];
}

@end
