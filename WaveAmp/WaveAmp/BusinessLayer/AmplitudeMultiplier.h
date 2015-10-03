//
//  AmplitudeMultiplier.h
//  WaveAmp
//
//  Created by Georgi Ivanov on 7/10/15.
//  Copyright (c) 2015 GeorgiIvanov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AmplitudeMultiplier : NSObject

+(NSInteger)intensitySettingsCount;
+(NSNumber*)nextIntensity:(NSNumber*)currentIntensity;
+(NSNumber*)previousIntensity:(NSNumber*)currentIntensity;
+(NSNumber*)maxIntensity;
+(NSNumber*)minIntensity;
+(float)multiplierForWaveDb:(NSNumber*)dB;

@end
