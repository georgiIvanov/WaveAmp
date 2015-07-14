//
//  HearingExamDeclarations.h
//  WaveAmp
//
//  Created by Georgi Ivanov on 7/9/15.
//  Copyright (c) 2015 GeorgiIvanov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AudiogramData.h"
#import "AudioTypes.h"


@protocol ToneAudiometerDelegate <NSObject>

-(void)startingTest:(int)number;
-(void)testsAreOver:(AudiogramData*)audiogramData;

@end

@interface PureToneAudiometer : NSObject

@property(nonatomic) id<ToneAudiometerDelegate> delegate;

@property(nonatomic) NSArray* frequencies;
@property(nonatomic) float currentFrequency;
@property(nonatomic) float signalMultiplier;
@property(nonatomic) AudioChannel currentChannel;
@property(nonatomic) NSRange testsInterval;

-(void)start;
-(void)buttonHeldForChannel:(AudioChannel)channel;
-(void)buttonReleasedForChannel:(AudioChannel)channel;

@end
