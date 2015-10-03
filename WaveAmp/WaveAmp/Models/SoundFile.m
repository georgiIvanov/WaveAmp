//
//  SoundFile.m
//  WaveAmp
//
//  Created by Georgi Ivanov on 7/15/15.
//  Copyright (c) 2015 GeorgiIvanov. All rights reserved.
//

#import "SoundFile.h"

@implementation SoundFile

- (instancetype)initWithPath:(NSString*)path
{
    self = [super init];
    if (self) {
        self.path = path;
    }
    return self;
}

-(void)setPath:(NSString *)path
{
    _path = path;
    NSString* fullName = [path componentsSeparatedByString:@"/"].lastObject;
    NSString* name = [fullName componentsSeparatedByString:@"."].firstObject;
    _name = name;
}

@end
