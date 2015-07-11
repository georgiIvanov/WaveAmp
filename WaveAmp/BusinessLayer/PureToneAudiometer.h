//
//  HearingExamDeclarations.h
//  WaveAmp
//
//  Created by Georgi Ivanov on 7/9/15.
//  Copyright (c) 2015 GeorgiIvanov. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString* const kAudiogramKey;
extern NSTimeInterval const TimerUpdateInterval;

typedef NS_ENUM(int, AudioChannel) {
    kLeftChannel = 0,
    kRightChannel = 1
};

@protocol ToneAudiometerDelegate <NSObject>

-(void)startingTest:(int)number;
-(void)testsAreOver;

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
