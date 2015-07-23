//
//  AudiometerProtocols.h
//  WaveAmp
//
//  Created by Georgi Ivanov on 7/23/15.
//  Copyright (c) 2015 GeorgiIvanov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AudioTypes.h"
#import "AudiogramData.h"

@protocol ToneAudiometerDelegate <NSObject>

-(void)startingTest:(int)number;
-(void)testsAreOver:(AudiogramData*)audiogramData;

@end

@protocol AudiometerPlayerDelegate <NSObject>

-(void)testingFrequency:(float)frequency;
-(void)testingWithSignalMultiplier:(float)signalMultiplier;
-(void)testingAudioChannel:(AudioChannel)audioChannel;

@end
