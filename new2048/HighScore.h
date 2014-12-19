//
//  HighScore.h
//  new2048
//
//  Created by USER on 2014/04/24.
//  Copyright (c) 2014年 USER. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HighScore : NSObject

+(void)SetDefault;
+(unsigned long long)GetHighScore:(int)rank;
+(NSArray*)GetDetailHighScore:(int)rank;
+(NSInteger)SetHighScore:(unsigned long long)score;
+(void)SetDetailHighScore:(NSArray*)befarr Withrank:(NSInteger)rank;

@end
