//
//  ExamPunchCard.m
//  WaveAmp
//
//  Created by Georgi Ivanov on 7/10/15.
//  Copyright (c) 2015 GeorgiIvanov. All rights reserved.
//

#import "ExamPunchCard.h"
#import "AmplitudeMultiplier.h"

const int CorrectAnswersShort = 0;
const int CorrectAnswersFull = 2;

@interface ExamPunchCard()

@property(nonatomic) NSMutableDictionary* answers;
@property(nonatomic) int correctAnswersLimit;

@end

@implementation ExamPunchCard

+(instancetype)punchCard
{
    return [ExamPunchCard punchCardForChannel:0 frequency:1000 options:kFullLengthExam];
}

+(instancetype)punchCard:(ExamOptions)options
{
    return [ExamPunchCard punchCardForChannel:0 frequency:1000 options:options];
}

+(instancetype)punchCardForChannel:(int)channel frequency:(float)frequency options:(ExamOptions)options
{
    ExamPunchCard* pc = [[ExamPunchCard alloc] initForChannel:channel frequency:frequency options:options];
    return pc;
}

- (instancetype)initForChannel:(int)channel frequency:(float)frequency options:(ExamOptions)options
{
    self = [super init];
    if (self) {
        self.answers = [NSMutableDictionary new];
        _currentIntensity = @(30);
        _channel = channel;
        _frequency = frequency;
        // the volume should be increased until the user hears the tone
        _ascending = YES;
        
        if(options == kFullLengthExam)
        {
            self.correctAnswersLimit = CorrectAnswersFull;
        }
        else if(options == kShortExam)
        {
            self.correctAnswersLimit = CorrectAnswersShort;
        }
        else if(options == kDebugExam)
        {
            self.correctAnswersLimit = CorrectAnswersShort;
        }
        else
        {
            [NSException raise:@"Invalid punchcard options" format:@"Invalid options of %d were set.", options];
        }
    }
    return self;
}

-(BOOL)addAnswerIsAccurate:(BOOL)isAccurate
{
    // how answer should be registered depends if the volume is ascending
    // http://i.imgur.com/rW2cWYu.png
    
    if([self.currentIntensity integerValue] >= [AmplitudeMultiplier maxIntensity].integerValue && isAccurate == NO)
    {
        // user did not hear highest intensity
        return YES;
    }
    
    if(_correctAnswersLimit == CorrectAnswersShort &&
       [self.currentIntensity integerValue] == [AmplitudeMultiplier minIntensity].integerValue &&
       isAccurate == YES)
    {
        // in short mode if user hears the min intensity he passes the punch card
        return YES;
    }
    
    NSNumber* number = [self.answers objectForKey:self.currentIntensity];
    if(number)
    {
        NSNumber* newNumber;
        if(self.ascending)
        {
            newNumber = isAccurate ? @([number integerValue] + 1) : @([number integerValue] - 1);
        }
        else
        {
            newNumber = isAccurate ? number : @([number integerValue] - 1);
        }
        
        [self.answers setObject:newNumber forKey:self.currentIntensity];
        if([newNumber integerValue] >= _correctAnswersLimit)
        {
            return YES;
        }
    }
    else
    {
        NSNumber* initialScore = [self determineInitialScoreAccurate:isAccurate];
        [self.answers setObject:initialScore forKey:self.currentIntensity];
    }
    
    [self determineIntensity:isAccurate];
    
    return NO;
}

-(void)determineIntensity:(BOOL)isAccurate
{
    if(isAccurate)
    {
        [self determineIntensityForAccurateAnswer];
        return;
    }
    
    _ascending = YES;
    
    // if user has heard at least 1 tone we increase intensity by 5
    for (NSNumber* scores in [self.answers allValues])
    {
        if([scores integerValue] >= 0)
        {
            _currentIntensity = [AmplitudeMultiplier nextIntensity:_currentIntensity];
            return;
        }
    }
    
    // if we haven't got response from user yet, increase intensity by 20
    NSNumber* number = [AmplitudeMultiplier nextIntensity:self.currentIntensity];
    for (int i = 0; i < 3; i++)
    {
        number = [AmplitudeMultiplier nextIntensity:number];
    }
    
    _currentIntensity = number;
}

-(void)determineIntensityForAccurateAnswer
{
    _ascending = NO;
    NSNumber* newIntensity = [AmplitudeMultiplier previousIntensity:self.currentIntensity];
    
    if([newIntensity isEqualToNumber:self.currentIntensity])
    {
        // if we reach edge intensity we have to change to ascending
        // because we can't produce too loud or oversilent sound
        _ascending = YES;
    }
    else
    {
        _currentIntensity = newIntensity;
    }
}

-(NSNumber*)determineInitialScoreAccurate:(BOOL)isAccurate
{
    if(isAccurate && _ascending == NO)
    {
        return @(-1); // if it's not ascending, result doesn't count
    }
    else if(isAccurate)
    {
        return @(0);
    }
    else
    {
        return @(-1);
    }
}

@end
