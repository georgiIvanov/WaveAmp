//
//  AmplitudeMultiplier.m
//  WaveAmp
//
//  Created by Georgi Ivanov on 7/10/15.
//  Copyright (c) 2015 GeorgiIvanov. All rights reserved.
//

#import "AmplitudeMultiplier.h"

static NSDictionary* multipliersTable;
static NSArray* dBs;

@implementation AmplitudeMultiplier

+(void)load
{
    multipliersTable = @{
                         @(10) : @(0.0004),
                         @(15) : @(0.00072),
                         @(20) : @(0.00128),
                         @(25) : @(0.00225),
                         @(30) : @(0.00400),
                         @(35) : @(0.00718),
                         @(40) : @(0.01276),
                         @(45) : @(0.02252),
                         @(50) : @(0.04004),
                         @(55) : @(0.07178),
                         @(60) : @(0.12696),
                         @(65) : @(0.18696),
                         @(70) : @(0.22520),
                         @(75) : @(0.40040),
                         @(80) : @(0.80040),
                         @(85) : @(1.60040),
                         @(90) : @(3.00040),
                         @(95) : @(5.40040),
                         };
    NSSortDescriptor* sort = [[NSSortDescriptor alloc] initWithKey:@"integerValue" ascending:YES];
    dBs = [[multipliersTable allKeys] sortedArrayUsingDescriptors:@[sort]];
}

+(float)multiplierForWaveDb:(NSNumber*)dB
{
    return [multipliersTable[dB] floatValue];
}

+(NSInteger)intensitySettingsCount
{
    return dBs.count;
}

+(NSNumber*)nextIntensity:(NSNumber*)currentIntensity
{
    for (int i = 0; i < dBs.count - 1; i++)
    {
        NSNumber* number = dBs[i];
        if([number isEqualToNumber:currentIntensity])
        {
            return dBs[++i];
        }
    }
    
    return dBs.lastObject;
}

+(NSNumber*)previousIntensity:(NSNumber*)currentIntensity
{
    for (int i = (int)dBs.count - 1; i >= 1 ; i--)
    {
        if([dBs[i] isEqualToNumber:currentIntensity])
        {
            i = i - 2 >= 0 ? i - 2 : 0;
            return dBs[i];
        }
    }
    
    return dBs.firstObject;
}

+(NSNumber *)maxIntensity
{
    return dBs.lastObject;
}

@end
