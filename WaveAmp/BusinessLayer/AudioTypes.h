//
//  AudioTypes.h
//  WaveAmp
//
//  Created by Georgi Ivanov on 7/14/15.
//  Copyright (c) 2015 GeorgiIvanov. All rights reserved.
//

#ifndef WaveAmp_AudioTypes_h
#define WaveAmp_AudioTypes_h

extern NSString* const kAudiogramKey;
extern NSTimeInterval const TimerUpdateInterval;

typedef NS_ENUM(int, AudioChannel) {
    kLeftChannel = 0,
    kRightChannel = 1
};

typedef NS_ENUM(int, ExamOptions) {
    kFullLengthExam = 1,
    kShortExam = 1 << 1,
};

#endif
