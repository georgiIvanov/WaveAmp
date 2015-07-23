//
//  HearingExamDeclarations.h
//  WaveAmp
//
//  Created by Georgi Ivanov on 7/9/15.
//  Copyright (c) 2015 GeorgiIvanov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AudiogramData.h"
#import "AudiometerProtocols.h"

@interface PureToneAudiometer : NSObject

@property(nonatomic) id<ToneAudiometerDelegate> delegate;
@property(nonatomic) id<AudiometerPlayerDelegate> playerDelegate;

@property(nonatomic) NSArray* frequencies;
@property(nonatomic) float currentFrequency;
@property(nonatomic) float signalMultiplier;
@property(nonatomic) AudioChannel currentChannel;
@property(nonatomic) NSRange testsInterval;

-(instancetype)initWithExamOptions:(ExamOptions)examOptions;
-(void)start;
-(void)buttonHeldForChannel:(AudioChannel)channel;
-(void)buttonReleasedForChannel:(AudioChannel)channel;

@end
