//
//  ResultVC.h
//  new2048
//
//  Created by USER on 2014/04/29.
//  Copyright (c) 2014年 USER. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <Social/Social.h>

@interface ResultVC : UIViewController

@property (strong, nonatomic) UILabel *Titlelbl;
@property (strong, nonatomic) UILabel *Scorelbl;

@property (strong, nonatomic) UIButton *restartbtn;
@property (strong, nonatomic) UIButton *tweetbtn;
@property (strong, nonatomic) UIButton *highscorebtn;

-(void)SendScore:(unsigned long long)befs maxnumber:(unsigned long long)befm;

@end
