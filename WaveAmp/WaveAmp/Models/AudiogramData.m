//
//  AudiogramData.m
//  WaveAmp
//
//  Created by Georgi Ivanov on 7/12/15.
//  Copyright (c) 2015 GeorgiIvanov. All rights reserved.
//

#import "AudiogramData.h"
#import "FrequencyThreshold.h"
#import "AudioTypes.h"

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

- (instancetype)initWithCoder:(NSCoder *)coder
{
    if (self) {
        self.rightEar = [coder decodeObjectForKey:@"right"];
        self.leftEar = [coder decodeObjectForKey:@"left"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.rightEar forKey:@"right"];
    [aCoder encodeObject:self.leftEar forKey:@"left"];
}

-(BOOL)saveAudiogram
{
    NSData* data = [NSKeyedArchiver archivedDataWithRootObject:self];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:kAudiogramKey];
    return [[NSUserDefaults standardUserDefaults] synchronize];
}

-(BOOL)isWithinNormalLoss
{
    for (int i = 0; i < self.leftEar.count; i++)
    {
        FrequencyThreshold* ft1 = (FrequencyThreshold*)self.leftEar[i];
        FrequencyThreshold* ft2 = (FrequencyThreshold*)self.rightEar[i];
        
        if([ft1.thresholdDb integerValue] > 20 || [ft2.thresholdDb integerValue] > 20)
        {
            return NO;
        }
    }
    
    return YES;
}

+(instancetype)loadAudiogram
{
    NSData* data = [[NSUserDefaults standardUserDefaults] objectForKey:kAudiogramKey];
    AudiogramData* ad = nil;
    if(data != nil)
    {
        ad = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    return ad;
}

+(instancetype)audiogramNormalLoss
{
    NSMutableArray* thresholds = [NSMutableArray new];
    
    [thresholds addObject:[FrequencyThreshold thresholdDb:20 frequency:1000 channel:0]];
    [thresholds addObject:[FrequencyThreshold thresholdDb:20 frequency:1000 channel:1]];
    
    [thresholds addObject:[FrequencyThreshold thresholdDb:20 frequency:2000 channel:1]];
    [thresholds addObject:[FrequencyThreshold thresholdDb:20 frequency:2000 channel:0]];
    
    [thresholds addObject:[FrequencyThreshold thresholdDb:20 frequency:3000 channel:0]];
    [thresholds addObject:[FrequencyThreshold thresholdDb:20 frequency:3000 channel:1]];
    
    [thresholds addObject:[FrequencyThreshold thresholdDb:20 frequency:4000 channel:0]];
    [thresholds addObject:[FrequencyThreshold thresholdDb:20 frequency:4000 channel:1]];
    
    [thresholds addObject:[FrequencyThreshold thresholdDb:20 frequency:6000 channel:1]];
    [thresholds addObject:[FrequencyThreshold thresholdDb:20 frequency:6000 channel:0]];
    
    [thresholds addObject:[FrequencyThreshold thresholdDb:20 frequency:8000 channel:1]];
    [thresholds addObject:[FrequencyThreshold thresholdDb:20 frequency:8000 channel:0]];
    
    [thresholds addObject:[FrequencyThreshold thresholdDb:20 frequency:500 channel:0]];
    [thresholds addObject:[FrequencyThreshold thresholdDb:20 frequency:500 channel:1]];
    
    [thresholds addObject:[FrequencyThreshold thresholdDb:20 frequency:250 channel:0]];
    [thresholds addObject:[FrequencyThreshold thresholdDb:20 frequency:250 channel:1]];
    
    AudiogramData* ad = [[AudiogramData alloc] initWithThresholds:thresholds];
    return ad;
}

+(instancetype)audiogramMildLoss
{
    NSMutableArray* thresholds = [NSMutableArray new];
    
    [thresholds addObject:[FrequencyThreshold thresholdDb:10 frequency:250 channel:1]];
    [thresholds addObject:[FrequencyThreshold thresholdDb:15 frequency:250 channel:0]];
    
    [thresholds addObject:[FrequencyThreshold thresholdDb:25 frequency:500 channel:0]];
    [thresholds addObject:[FrequencyThreshold thresholdDb:20 frequency:500 channel:1]];
    
    [thresholds addObject:[FrequencyThreshold thresholdDb:25 frequency:1000 channel:0]];
    [thresholds addObject:[FrequencyThreshold thresholdDb:25 frequency:1000 channel:1]];
    
    [thresholds addObject:[FrequencyThreshold thresholdDb:20 frequency:2000 channel:1]];
    [thresholds addObject:[FrequencyThreshold thresholdDb:20 frequency:2000 channel:0]];
    
    [thresholds addObject:[FrequencyThreshold thresholdDb:25 frequency:3000 channel:0]];
    [thresholds addObject:[FrequencyThreshold thresholdDb:25 frequency:3000 channel:1]];
    
    [thresholds addObject:[FrequencyThreshold thresholdDb:30 frequency:4000 channel:0]];
    [thresholds addObject:[FrequencyThreshold thresholdDb:30 frequency:4000 channel:1]];
    
    [thresholds addObject:[FrequencyThreshold thresholdDb:55 frequency:6000 channel:1]];
    [thresholds addObject:[FrequencyThreshold thresholdDb:65 frequency:6000 channel:0]];
    
    [thresholds addObject:[FrequencyThreshold thresholdDb:60 frequency:8000 channel:1]];
    [thresholds addObject:[FrequencyThreshold thresholdDb:70 frequency:8000 channel:0]];
    
    AudiogramData* ad = [[AudiogramData alloc] initWithThresholds:thresholds];
    return ad;
}

+(instancetype)audiogramSevereLoss
{
    NSMutableArray* thresholds = [NSMutableArray new];
    
    [thresholds addObject:[FrequencyThreshold thresholdDb:65 frequency:250 channel:0]];
    [thresholds addObject:[FrequencyThreshold thresholdDb:65 frequency:250 channel:1]];
    
    [thresholds addObject:[FrequencyThreshold thresholdDb:65 frequency:500 channel:0]];
    [thresholds addObject:[FrequencyThreshold thresholdDb:65 frequency:500 channel:1]];
    
    [thresholds addObject:[FrequencyThreshold thresholdDb:65 frequency:1000 channel:0]];
    [thresholds addObject:[FrequencyThreshold thresholdDb:65 frequency:1000 channel:1]];
    
    [thresholds addObject:[FrequencyThreshold thresholdDb:70 frequency:2000 channel:1]];
    [thresholds addObject:[FrequencyThreshold thresholdDb:70 frequency:2000 channel:0]];
    
    [thresholds addObject:[FrequencyThreshold thresholdDb:75 frequency:3000 channel:0]];
    [thresholds addObject:[FrequencyThreshold thresholdDb:75 frequency:3000 channel:1]];
    
    [thresholds addObject:[FrequencyThreshold thresholdDb:80 frequency:4000 channel:0]];
    [thresholds addObject:[FrequencyThreshold thresholdDb:80 frequency:4000 channel:1]];
    
    [thresholds addObject:[FrequencyThreshold thresholdDb:85 frequency:6000 channel:1]];
    [thresholds addObject:[FrequencyThreshold thresholdDb:90 frequency:6000 channel:0]];
    
    [thresholds addObject:[FrequencyThreshold thresholdDb:85 frequency:8000 channel:1]];
    [thresholds addObject:[FrequencyThreshold thresholdDb:95 frequency:8000 channel:0]];
    
    AudiogramData* ad = [[AudiogramData alloc] initWithThresholds:thresholds];
    return ad;
}

@end
