//
//  ExamPunchCard.h
//  WaveAmp
//
//  Created by Georgi Ivanov on 7/10/15.
//  Copyright (c) 2015 GeorgiIvanov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AudioTypes.h"

// TODO: Derive 2 subclasses for short and full exam mode
@interface ExamPunchCard : NSObject

@property(nonatomic, readonly) NSNumber* currentIntensity;
@property(nonatomic, readonly) int channel;
@property(nonatomic, readonly) BOOL ascending;
@property(nonatomic, readonly) float frequency;
// user heard the signal and pressed down the button
@property(nonatomic) BOOL wasAcknowledged;

+(instancetype)punchCard;
+(instancetype)punchCard:(ExamOptions)options;
+(instancetype)punchCardForChannel:(int)channel frequency:(float)frequency options:(ExamOptions)options;

// returns YES when hearing threshold is determined
-(BOOL)addAnswerIsAccurate:(BOOL)isAccurate;

@end
