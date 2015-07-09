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

@protocol ToneAudiometerDelegate <NSObject>


@end

@interface PureToneAudiometer : NSObject

@property(nonatomic) id<ToneAudiometerDelegate> delegate;

@property(nonatomic) NSArray* frequencies;
@property(nonatomic) float currentFrequency;
@property(nonatomic) NSRange testsInterval;

-(void)start;
-(void)stop;

@end
