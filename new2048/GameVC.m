//
//  GameVC.m
//  new2048
//
//  Created by USER on 2014/04/23.
//  Copyright (c) 2014年 USER. All rights reserved.
//

#import "GameVC.h"
#import "PanelColor.h"
#import "PanelFont.h"
#import "HighScore.h"
#import "OptionVC.h"
#import "ResultVC.h"


@interface GameVC (){
    NSInteger scwidth;
    NSInteger scheight;
    bool swipable;
    unsigned long long numarr[4][4];//メイン配列
    unsigned long long tempnumarr[4][4];//動かせるかの判定に使う配列
    unsigned long long lockarr[4][4];//数字が足し合わされた箇所を特定する配列　連鎖を防止と拡大アニメーションに使用
    unsigned long long popnum;
    unsigned long long score;
    unsigned long long highscore;
    unsigned long long maxnum;
    NSInteger animex;
    NSInteger animey;
}

@end

@implementation GameVC
@synthesize base2Layer;

//@synthesize scorelay = _scorelay;

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
    [HighScore SetDefault];
    [self initLayer];
    // Do any additional setup after loading the view.
    //[self.navigationController setNavigationBarHidden:YES animated:NO];
    
    
    UISwipeGestureRecognizer* swipeRightGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(selSwipeRightGesture:)];
    swipeRightGesture.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeRightGesture];
    
    UISwipeGestureRecognizer* swipeLeftGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(selSwipeLeftGesture:)];// 左スワイプ
    swipeLeftGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeLeftGesture];
    
    UISwipeGestureRecognizer* swipeDownGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(selSwipeDownGesture:)];//下スワイプ
    swipeDownGesture.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:swipeDownGesture];
    
    UISwipeGestureRecognizer* swipeUpGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(selSwipeUpGesture:)];//上スワイプ
    swipeUpGesture.direction = UISwipeGestureRecognizerDirectionUp;
    [self.view addGestureRecognizer:swipeUpGesture];

    
    [self Start];
    
}

