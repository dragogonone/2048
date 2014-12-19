//
//  OptionVC.h
//  new2048
//
//  Created by USER on 2014/04/29.
//  Copyright (c) 2014年 USER. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface OptionVC : UIViewController

@property (strong, nonatomic) UIButton *continuebtn;
@property (strong, nonatomic) UIButton *restartbtn;
@property (strong, nonatomic) UIButton *highscorebtn;

-(void)SendScore:(unsigned long long)befs;

@end
