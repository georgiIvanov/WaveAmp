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

-(instancetype)initWithCurrentAudioDevice:(EZAudioDevice*)currentDevice
{
    self = [super init];
    if (self) {
        _selectedInputDevice = 0;
        NSNotificationCenter* defaultCenter = [NSNotificationCenter defaultCenter];
        [defaultCenter addObserver:self selector:@selector(audioRouteChanged:) name:AVAudioSessionRouteChangeNotification object:nil];
        
        NSArray* devices = [EZAudioDevice inputDevices];
        for (int i = 0; i < devices.count; i++)
        {
            EZAudioDevice* device = devices[i];
            if([currentDevice isEqual:device])
            {
                _selectedInputDevice = i;
                break;
            }
        }
        
    }
    return self;
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)setDelegate:(id<AudioDevicesDelegate>)delegate
{
    _delegate = delegate;
    [self checkForHeadphones];
}

-(EZAudioDevice *)currentInputDevice
{
    NSArray* inputDevices = [EZAudioDevice inputDevices];
    EZAudioDevice* device = nil;
    if(_selectedInputDevice >= 0 && _selectedInputDevice < inputDevices.count)
    {
        device = [inputDevices objectAtIndex:_selectedInputDevice];
    }
    else
    {
        device = inputDevices.lastObject;
    }
    
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

-(void)checkForHeadphones
{
    NSArray* outputDevices = [EZAudioDevice outputDevices];
    BOOL headphonesPlugged = NO;
    for (EZAudioDevice* device in outputDevices)
    {
        if([device.name isEqualToString:AVAudioSessionPortHeadphones])
        {
            headphonesPlugged = YES;
        }
    }
    
    _usingHeadphones = headphonesPlugged;
    [self.delegate headphonesArePluggedIn:headphonesPlugged];
}

#pragma mark - Notifications

-(void)audioRouteChanged:(NSNotification*)notification
{
    [self checkForHeadphones];
}

@end
