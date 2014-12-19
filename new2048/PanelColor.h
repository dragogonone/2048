//
//  PanelColor.h
//  new2048
//
//  Created by USER on 2014/04/23.
//  Copyright (c) 2014年 USER. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PanelColor : UIColor
+(UIColor*)GetColor:(unsigned long long)num;
+(UIColor*)GetTextColor:(unsigned long long)num;
+(UIColor*)GetBaseColor:(NSString*)str;


@end
