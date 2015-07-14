//
//  FrequencyThreshold.m
//  WaveAmp
//
//  Created by Georgi Ivanov on 7/10/15.
//  Copyright (c) 2015 GeorgiIvanov. All rights reserved.
//

#import "FrequencyThreshold.h"

@implementation FrequencyThreshold

+(instancetype)thresholdDb:(float)db frequency:(float)frequency channel:(int)channel
{
    FrequencyThreshold* ft = [[FrequencyThreshold alloc] init];
    ft.thresholdDb = @(db);
    ft.frequency = @(frequency);
    ft.channel = @(channel);
    
    return ft;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    if (self) {
        self.thresholdDb = [coder decodeObjectForKey:@"threshold"];
        self.frequency = [coder decodeObjectForKey:@"frequency"];
        self.channel = [coder decodeObjectForKey:@"channel"];
    }
    return self;
}


-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.thresholdDb forKey:@"threshold"];
    [aCoder encodeObject:self.frequency forKey:@"frequency"];
    [aCoder encodeObject:self.channel forKey:@"channel"];
}

@end
