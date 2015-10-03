//
//  SoundFile.h
//  WaveAmp
//
//  Created by Georgi Ivanov on 7/15/15.
//  Copyright (c) 2015 GeorgiIvanov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SoundFile : NSObject

-(instancetype)initWithPath:(NSString*)path;

@property(nonatomic) NSString* path;
@property(nonatomic, readonly) NSString* name;

@end
