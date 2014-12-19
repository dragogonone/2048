//
//  HighScore.m
//  new2048
//
//  Created by USER on 2014/04/24.
//  Copyright (c) 2014年 USER. All rights reserved.
//

#import "HighScore.h"
#import "GameVC.h"

@implementation HighScore

/* デフォルト設定（初回のみ） */
+(void)SetDefault{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];  // 取得
    NSMutableDictionary *defaults = [NSMutableDictionary dictionary];
    //    [ud removeObjectForKey:@"KEY_HighScore"];
    NSArray* arr = [NSArray arrayWithObjects:@"0",@"0",@"0",@"0",@"0",nil];
    [defaults setObject:arr forKey:@"KEY_HighScore"];
    
    arr = [NSArray arrayWithObjects:@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",nil];
    NSArray* arr2 = [NSArray arrayWithObjects:arr,arr,arr,arr,arr,nil];
    [defaults setObject:arr2 forKey:@"KEY_DetailHighScore"];
    
    [ud registerDefaults:defaults];
    
}

+(unsigned long long)GetHighScore:(int)rank{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];  // 取得
    NSArray *higharr = [ud arrayForKey:@"KEY_HighScore"];
    NSNumber *num = higharr[rank];
    return [num longLongValue];
}

+(NSArray*)GetDetailHighScore:(int)rank{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];  // 取得
    NSArray *higharr = [ud arrayForKey:@"KEY_DetailHighScore"];
    //NSArray *detailarr = [NSArray arrayWithObjects:higharr[0], nil];
    NSArray *detailarr = higharr[rank];
    return detailarr;
}


#pragma marks Setter

/*戻り値にランクを入れ、その値によってSetDetailHighScoreを使用するかどうか判定*/
+(NSInteger)SetHighScore:(unsigned long long)score{
    //NSLog(@"score:%d",score);
    bool isHighScoreGet = NO;
    NSInteger rank = 1000;//rankがこの値のときはランク外
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];  // 取得
    
    NSArray *higharr = [ud arrayForKey:@"KEY_HighScore"];
    NSMutableArray *mArr = [NSMutableArray arrayWithArray:higharr];
    int i;
    for (i=4;i>=0;i--){
        int sint = [mArr[i] intValue];
        if(score>sint){
            isHighScoreGet = YES;
            rank = i;//一位は0
        }
    }
    
    if (isHighScoreGet){
        NSLog(@"HighScoreGet");
        for (i = 4; i > rank; i--) {
            int x = [mArr[i-1] intValue];
            mArr[i] = [NSString stringWithFormat:@"%d",x];
        }
        mArr[rank] = [NSString stringWithFormat:@"%lld",score];
        // [mArr removeObjectAtIndex:10];
    }
    
    higharr = mArr;
    [ud setObject:higharr forKey:@"KEY_HighScore"];
    [ud synchronize]; //保存を実行
    return rank;
}

+(void)SetDetailHighScore:(NSArray *)befarr Withrank:(NSInteger)rank{
    int i;
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSArray *higharr = [ud arrayForKey:@"KEY_DetailHighScore"];
    NSMutableArray *mArr = [NSMutableArray arrayWithArray:higharr];
    
    //rankより下のハイスコアたちを一つずつ下にずらす
    for (i = 4; i > rank; i--) {
        NSArray *arr = mArr[i-1];
        mArr[i] = arr;
    }
    mArr[rank] = befarr;
    higharr = mArr;
    //NSLog(@"DetailHighScore:%@",[higharr description]);
    [ud setObject:higharr forKey:@"KEY_DetailHighScore"];
    [ud synchronize];
}









@end