-(void)Start{
    //initialize variable number
    swipable = 1;
    popnum = 2;
    //popnum = 8192*2;
    //popnum = 1152921504606846976/4;
    maxnum = 2;
    score = 0;
    animex = 999;
    animey = 999;
    
    for(int x=0;x<4;x++){
        for(int y=0;y<4;y++){
            numarr[x][y] = 0;
            lockarr[x][y] = 0;
        }
    }
    
    [self MakeNum];
    [self MakeNum];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initLayer{
    CGRect rrr = [UIScreen mainScreen].bounds;
    scwidth = rrr.size.width;//320
    scheight = rrr.size.height;
    NSLog(@"%ld,%ld",scwidth,scheight);
    highscore = [HighScore GetHighScore:(0)];
    
    /* iAd */
    ADBannerView *adView
    = [[ADBannerView alloc] initWithFrame:CGRectMake(0.0, scheight-50, 320.0, 50.0)];
    adView.currentContentSizeIdentifier = ADBannerContentSizeIdentifier320x50;
    [self.view addSubview:adView];
    /* End iAd */
    
    
    CALayer *baseLayer = [self.view layer];
    baseLayer.backgroundColor = [PanelColor GetBaseColor:(@"base1")].CGColor;
    
    base2Layer = [CALayer layer];
    base2Layer.backgroundColor = [PanelColor GetBaseColor:(@"base2")].CGColor;
    base2Layer.frame = CGRectMake(10,scheight-350,300,300);
    base2Layer.cornerRadius = 5;
    [baseLayer addSublayer:base2Layer];
    
    for(int x=0;x<4;x++){
        for(int y=0;y<4;y++){
            CALayer *base3Layer = [CALayer layer];
            base3Layer.backgroundColor = [PanelColor GetBaseColor:(@"base1")].CGColor;
            base3Layer.frame = CGRectMake(5+(x*73.5),5+(y*73.5),68.75, 68.75);
            base3Layer.cornerRadius = 5;
            //base3Layer.name = [NSString stringWithFormat:@"%d",x+y*4];
            [base2Layer addSublayer:base3Layer];
        }
    }
    
    _scorelay = [CATextLayer layer];
    _scorelay.string = @"Score\n0";
    _scorelay.fontSize = 20;
    _scorelay.foregroundColor=[UIColor whiteColor].CGColor;
    _scorelay.alignmentMode = kCAAlignmentCenter;
    _scorelay.backgroundColor = [PanelColor GetBaseColor:@"darkgreen"].CGColor;
    _scorelay.cornerRadius = 10;
    _scorelay.frame = CGRectMake(10, 30, 120, 50);
    [baseLayer addSublayer:_scorelay];
    
    _highscorelay = [CATextLayer layer];
    _highscorelay.string = [NSString stringWithFormat:@"HighScore\n%lld",highscore];
    _highscorelay.fontSize = 20;
    _highscorelay.foregroundColor=[UIColor whiteColor].CGColor;
    _highscorelay.alignmentMode = kCAAlignmentCenter;
    _highscorelay.backgroundColor = [PanelColor GetBaseColor:@"darkgreen"].CGColor;
    _highscorelay.cornerRadius = 10;
    _highscorelay.frame = CGRectMake(190, 30, 120, 50);
    [baseLayer addSublayer:_highscorelay];
    
    _Optionbtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _Optionbtn.frame = CGRectMake(25, 90, 90, 30);
    _Optionbtn.backgroundColor = [PanelColor GetColor:(2)];
    [_Optionbtn setTitle:@"Option" forState:UIControlStateNormal];
    [_Optionbtn addTarget:self
                    action:@selector(OptionBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_Optionbtn];
    
    _Akitabtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _Akitabtn.frame = CGRectMake(205, 90, 90, 30);
    _Akitabtn.backgroundColor = [PanelColor GetColor:(2)];
    [_Akitabtn setTitle:@"GameOver" forState:UIControlStateNormal];
    [_Akitabtn addTarget:self
                   action:@selector(AkitaBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_Akitabtn];
    
}


- (void)selSwipeUpGesture:(UISwipeGestureRecognizer *)sender {
    NSLog(@"Up Gesture");
    [self Swiped:(1)];
}
- (void)selSwipeDownGesture:(UISwipeGestureRecognizer *)sender {
    NSLog(@"Down Gesture");
    [self Swiped:(2)];
}
- (void)selSwipeLeftGesture:(UISwipeGestureRecognizer *)sender {
    NSLog(@"Left Gesture");
    [self Swiped:(3)];
}
- (void)selSwipeRightGesture:(UISwipeGestureRecognizer *)sender {
    NSLog(@"Right Gesture");
    [self Swiped:(4)];
}


- (void)Swiped:(int)swipedir{
    //1↑ 2↓ 3← 4→
    if(!swipable){
        NSLog(@"unswipable");
        return;
    }
    swipable = 0;
    
    for(int x=0;x<4;x++){
        for(int y=0;y<4;y++){
            tempnumarr[x][y] = numarr[x][y];
        }
    }
    
    //動かす対称それぞれをMove mod2(swipedir)で分岐
    if(swipedir%2){//左上から
        for(int x=0;x<4;x++){
            for(int y=0;y<4;y++){
                if(numarr[x][y]){
                    [self MoveNum:(swipedir) x:(x) y:(y)];
                }
            }
        }
    }else{//右下から
        for(int x=3;x>=0;x--){
            for(int y=3;y>=0;y--){
                if(numarr[x][y]){
                    [self MoveNum:(swipedir) x:(x) y:(y)];
                }
            }
        }
    }
    
    bool isequal = 1;
    for(int x=0;x<4;x++){
        for(int y=0;y<4;y++){
            isequal *= (tempnumarr[x][y] == numarr[x][y]);
        }
    }
    if(!isequal){
        [self MakeNum];
    }
    
    for(int x=0;x<4;x++){
        for(int y=0;y<4;y++){
            if(lockarr[x][y]==1){
                lockarr[x][y] = 0;
            }
        }
    }
    
    bool breakFlag = 0;
    /*check GameOver*/
    while (true) {
        for(int x=0;x<4;x++){
            for(int y=0;y<4;y++){
                //numarrが１だった場合for文を抜ける
                if(!numarr[x][y]){breakFlag = 1;}
                if(x<3){
                    if(numarr[x][y] == numarr[x+1][y] && (numarr[x][y]!=1)){breakFlag = 1;}
                }
                if(y<3){
                    if(numarr[x][y] == numarr[x][y+1] && (numarr[x][y]!=1)){breakFlag = 1;}
                }
            }
        }
        if(breakFlag){break;}
        [self GameOver];
        return;
    }
    /*end check GameOver*/
    
    swipable = 1;
}

-(void)MoveNum:(int)swipedir x:(int)befx y:(int)befy{
    
    int dirx,diry;
    unsigned long long befnum = numarr[befx][befy];
    int karix = befx;
    int kariy = befy;
    bool isSamenum = NO;
    
    switch(swipedir){
        case 1://up
            dirx = 0;
            diry = -1;
            break;
        case 2://down
            dirx = 0;
            diry = 1;
            break;
        case 3://left
            dirx = -1;
            diry = 0;
            break;
        case 4://right
            dirx = 1;
            diry = 0;
            break;
        default:
            dirx = 999;
            diry = 999;
    }
    
    NSLog(@"whilemae %lld",befnum);
    //part of forward
    bool ismoved = 0;
    while(true){
        NSLog(@"karix:%d,kariy:%d",karix,kariy);
        //仮座標を進める
        karix += dirx;
        kariy += diry;
        
        //盤面上でない
        if ( karix < 0 || karix >= 4 || kariy < 0 || kariy >= 4 ) {
            NSLog(@"outoforder");
            break; // ループを抜ける
        }
        
        //同じ数字があった時
        if(numarr[karix][kariy] == befnum){
            //連鎖防止
            if (lockarr[karix][kariy] || befnum == 1){
                break;
            }
            
            if(befnum>=4611686018427387903){
                NSLog(@"popnum overed");
                befnum = 1;
            }else{
                befnum *=2;
            }
            
            NSLog(@"samenum");
            NSString *str = [NSString stringWithFormat:@"%d",karix+kariy*4];
            CALayer *numbacklay = [base2Layer valueForKey:str];
            [numbacklay removeFromSuperlayer];
            score += befnum;
            _scorelay.string = [NSString stringWithFormat:@"Score\n%lld",score];
            ismoved = 1;
            lockarr[karix][kariy]=1;
            animex = karix;
            animey = kariy;
            karix += dirx;
            kariy += diry;
            isSamenum = YES;
            break;
        }
        
        //違う数字があった時
        if(numarr[karix][kariy] != 0){
            NSLog(@"difnum");
            break;
        }
        
        //なんもなかった場合はループ続行
        ismoved = 1;
    }
    
    
    if(ismoved){
        //kariを一回戻す（強引）
        karix -= dirx;
        kariy -= diry;
        numarr[karix][kariy] = befnum;
        numarr[befx][befy] = 0;
        
        /*動かす*/
        NSString *str = [NSString stringWithFormat:@"%d",befx+befy*4];
        CALayer *numbacklay = [base2Layer valueForKey:str];
        numbacklay.backgroundColor = [PanelColor GetColor:(befnum)].CGColor;
        //positionを動かすだけでも可（応用が効かない）
        //numbacklay.position = CGPointMake(39.375+(karix*73.5),39.375+(kariy*73.5));
        
        /*アニメーション*/
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
        animation.duration = 0.12; // アニメーション速度
        animation.repeatCount = 1; // 繰り返し回数
        // 始点と終点を設定
        CGPoint poi = CGPointMake(5+68.75/2+(befx*73.5),5+68.75/2+(befy*73.5));
        animation.fromValue = [NSValue valueWithCGPoint:poi]; // 始点
        poi = CGPointMake(5+68.75/2+(karix*73.5),5+68.75/2+(kariy*73.5));
        animation.toValue = [NSValue valueWithCGPoint:poi]; // 終点
        // これを設定しなければanimationDidStop:finished:は呼ばれない
        if(isSamenum){
            animation.delegate = self;
        }
        //アニメーション終了時に元の位置に戻さない
        animation.removedOnCompletion = NO;
        animation.fillMode = kCAFillModeForwards;
        // アニメーションを追加
        [numbacklay addAnimation:animation forKey:@"move-layer"];
        /*アニメーション*/
        
        [base2Layer setValue:numbacklay forKey:[NSString stringWithFormat:@"%d",karix+kariy*4]];
        CATextLayer *numlay = numbacklay.sublayers[0];
        numlay.string = [PanelFont GetShowNumber:befnum];
        //numlay.string = [NSString stringWithFormat:@"%d",befnum];
        numlay.foregroundColor = [PanelColor GetTextColor:befnum].CGColor;
        numlay.fontSize = [PanelFont GetPanelFont:befnum];
        /*動かす終わり*/
        
    }
}


-(void)MakeNum{

    
    //for debug
    //popnum *= 2;
    
    //for original2048
    //popnum = arc4random() % 10;
    //if (popnum!=4){popnum = 2;}
    
    //for new2048
    unsigned long long minnum = 4611686018427387905;
    for(int x=0;x<4;x++){
        for(int y=0;y<4;y++){
            if(numarr[x][y] != 0){
                minnum = MIN(numarr[x][y], minnum);
                maxnum = MAX(numarr[x][y], maxnum);
            }
        }
    }
    NSLog(@"min:%lldmax:%lld",minnum,maxnum);
    if(popnum>=4611686018427387903){
        NSLog(@"popnum overed");
        popnum = 1;
    }else if (popnum < minnum && popnum*64<=maxnum){
        popnum *= 2;
    }
    
    
    
    //空きスペの処理
    
    int spacecnt = 0;
    int spacearr[16];
    int i = 0;
    for(int x=0;x<4;x++){
        for(int y=0;y<4;y++){
            if(numarr[x][y] == 0){
                spacecnt++;
                spacearr[i] = x+y*4;
                i++;
            }
        }
    }
    
    NSLog(@"space:%d",spacecnt);
    
    int rnd = arc4random() % spacecnt;
    int makex,makey;
    makex = spacearr[rnd]%4;
    makey = spacearr[rnd]/4;
    NSLog(@"makex:%d,makey:%d",makex,makey);
    numarr[makex][makey] = popnum;
    
    //describe
    CALayer *numbacklay = [CALayer layer];
    numbacklay.backgroundColor = [PanelColor GetColor:(popnum)].CGColor;
    numbacklay.frame = CGRectMake(5+(makex*73.5),5+(makey*73.5),68.75, 68.75);
    numbacklay.cornerRadius = 5;
    [base2Layer addSublayer:numbacklay];
    [base2Layer setValue:numbacklay forKey:[NSString stringWithFormat:@"%d",makex+makey*4]];
    
    CATextLayer *numlay = [CATextLayer layer];
    numlay.alignmentMode = kCAAlignmentCenter;
    numlay.foregroundColor = [PanelColor GetTextColor:(popnum)].CGColor;
    //numlay.string = [NSString stringWithFormat:@"%d",popnum];
    numlay.string = [PanelFont GetShowNumber:popnum];
    numlay.fontSize = [PanelFont GetPanelFont:popnum];
    NSInteger aint = [PanelFont GetPanelAint:popnum];
    //numlay.frame = CGRectMake(0,12,68.75,44.75);
    numlay.frame = CGRectMake(0,aint,68.75,68.75-aint);
    
    [numbacklay addSublayer:numlay];
    
    /* 拡大・縮小 */
    
    // 拡大縮小を設定
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    
    // アニメーションのオプションを設定
    animation.duration = 0.18; // アニメーション速度
    animation.repeatCount = 0; // 繰り返し回数
    animation.autoreverses = NO; // アニメーション終了時に逆アニメーション
    
    // 拡大・縮小倍率を設定
    animation.fromValue = [NSNumber numberWithFloat:0.1]; // 開始時の倍率
    animation.toValue = [NSNumber numberWithFloat:1.0]; // 終了時の倍率
    
    // アニメーションを追加
    [numbacklay addAnimation:animation forKey:@"scale-layer"];
    
}


-(void)GameOver{
    NSLog(@"GameOver%lld",score);
    //ランク外のときは1000が入る
    NSInteger rank = [HighScore SetHighScore:(score)];
    
    if(rank!=1000){
        //左上から右に順番に入れていくためxとyが逆になっている
        NSMutableArray *marr = [NSMutableArray array];
        for(int y=0;y<4;y++){
            for(int x=0;x<4;x++){
                [marr addObject:[NSNumber numberWithUnsignedLongLong: numarr[x][y]]];
            }
        }
        NSArray *arr = marr;
        [HighScore SetDetailHighScore:(arr) Withrank:(rank)];
    }
    
    /*GameOver Animation */
    for(int y=0;y<4;y++){
        for(int x=0;x<4;x++){
            NSString *str = [NSString stringWithFormat:@"%d",x+y*4];
            CALayer *numbacklay = [base2Layer valueForKey:str];
            NSLog(@"%@",[numbacklay description]);
            CABasicAnimation *colorAnimation = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
            struct CGColor *fromColor = numbacklay.backgroundColor;
            UIColor *toColor = [UIColor grayColor];
            colorAnimation.duration = 1.0;
            colorAnimation.fromValue = (__bridge id)fromColor;
            colorAnimation.toValue = (id)toColor.CGColor;
            colorAnimation.removedOnCompletion = NO;
            colorAnimation.fillMode = kCAFillModeForwards;
            int z = x+y;
            if(z==6){
                NSLog(@"delegate");
                animex = 3;
                animey = 3;
                colorAnimation.delegate = self;
            }
            [numbacklay addAnimation:colorAnimation forKey:@"engray-layer"];
        }
    }
    /*GameOver Animation */

    
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"ToOption"]){
        //NSString *str = [NSString stringWithFormat:@"%ld",(long)row];
        [[segue destinationViewController] SendScore:(score)];
    }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([[segue identifier] isEqualToString:@"ToResult"]){
        //NSString *str = [NSString stringWithFormat:@"%ld",(long)row];
        [[segue destinationViewController] SendScore:(score) maxnumber:(maxnum)];
    }
}





-(void)OptionBtn:(UIButton*)button{
    
    [self performSegueWithIdentifier:@"ToOption" sender:self];
    //OptionVC *optionvc = [self.storyboard instantiateViewControllerWithIdentifier:@"Option"];
    //[self presentViewController:optionvc animated:NO completion:^{nil;}];
}

-(void)AkitaBtn:(UIButton*)button{
    CALayer *numbacklay = [CALayer layer];
    [base2Layer setValue:numbacklay forKey:[NSString stringWithFormat:@"%d",15]];
    [base2Layer addSublayer:numbacklay];
    [self GameOver];
}


- (IBAction)RestartWithReturnActionForSegue:(UIStoryboardSegue *)segue
{
    for (UIView* subview in self.view.subviews) {
        if(subview.tag == 10000){break;}//debugbutton
        [subview removeFromSuperview];
    }
    [self initLayer];
    [self Start];
}


//if other animation use delegate then if() sentence need
- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag
{
    NSLog(@"animetion:%@",[theAnimation description]);
    NSString *str = [NSString stringWithFormat:@"%ld",animex+animey*4];
    CALayer *numbacklay = [base2Layer valueForKey:str];
    
    if(theAnimation == [numbacklay animationForKey:@"move-layer"]){
        NSString *str = [NSString stringWithFormat:@"%ld",animex+animey*4];
        CALayer *numbacklay = [base2Layer valueForKey:str];
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    
        // アニメーションのオプションを設定
        animation.duration = 0.12; // アニメーション速度
        animation.repeatCount = 0; // 繰り返し回数
        animation.autoreverses = NO; // アニメーション終了時に逆アニメーション
    
        // 拡大・縮小倍率を設定
        animation.fromValue = [NSNumber numberWithFloat:1.0]; // 開始時の倍率
        animation.toValue = [NSNumber numberWithFloat:1.2]; // 終了時の倍率
    
        // アニメーションを追加
        [numbacklay addAnimation:animation forKey:@"scale-layer"];
        
    }else if(theAnimation == [numbacklay animationForKey:@"engray-layer"]){
        /* パネル分解アニメーション */
        for(int x=0;x<4;x++){
            for (int y=0;y<4;y++) {
                str = [NSString stringWithFormat:@"%d",x+y*4];
                CALayer *numbacklay = [base2Layer valueForKey:str];
                
                //移動アニメーション
                CABasicAnimation *animation1 =
                [CABasicAnimation animationWithKeyPath:@"position"];
                
                // 終点を設定
                CGPoint poi;
                int rndl;
                int rnds;
                if((x+y)%2){
                    rndl = arc4random() % 500;
                    rnds = ((rndl % 2) * 1000) - 500;
                    poi = CGPointMake(rnds,rndl);
                }else{
                    rndl = arc4random() % 400;
                    rnds = ((rndl % 2) * 1000 - 500);
                    poi = CGPointMake(rndl,rnds);
                }
                animation1.toValue = [NSNumber valueWithCGPoint:poi]; // 終点
                
                
                /* アニメーション2（z軸を中心として回転） */
                CABasicAnimation *animation2 =
                [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
                
                // 回転角度を設定
                animation2.fromValue = [NSNumber numberWithFloat:0.0]; // 開始時の角度
                animation2.toValue = [NSNumber numberWithFloat:4 * M_PI]; // 終了時の角度
                
                
                /* グループ */
                CAAnimationGroup *group = [CAAnimationGroup animation];
                
                // アニメーションのオプションを設定
                group.duration = 1.0;
                group.repeatCount = 1;
                group.removedOnCompletion = NO;
                group.fillMode = kCAFillModeForwards;
                int z = x+y;
                if(z==6){
                    NSLog(@"delegate");
                    animex = 3;
                    animey = 3;
                    group.delegate = self;
                }
                
                // アニメーションを追加
                group.animations = [NSArray arrayWithObjects:animation1, animation2, nil];
                [numbacklay addAnimation:group forKey:@"decompose-layer"];
            }
        }
        /* パネル分解アニメーション終わり*/
    }
    else if(theAnimation == [numbacklay animationForKey:@"decompose-layer"]){
        //ResultVCに遷移
        [self performSegueWithIdentifier:@"ToResult" sender:self];
    }
}





@end
