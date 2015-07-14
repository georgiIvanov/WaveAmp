//
//  AudiogramData.h
//  WaveAmp
//
//  Created by Georgi Ivanov on 7/12/15.
//  Copyright (c) 2015 GeorgiIvanov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AudiogramData : NSObject <NSCoding>

@property(nonatomic) NSArray* leftEar;
@property(nonatomic) NSArray* rightEar;

+(instancetype)audiogramNormalLoss;
+(instancetype)audiogramMildLoss;
+(instancetype)loadAudiogram;

-(instancetype)initWithThresholds:(NSArray*)thresholds;
-(BOOL)saveAudiogram;

@end
