//
//  ExamPunchCard.m
//  WaveAmp
//
//  Created by Georgi Ivanov on 7/10/15.
//  Copyright (c) 2015 GeorgiIvanov. All rights reserved.
//

#import "ExamPunchCard.h"
#import "AmplitudeMultiplier.h"

@interface ExamPunchCard()

@property(nonatomic) NSMutableDictionary* answers;

@end

@implementation ExamPunchCard

+(instancetype)punchCardForChannel:(int)channel
{
    ExamPunchCard* pc = [ExamPunchCard new];
    pc.channel = channel;
    return pc;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.answers = [NSMutableDictionary new];
        self.currentIntensity = @(30);
        // the volume should be increased until the user hears the tone
        self.ascending = YES;
    }
    return self;
}

-(BOOL)addAnswerIsAccurate:(BOOL)isAccurate
{
    // how answer should be registered depends if the volume is ascending
    // http://i.imgur.com/rW2cWYu.png
    
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
        [self determineIntensity:isAccurate];
        return [newNumber integerValue] >= 2 ? YES : NO;
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
        self.ascending = NO;
        self.currentIntensity = [AmplitudeMultiplier previousIntensity:self.currentIntensity];
        return;
    }
    
    self.ascending = YES;
    
    // if user has heard at least 1 tone we increase intensity by 5
    for (NSNumber* scores in [self.answers allValues])
    {
        if([scores integerValue] >= 0)
        {
            self.currentIntensity = [AmplitudeMultiplier nextIntensity:self.currentIntensity];
            return;
        }
    }
    
    // if we haven't got response from user yet, increase intensity by 20
    NSNumber* number = [AmplitudeMultiplier nextIntensity:self.currentIntensity];
    for (int i = 0; i < 3; i++)
    {
        number = [AmplitudeMultiplier nextIntensity:number];
    }
    
    self.currentIntensity = number;
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
