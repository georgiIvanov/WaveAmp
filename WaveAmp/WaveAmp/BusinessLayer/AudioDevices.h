//
//  AudioRoutes.h
//  WaveAmp
//
//  Created by Georgi Ivanov on 10/23/15.
//  Copyright © 2015 GeorgiIvanov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <EZAudioDevice.h>

@interface AudioDevices : NSObject

@property(nonatomic, readonly) NSInteger selectedInputDevice;
@property(nonatomic, readonly) NSArray* inputDeviceNames;

-(EZAudioDevice*)currentInputDevice;
-(EZAudioDevice*)nextInputDevice;

@end
