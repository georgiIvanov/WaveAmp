//
//  AudioRoutes.m
//  WaveAmp
//
//  Created by Georgi Ivanov on 10/23/15.
//  Copyright © 2015 GeorgiIvanov. All rights reserved.
//

#import "AudioDevices.h"

@interface AudioDevices()


@end

@implementation AudioDevices

- (instancetype)init
{
    self = [super init];
    if (self) {
        _selectedInputDevice = 0;
    }
    return self;
}

-(NSArray *)inputDeviceNames
{
    NSArray* devices = [EZAudioDevice inputDevices];
    NSMutableArray* names = [NSMutableArray arrayWithCapacity:4];
    for (EZAudioDevice* device in devices) {
        [names addObject:device.name];
    }
    
    return names;
}

-(EZAudioDevice *)currentInputDevice
{
    EZAudioDevice* device = [[EZAudioDevice inputDevices] objectAtIndex:_selectedInputDevice];
    return device;
}

-(EZAudioDevice *)nextInputDevice
{
    NSArray* devices = [EZAudioDevice inputDevices];
    _selectedInputDevice++;
    if(_selectedInputDevice >= devices.count)
    {
        _selectedInputDevice = 0;
    }
    return [self currentInputDevice];
}

@end
