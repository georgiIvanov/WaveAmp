//
//  UILabel+TextAnimations.h
//  WaveAmp
//
//  Created by Georgi Ivanov on 7/13/15.
//  Copyright (c) 2015 GeorgiIvanov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommonAnimations : NSObject

+(void)animate:(UILabel*)label withNewText:(NSString*)newText duration:(float)duration completionBlock:(void (^)(BOOL finished))completion;

@end
