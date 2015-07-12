//
//  AudiogramData.h
//  WaveAmp
//
//  Created by Georgi Ivanov on 7/12/15.
//  Copyright (c) 2015 GeorgiIvanov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AudiogramData : NSObject

@property(nonatomic) NSArray* leftEar;
@property(nonatomic) NSArray* rightEar;

-(instancetype)initWithThresholds:(NSArray*)thresholds;

@end
