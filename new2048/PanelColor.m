//
//  PanelColor.m
//  new2048
//
//  Created by USER on 2014/04/23.
//  Copyright (c) 2014年 USER. All rights reserved.
//

#import "PanelColor.h"

@implementation PanelColor


//20color prepared
+(UIColor*)GetColor:(unsigned long long)num{
    int square = 0;
    UIColor *color;
    while(num>1){
        square++;
        num /= 2;
    }
//    square = square % 16;
//    switch (square) {
//        case 1://2
//            color = [UIColor colorWithRed:1.0 green:0.72 blue:0.0 alpha:1.0];
//            break;
//        case 2://4
//            color = [UIColor colorWithRed:1.0 green:0.62 blue:0.0 alpha:1.0];
//            break;
//        case 3://8
//            color = [UIColor colorWithRed:1.0 green:0.48 blue:0.0 alpha:1.0];
//            break;
//        case 4://16
//            color = [UIColor colorWithRed:1.0 green:0.30 blue:0.0 alpha:1.0];
//            break;
//        case 5://32
//            color = [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:1.0];
//            break;
//        case 6://64
//            color = [UIColor colorWithRed:1.0 green:0.0 blue:0.50 alpha:1.0];
//            break;
//        case 7://128
//            color = [UIColor colorWithRed:1.0 green:0.1 blue:1.0 alpha:1.0];
//            break;
//        case 8://256
//            color = [UIColor colorWithRed:0.7 green:0.0 blue:1.0 alpha:1.0];
//            break;
//        case 9://512
//            color = [UIColor colorWithRed:0.5 green:0.0 blue:1.0 alpha:1.0];
//            break;
//        case 10://1024
//            color = [UIColor colorWithRed:0.3 green:0.0 blue:1.0 alpha:1.0];
//            break;
//        case 11://2048
//            color = [UIColor colorWithRed:0.0 green:0.0 blue:1.0 alpha:1.0];
//            break;
//        case 12://4096
//            color = [UIColor colorWithRed:0.0 green:0.5 blue:1.0 alpha:1.0];
//            break;
//        case 13://8192
//            color = [UIColor colorWithRed:0.0 green:1.0 blue:1.0 alpha:1.0];
//            break;
//        case 14://16384
//            color = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
//            break;
//        case 15://32768
//            color = [UIColor colorWithRed:1.0 green:1.0 blue:0.6 alpha:1.0];
//            break;
//        case 0://65536
//            color = [UIColor colorWithRed:1.0 green:1.0 blue:0.0 alpha:1.0];
//            break;
//        default:
//            color = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
//            break;
//    }
//    return color;
    square = square % 7;
    switch (square) {
        case 1://2
            color = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0];
            break;
        case 2://4
            color = [UIColor colorWithRed:0.9 green:0.9 blue:0.7 alpha:1.0];
            break;
        case 3://8
            color = [UIColor colorWithRed:0.9 green:0.7 blue:0.5 alpha:1.0];
            break;
        case 4://16
            color = [UIColor colorWithRed:1.0 green:0.5 blue:0.3 alpha:1.0];
            break;
        case 5://32
            color = [UIColor colorWithRed:0.9 green:0.35 blue:0.35 alpha:1.0];
            break;
        case 6://64
            color = [UIColor colorWithRed:0.9 green:0.0 blue:0.0 alpha:1.0];
            break;
        case 0://128
            color = [UIColor colorWithRed:0.9 green:0.9 blue:0.0 alpha:1.0];
            break;
    }
    return color;
}

+(UIColor*)GetTextColor:(unsigned long long)num{
    UIColor *color;
    switch (num) {
        //case 256: case 512: case 1024: case 2048://white
        //    color = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
        //    break;
        default:
            color = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];//black
            break;
    }
    return color;
}

+(UIColor*)GetBaseColor:(NSString *)str{
    UIColor *color;
    
    if([str  isEqual: @"base1"]){//middle green,rootbase
        color = [UIColor colorWithRed:0.333 green:0.42 blue:0.184 alpha:1.0];
    }else if ([str isEqual:@"base2"]){//light green
        color = [UIColor colorWithRed:0.561 green:0.737 blue:0.561 alpha:1.0];
    }else if([str isEqual:@"darkgreen"]){//dark green
        color = [UIColor colorWithRed:0 green:0.392 blue:0 alpha:1.0];
    }
    
    
    return color;
}


@end
