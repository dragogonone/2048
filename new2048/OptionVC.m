//
//  OptionVC.m
//  new2048
//
//  Created by USER on 2014/04/29.
//  Copyright (c) 2014年 USER. All rights reserved.
//

#import "OptionVC.h"
#import "GameVC.h"
#import "PanelColor.h"

@interface OptionVC (){
    unsigned long long score;
}

@end

@implementation OptionVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIScreen *sc = [UIScreen mainScreen];
    CGRect rrr = sc.bounds;
    //float scwid = rrr.size.width;
    float schet = rrr.size.height;
    
    
    CALayer *baseLayer = [self.view layer];
    baseLayer.backgroundColor = [PanelColor GetBaseColor:@"base1"].CGColor;
    
    
    /*Set Buttons*/
    _continuebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_continuebtn setTitle:@"Continue" forState:UIControlStateNormal];
    _continuebtn.frame = CGRectMake(60,schet/5, 200, 60);
    [_continuebtn addTarget:self
                 action:@selector(ContinueBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self ShapeButton:(_continuebtn)];
    [self.view addSubview:_continuebtn];
    
    
    _restartbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_restartbtn setTitle:@"Restart" forState:UIControlStateNormal];
    _restartbtn.frame = CGRectMake(60,schet/5 + 100, 200, 60);
    [_restartbtn addTarget:self
                     action:@selector(RestartBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self ShapeButton:(_restartbtn)];
    [self.view addSubview:_restartbtn];
    
    _highscorebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_highscorebtn setTitle:@"Highscore" forState:UIControlStateNormal];
    _highscorebtn.frame = CGRectMake(60,schet/5 + 200, 200, 60);
    [_highscorebtn addTarget:self
                    action:@selector(HighscoreBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self ShapeButton:(_highscorebtn)];
    [self.view addSubview:_highscorebtn];
    
    /*End Set Buttons*/
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)SendScore:(unsigned long long)befs{
    score = befs;
}

- (void)ShapeButton:(UIButton*)button{
    [button setTitleColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0] forState:UIControlStateNormal];
    [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [button.titleLabel setFont:[UIFont systemFontOfSize:30]];
    //CALayer Start
    CALayer *buttonLayer = button.layer;
    CGSize buttonSize = button.bounds.size;
    // ボタンが縦長／横長どちらの場合でも、それに応じた角丸半径を設定する
    CGFloat buttonRadius = (buttonSize.width>buttonSize.height)?buttonSize.height/3:buttonSize.width/3;
    [buttonLayer setMasksToBounds:YES];
    [buttonLayer setCornerRadius:buttonRadius];
    [buttonLayer setBorderWidth:1.0f];
    [buttonLayer setBorderColor:[[UIColor blackColor] CGColor]];
    [buttonLayer setBackgroundColor:[[PanelColor GetBaseColor:@"darkgreen"] CGColor]];
}



-(void)ContinueBtn:(UIButton*)button{
    [self dismissViewControllerAnimated:NO completion:nil];
}


-(void)RestartBtn:(UIButton*)button{
    [self performSegueWithIdentifier:@"RestartUnwind" sender:self];
}

-(void)HighscoreBtn:(UIButton*)button{
    [self performSegueWithIdentifier:@"ToHighScoreFromOption" sender:self];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
