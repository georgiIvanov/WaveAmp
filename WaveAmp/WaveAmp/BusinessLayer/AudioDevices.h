//
//  AudioRoutes.h
//  WaveAmp
//
//  Created by Georgi Ivanov on 10/23/15.
//  Copyright © 2015 GeorgiIvanov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <EZAudioDevice.h>

@protocol AudioDevicesDelegate <NSObject>

-(void)headphonesArePluggedIn:(BOOL)usingHeadphones;
-(void)applicationInterrupted;
-(void)interruptionEndedShouldResume:(BOOL)shouldResume;

@end

@interface AudioDevices : NSObject

@property(nonatomic, weak) id<AudioDevicesDelegate> delegate;
@property(nonatomic, readonly) NSInteger selectedInputDevice;
@property(nonatomic, readonly) NSArray* inputDeviceNames;
@property(nonatomic, readonly) BOOL usingHeadphones;

-(instancetype)initWithCurrentAudioDevice:(EZAudioDevice*)currentDevice;
-(EZAudioDevice*)currentInputDevice;
-(EZAudioDevice*)nextInputDevice;

@end
