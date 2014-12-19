//
//  GameVC.h
//  new2048
//
//  Created by USER on 2014/04/23.
//  Copyright (c) 2014年 USER. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <iAd/iAd.h>

@interface GameVC : UIViewController

@property (strong, nonatomic) CATextLayer *scorelay;
@property (strong,nonatomic) CATextLayer *highscorelay;
@property (strong, nonatomic) UIButton *Optionbtn;
@property (strong, nonatomic) UIButton *Akitabtn;

@property CALayer *base2Layer;

@end
