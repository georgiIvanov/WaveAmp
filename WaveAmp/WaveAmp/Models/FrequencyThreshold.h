//
//  FrequencyThreshold.h
//  WaveAmp
//
//  Created by Georgi Ivanov on 7/10/15.
//  Copyright (c) 2015 GeorgiIvanov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FrequencyThreshold : NSObject <NSCoding>

+(instancetype)thresholdDb:(float)db frequency:(float)frequency channel:(int)channel;

@property(nonatomic) NSNumber* frequency;
@property(nonatomic) NSNumber* thresholdDb;
@property(nonatomic) NSNumber* channel;

@end
