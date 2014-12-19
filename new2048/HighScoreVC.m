//
//  HighScoreVC.m
//  new2048
//
//  Created by USER on 2014/04/30.
//  Copyright (c) 2014年 USER. All rights reserved.
//

#import "HighScoreVC.h"
#import "HighScore.h"
#import "PanelColor.h"
#import "PanelFont.h"

@interface HighScoreVC (){
    IBOutlet UIScrollView *scrollView;
    IBOutlet UIPageControl *pageControl;
}

@end

@implementation HighScoreVC
CGFloat kScrollObjHeight;//(※1)1pageの高さ
const CGFloat kScrollObjWidth  = 320.0;//(※2)1pageの幅
const NSUInteger kNumImages    = 5;    //(※3)総page数


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
    scrollView.scrollEnabled = YES;
    kScrollObjHeight = [[UIScreen mainScreen] applicationFrame].size.height;
    
    /*Set ScrollVoew */
    NSInteger i;
    CALayer *baseLayer = [scrollView layer];
    baseLayer.backgroundColor = [PanelColor GetBaseColor:@"base1"].CGColor;
    for (i = 0; i < kNumImages; i++)
    {
        /* HighScoreLayer */
        CATextLayer *scorelay = [CATextLayer layer];
        scorelay.string = [NSString stringWithFormat:@"HighScore:No%d\n%lld",i+1,[HighScore GetHighScore:i]];
        scorelay.fontSize = 24;
        scorelay.foregroundColor=[UIColor whiteColor].CGColor;
        scorelay.alignmentMode = kCAAlignmentCenter;
        scorelay.backgroundColor = [PanelColor GetBaseColor:@"darkgreen"].CGColor;
        scorelay.cornerRadius = 10;
        scorelay.frame = CGRectMake(20+(kScrollObjWidth*i), 30, 280, 70);
        [baseLayer addSublayer:scorelay];
        /* HighScoreLayer */
        
        /* light green layer */
        CALayer *base2Layer = [CALayer layer];
        base2Layer.backgroundColor = [PanelColor GetBaseColor:@"base2"].CGColor;
        base2Layer.frame = CGRectMake(10 + (kScrollObjWidth * i),kScrollObjHeight-350,300,300);
        base2Layer.cornerRadius = 5;
        [baseLayer addSublayer:base2Layer];
        /* light green layer */
        
        /*Block Layer*/
        NSArray *higharr = [HighScore GetDetailHighScore:i];
        for(int y=0;y<4;y++){
            for(int x=0;x<4;x++){
                unsigned long long blocknum = [higharr[x+y*4] intValue];
                CALayer *numbacklay = [CALayer layer];
                //0だった場合空白を
                if(blocknum == 0){
                    numbacklay.backgroundColor = [PanelColor GetBaseColor:@"base1"].CGColor;
                }else{
                    numbacklay.backgroundColor = [PanelColor GetColor:(blocknum)].CGColor;
                }
                numbacklay.frame = CGRectMake(5+(x*73.5),5+(y*73.5),68.75, 68.75);
                numbacklay.cornerRadius = 5;
                [base2Layer addSublayer:numbacklay];
                [base2Layer setValue:numbacklay forKey:[NSString stringWithFormat:@"%d",x+y*4]];
                
                if(blocknum != 0){
//                    CATextLayer *numlay = [CATextLayer layer];
//                    numlay.frame = CGRectMake(0,12,68.75,44.75);
//                    numlay.alignmentMode = kCAAlignmentCenter;
//                    numlay.foregroundColor = [UIColor blackColor].CGColor;
//                    numlay.string = [NSString stringWithFormat:@"%lld",blocknum];
//                    [numbacklay addSublayer:numlay];
                    
                    CATextLayer *numlay = [CATextLayer layer];
                    numlay.alignmentMode = kCAAlignmentCenter;
                    numlay.foregroundColor = [PanelColor GetTextColor:(blocknum)].CGColor;
                    numlay.string = [PanelFont GetShowNumber:blocknum];
                    numlay.fontSize = [PanelFont GetPanelFont:blocknum];
                    NSInteger aint = [PanelFont GetPanelAint:blocknum];
                    numlay.frame = CGRectMake(0,aint,68.75,68.75-aint);
                    [numbacklay addSublayer:numlay];
                }
            }
        }
        /*Block Layer*/
        
        /* BackButton */
        UIButton *Backbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        Backbtn.frame = CGRectMake(kScrollObjWidth*i, kScrollObjHeight-50, 120, 50);
        [Backbtn setTitle:@"Back" forState:UIControlStateNormal];
        [Backbtn.titleLabel setFont:[UIFont systemFontOfSize:20]];
        [Backbtn addTarget:self
                       action:@selector(BackBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self ShapeButton:Backbtn];
        [self.view addSubview:Backbtn];
        /* BackButton */
        
    }
    
    [self layoutScrollImages];
    pageControl.frame = CGRectMake(160,kScrollObjHeight-30,pageControl.frame.size.width,pageControl.frame.size.height);
    [self.view addSubview:pageControl];
    /*End Set ScrollView */
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//ScrollViewの設定
- (void)layoutScrollImages
{
    UIImageView *view = nil;
    NSArray *subviews = [scrollView subviews];
    
    CGFloat curXLoc = 0;
    for (view in subviews)
    {
        if ([view isKindOfClass:[UIImageView class]] && view.tag > 0)
        {
            CGRect frame = view.frame;
            frame.origin = CGPointMake(curXLoc, 0);
            view.frame = frame;
            
            curXLoc += (kScrollObjWidth);
        }
    }
    [scrollView setContentSize:CGSizeMake((kNumImages * kScrollObjWidth), kScrollObjHeight)];
}

//PageControllの設定
- (void)scrollViewDidScroll:(UIScrollView *)sender {
    CGFloat pageWidth = scrollView.frame.size.width;
    if (fmod(scrollView.contentOffset.x , pageWidth) == 0.0) {
        pageControl.currentPage = scrollView.contentOffset.x / pageWidth;
    }
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

-(void)BackBtn:(UIButton*)button{
    
    [self dismissViewControllerAnimated:(NO) completion:nil];
}














@end
