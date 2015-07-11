//
//  ExamPunchCard.m
//  WaveAmp
//
//  Created by Georgi Ivanov on 7/10/15.
//  Copyright (c) 2015 GeorgiIvanov. All rights reserved.
//

#import "ExamPunchCard.h"

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
    }
    return self;
}

-(BOOL)addAnswer:(BOOL)isAccurate
{
    NSNumber* number = [self.answers objectForKey:self.currentIntensity];
    if(number)
    {
        NSNumber* newNumber = isAccurate ? @([number integerValue] + 1) : @([number integerValue] - 1);
        [self.answers setObject:newNumber forKey:self.currentIntensity];
        return [newNumber integerValue] >= 2 ? YES : NO;
    }
    else
    {
        NSNumber* initialValue = isAccurate ? @(0) : @(-1);
        [self.answers setObject:initialValue forKey:self.currentIntensity];
    }
    
    return NO;
}

@end
