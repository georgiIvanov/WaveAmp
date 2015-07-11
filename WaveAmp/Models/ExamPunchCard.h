//
//  ExamPunchCard.h
//  WaveAmp
//
//  Created by Georgi Ivanov on 7/10/15.
//  Copyright (c) 2015 GeorgiIvanov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ExamPunchCard : NSObject

@property(nonatomic) NSNumber* currentIntensity;
@property(nonatomic) int channel;

+(instancetype)punchCardForChannel:(int)channel;
-(BOOL)addAnswer:(BOOL)isAccurate;

@end
