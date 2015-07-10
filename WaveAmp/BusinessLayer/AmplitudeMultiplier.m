//
//  AmplitudeMultiplier.m
//  WaveAmp
//
//  Created by Georgi Ivanov on 7/10/15.
//  Copyright (c) 2015 GeorgiIvanov. All rights reserved.
//

#import "AmplitudeMultiplier.h"

static NSDictionary* multipliersTable;

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
                         @(70) : @(0.22520),
                         @(75) : @(0.40040),
                         };
}

+(float)multiplierForWaveDb:(NSNumber*)dB
{
    return [multipliersTable[dB] floatValue];
}

@end
