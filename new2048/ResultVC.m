//
//  ResultVC.m
//  new2048
//
//  Created by USER on 2014/04/29.
//  Copyright (c) 2014年 USER. All rights reserved.
//

#import "ResultVC.h"
#import "PanelColor.h"
#import "HighScore.h"

@interface ResultVC (){
    unsigned long long maxnum;
    unsigned long long score;
}


@end

@implementation ResultVC

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
    float schet = [UIScreen mainScreen].bounds.size.height;
    
    CALayer *baseLayer = [self.view layer];
    baseLayer.backgroundColor = [PanelColor GetBaseColor:@"base1"].CGColor;
    
    _Titlelbl = [[UILabel alloc] initWithFrame:CGRectMake(60,30,200,50)];
    _Titlelbl.text = @"GameOver";
    _Titlelbl.font = [UIFont systemFontOfSize:30];
    _Titlelbl.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_Titlelbl];
    
    _Scorelbl = [[UILabel alloc] initWithFrame:CGRectMake(60,schet/6,200,50)];
    _Scorelbl.numberOfLines = 2;
    _Scorelbl.text = [NSString stringWithFormat:@"Score\n%lld",score ];
    _Scorelbl.font = [UIFont systemFontOfSize:20];
    _Scorelbl.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_Scorelbl];
    
    _restartbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_restartbtn setTitle:@"Restart" forState:UIControlStateNormal];
    _restartbtn.frame = CGRectMake(60,schet/6+70, 200, 60);
    [_restartbtn addTarget:self
                    action:@selector(RestartBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self ShapeButton:(_restartbtn)];
    [self.view addSubview:_restartbtn];
    
    _tweetbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_tweetbtn setTitle:@"Tweet" forState:UIControlStateNormal];
    _tweetbtn.frame = CGRectMake(60,schet/6+140, 200, 60);
    [_tweetbtn addTarget:self
                    action:@selector(TweetBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self ShapeButton:(_tweetbtn)];
    [self.view addSubview:_tweetbtn];
    
    _highscorebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_highscorebtn setTitle:@"Highscore" forState:UIControlStateNormal];
    _highscorebtn.frame = CGRectMake(60,schet/6 + 210, 200, 60);
    [_highscorebtn addTarget:self
                  action:@selector(HighscoreBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self ShapeButton:(_highscorebtn)];
    [self.view addSubview:_highscorebtn];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)SendScore:(unsigned long long)befs maxnumber:(unsigned long long)befm{
    score = befs;
    maxnum = befm;
}

- (void)ShapeButton:(UIButton*)button{
    //[button setTitleColor:[UIColor colorWithRed:0 green:0.392 blue:0 alpha:1.0] forState:UIControlStateNormal];
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
    //[buttonLayer setBackgroundColor:[[UIColor colorWithRed:0.561 green:0.737 blue:0.561 alpha:1.0] CGColor]];
    [buttonLayer setBackgroundColor:[[PanelColor GetBaseColor:@"darkgreen"] CGColor]];
}

-(void)RestartBtn:(UIButton*)button{
    [self performSegueWithIdentifier:@"RestartUnwind" sender:self];
}

- (void)TweetBtn:(UIButton*)button {
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]){
        SLComposeViewController *twitter = [[SLComposeViewController alloc]init];
        twitter = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        [twitter setInitialText:[NSString stringWithFormat:@"2048で最大%lluのブロックを作り、%lluのスコアを獲得しました #EASY 2048",maxnum,score]];
        [self presentViewController:twitter animated:YES completion:NULL];
    }
}

-(void)HighscoreBtn:(UIButton*)button{
    [self performSegueWithIdentifier:@"ToHighScoreFromResult" sender:self];
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
