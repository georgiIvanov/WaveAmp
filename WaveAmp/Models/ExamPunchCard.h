//
//  ExamPunchCard.h
//  WaveAmp
//
//  Created by Georgi Ivanov on 7/10/15.
//  Copyright (c) 2015 GeorgiIvanov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ExamPunchCard : NSObject

@property(nonatomic, readonly) NSNumber* currentIntensity;
@property(nonatomic, readonly) int channel;
@property(nonatomic, readonly) BOOL ascending;
// user heard the signal and pressed down the button
@property(nonatomic) BOOL wasAcknowledged;

+(instancetype)punchCard;
+(instancetype)punchCardForChannel:(int)channel;

// returns YES when hearing threshold is determined
-(BOOL)addAnswerIsAccurate:(BOOL)isAccurate;

@end
