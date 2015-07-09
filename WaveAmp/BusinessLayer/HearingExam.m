//
//  HearingExamDeclarations.m
//  WaveAmp
//
//  Created by Georgi Ivanov on 7/9/15.
//  Copyright (c) 2015 GeorgiIvanov. All rights reserved.
//

#import "HearingExam.h"

NSString* const kAudiogramKey = @"AudiogramData";

@implementation HearingExam

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frequencies = @[@(500), @(1000), @(2000), @(4000), @(8000)];
    }
    return self;
}

@end
