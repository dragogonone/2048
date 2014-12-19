//
//  PanelFont.h
//  new2048
//
//  Created by USER on 2014/05/12.
//  Copyright (c) 2014年 USER. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PanelFont : NSObject
+(NSString*)GetShowNumber:(unsigned long long)num;
+(NSInteger)GetPanelFont:(unsigned long long)num;
+(NSInteger)GetPanelAint:(unsigned long long)num;
@end
