//
//  PanelFont.m
//  new2048
//
//  Created by USER on 2014/05/12.
//  Copyright (c) 2014年 USER. All rights reserved.
//

#import "PanelFont.h"

@implementation PanelFont

+(NSString*)GetShowNumber:(unsigned long long)num{
    NSMutableString *nummutstr = [NSMutableString stringWithFormat:@"%lld",num];
    NSNumber *numberValue = [[NSNumber alloc] initWithLongLong:num];
    NSInteger digits = (int)log10([numberValue doubleValue]) + 1;
    if(8<=digits && digits<=12){
        [nummutstr insertString:@"\n" atIndex:digits/2];
    }
    if(13<=digits){
        [nummutstr insertString:@"\n" atIndex:digits/3];
        [nummutstr insertString:@"\n" atIndex:digits/3*2+1];
    }
    NSString *numstr = nummutstr;
    if(num ==1){
        numstr = @("Over");
    }
    return numstr;
}

+(NSInteger)GetPanelFont:(unsigned long long)num{

    NSInteger font = 18;
    NSNumber *numberValue = [[NSNumber alloc] initWithUnsignedLongLong:num];
    NSInteger digits = (int)log10([numberValue doubleValue]) + 1;
    if (num == 1){
        digits = 4;
    }
    switch (digits) {
        case 1: case 2: case 3:
            font = 39;
            break;
        case 4:
            font = 30;
            break;
        case 5:
            font = 23;
            break;
        case 6:
            font = 20;
            break;
        case 7:
            font = 17;
            break;
        case 8:
            font = 26;
            break;
        case 9:
            font = 22;
            break;
        case 10:
            font = 22;
            break;
        case 11:
            font = 18;
            break;
        case 12:
            font = 18;
            break;
            
    }
    
    return font;
}

+(NSInteger)GetPanelAint:(unsigned long long)num{

    NSNumber *numberValue = [[NSNumber alloc] initWithUnsignedLongLong:num];
    NSInteger digits = (int)log10([numberValue doubleValue]) + 1;
    NSInteger aint = 0;
    switch (digits) {
        case 1: case 2: case 3:
            aint = 11;
            break;
        case 4:
            aint = 15;
            break;
        case 5:
            aint = 19;
            break;
        case 6:
            aint = 23;
            break;
        case 7:
            aint = 24;
            break;
        default:
            break;
    }
    if(8<=digits && digits<=12){
        aint = 4;
    }
    
    return aint;
}

@end
