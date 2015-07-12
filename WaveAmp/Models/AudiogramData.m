//
//  AudiogramData.m
//  WaveAmp
//
//  Created by Georgi Ivanov on 7/12/15.
//  Copyright (c) 2015 GeorgiIvanov. All rights reserved.
//

#import "AudiogramData.h"
#import "FrequencyThreshold.h"

@interface AudiogramData()

@end

@implementation AudiogramData

- (instancetype)initWithThresholds:(NSArray*)thresholds
{
    self = [super init];
    if (self) {
        NSSortDescriptor* freqSort = [[NSSortDescriptor alloc] initWithKey:@"frequency.integerValue" ascending:YES];
        NSSortDescriptor* channelSort = [[NSSortDescriptor alloc] initWithKey:@"channel.integerValue" ascending:YES];
        NSArray* sorted = [thresholds sortedArrayUsingDescriptors:@[freqSort, channelSort]];
        
        NSMutableArray* left = [[NSMutableArray alloc] initWithCapacity:sorted.count / 2];
        NSMutableArray* right = [[NSMutableArray alloc] initWithCapacity:sorted.count / 2];
        for (FrequencyThreshold* ft in sorted)
        {
            if([ft.channel integerValue] == 0)
            {
                [left addObject:ft];
            }
            else
            {
                [right addObject:ft];
            }
        }
        
        self.leftEar = left;
        self.rightEar = right;
    }
    return self;
}

@end
