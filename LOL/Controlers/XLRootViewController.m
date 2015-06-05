//
//  XLRootViewController.m
//  LOL
//
//  Created by lanou3g on 14-7-19.
//  Copyright (c) 2014年 __许龙__. All rights reserved.
//

#import "XLRootViewController.h"
#import "XLHerosViewController.h"
#import "XLReferViewController.h"
#import "XLSetViewController.h"


#define shadowImageView_width 25.0

@interface XLRootViewController ()

@property (nonatomic,strong)XLDrawerViewController *drawerVC;//抽屉视图

@property (nonatomic,strong)XLNewsViewController *newsVC;//新闻资讯视图

@property (nonatomic,strong)XLVideoViewController *videoVC;//视频视图

@property (nonatomic,strong)XLHerosViewController *herosVC;//英雄视图

@property (nonatomic,strong)XLReferViewController *referVC;//查询视图

@property (nonatomic,strong)XLSetViewController *setVC;//设置视图

@property (nonatomic,strong)UIScrollView *scrollView;//滑动视图

@property (nonatomic,strong)UIImageView *shadowImageViewOne;//阴影视图
//阴影视图
@property (nonatomic,strong)UIImageView *shadowImageViewTwo;
@property (nonatomic,strong)UIImageView *shadowImageViewThree;
@property (nonatomic,strong)UIImageView *shadowImageViewFourth;
@property (nonatomic,strong)UIImageView *shadowImageViewFive;



@end

@implementation XLRootViewController
{
    UIViewController* temp;
    BOOL isHiddenStatusBar;
    UIView *aView;
}

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
    
     
    
    self.shadowImageViewOne=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, shadowImageView_width, screen_H)];
    _shadowImageViewOne.image=[UIImage imageNamed:@"shadow"];
    _shadowImageViewOne.alpha=.5;
    
    self.shadowImageViewTwo=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, shadowImageView_width, screen_H)];
    _shadowImageViewTwo.image=[UIImage imageNamed:@"shadow"];
    _shadowImageViewTwo.alpha=.5;
    
    self.shadowImageViewThree=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, shadowImageView_width, screen_H)];
    _shadowImageViewThree.image=[UIImage imageNamed:@"shadow"];
    _shadowImageViewThree.alpha=.5;
    
    self.shadowImageViewFourth=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, shadowImageView_width, screen_H)];
    _shadowImageViewFourth.image=[UIImage imageNamed:@"shadow"];
    _shadowImageViewFourth.alpha=.5;
    
    self.shadowImageViewFive=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, shadowImageView_width, screen_H)];
    _shadowImageViewFive.image=[UIImage imageNamed:@"shadow"];
    _shadowImageViewFive.alpha=.5;
    
    self.view.backgroundColor = SkyBlueColor;
 
    self.navigationController.navigationBarHidden = YES;
    //抽屉控制器
    self.drawerVC = [[XLDrawerViewController alloc]init];
     _drawerVC.view.frame =  CM(0, 0, 200.0 / 320.0 * screen_W, screen_H);
     _drawerVC.delegate = self;

    [self addChildViewController:_drawerVC];
    
    //新闻控制器
    self.newsVC = [[XLNewsViewController alloc]init];
     _newsVC.view.backgroundColor = [UIColor whiteColor];
    [_newsVC.backButton addTarget:self action:@selector(leftButtonAction:) forControlEvents:UIControlEventTouchUpInside];
     _newsVC.view.frame = CM(200.0 / 320.0 * screen_W, 0, screen_W, screen_H);
    _newsVC.delegate = self;
    [self addChildViewController:_newsVC];
    
    
    temp = _newsVC;
    
    //承载抽屉和新闻控制器的滑动视图
    self.scrollView = [[UIScrollView alloc]initWithFrame:CM(0, -20, screen_W, screen_H + 20)];
    _scrollView.contentSize = CGSizeMake(screen_W + 200.0/320.0 * screen_W, 0);
    _scrollView.bounces = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_scrollView];
    _scrollView.pagingEnabled = YES;
    [_newsVC.view addSubview:_shadowImageViewOne];
    _scrollView.delegate = self;
    [_scrollView addSubview:_drawerVC.view];
    //[_scrollView addSubview:self.shadowImageView];
    [_scrollView addSubview:_newsVC.view];
    [_scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    
    _scrollView.contentOffset = CGPointMake(200.0 /320.0 * screen_W, 0);
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notification:) name:NotificationOfDrawer object:nil];

    aView = [[UIView alloc]initWithFrame:self.view.bounds];
    aView.backgroundColor = BlackColor;
    
}

//抽屉视图出现与消失
- (void)leftButtonAction:(UIButton *)sender
{
    if (_scrollView.contentOffset.x == 200.0 /320.0 * screen_W) {
        [UIView animateWithDuration:0.3f animations:^{
            _scrollView.contentOffset = CGPointMake(0, -20);
        }];
        
    } else {
        [UIView animateWithDuration:0.3f animations:^{
            _scrollView.contentOffset = CGPointMake(200.0 /320.0 * screen_W, -20);
        }];
    }
    
    
}
//通知中心方法
- (void)notification:(NSNotification *)sender
{
    whatIs(sender.userInfo);
     if ([[sender.userInfo objectForKey:@"1"] isEqualToString:@"kai"]){
        _scrollView.scrollEnabled = YES;
    }
    else if ([[sender.userInfo objectForKey:@"1"] isEqualToString:@"guan"]) {
        _scrollView.scrollEnabled = NO;
     } else if([[sender.userInfo objectForKey:@"1"] isEqualToString:@"hiddenBar"]){
        [self hideStatusBar];
         run;
     }else if([[sender.userInfo objectForKey:@"1"] isEqualToString:@"showBar"]){
         [self showStatusBar];
     }else if ([[sender.userInfo objectForKey:@"1"] isEqualToString:@"drawer"]){
         [self leftButtonAction:nil];
     } else if([[sender.userInfo objectForKey:@"1"] isEqualToString:@"offDrawer"]){
         if (_scrollView.contentOffset.x == 0) {
             [UIView animateWithDuration:0.3f animations:^{
                 _scrollView.contentOffset = CGPointMake(200.0 /320.0 * screen_W, -20);
             }];
         }
     }
    
}


//XLDrawerViewDelegate代理方法
- (void)clickItemsAction:(NSIndexPath *)indexPath
{
    
    switch (indexPath.row) {
        case 0:
        {
            if (temp != nil) {
                [temp removeFromParentViewController];
                [temp.view removeFromSuperview];
                temp = nil;
            }
            self.newsVC = [[XLNewsViewController alloc]init];
            _newsVC.view.backgroundColor = [UIColor whiteColor];
            [_newsVC.backButton addTarget:self action:@selector(leftButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            _newsVC.view.frame = CM(200.0 / 320.0 * screen_W, 0, screen_W, screen_H);
            _newsVC.delegate = self;
            [_newsVC.view addSubview:_shadowImageViewOne];
            [self addChildViewController:_newsVC];
            [_scrollView addSubview:_newsVC.view];
            temp = _newsVC;
            [UIView animateWithDuration:0.3f animations:^{
                _scrollView.contentOffset = CGPointMake(200.0 /320.0 * screen_W, -20);
            }];
            
        }
            break;
        case 1:
        {
            if (temp != nil) {
                [temp removeFromParentViewController];
                [temp.view removeFromSuperview];
                temp = nil;
            }
             self.videoVC = [[XLVideoViewController alloc]init];
             _videoVC.view.frame = CM(200.0 / 320.0 * screen_W, 0, screen_W, screen_H);
            [_scrollView addSubview:_videoVC.view];
            temp = _videoVC;
            [_videoVC.view addSubview:_shadowImageViewTwo];
            [self addChildViewController:_videoVC];
            [UIView animateWithDuration:0.3f animations:^{
                _scrollView.contentOffset = CGPointMake(200.0 /320.0 * screen_W, -20);
            }];

        }
            break;
        case 2:
        {
            if (temp != nil) {
                [temp removeFromParentViewController];
                [temp.view removeFromSuperview];
                temp = nil;
            }
            self.herosVC = [[XLHerosViewController alloc]init];
            _herosVC.view.frame = CM(200.0 / 320.0 * screen_W, 0, screen_W, screen_H);
            temp = _herosVC;
            [self addChildViewController:_herosVC];
            [_scrollView addSubview:_herosVC.view];
            [_herosVC.view addSubview:_shadowImageViewThree];
            [UIView animateWithDuration:0.3f animations:^{
                _scrollView.contentOffset = CGPointMake(200.0 /320.0 * screen_W, -20);
            }];
        }
            break;
        case 3:
        {
            if (temp != nil) {
                [temp removeFromParentViewController];
                [temp.view removeFromSuperview];
                temp = nil;
            }
            self.referVC = [[XLReferViewController alloc]init];
            _referVC.view.frame = CM(200.0 / 320.0 * screen_W, 0, screen_W, screen_H);
            temp = _referVC;
            [self addChildViewController:_referVC];
            [_scrollView addSubview:_referVC.view];
            [_referVC.view addSubview:_shadowImageViewFourth];
            [UIView animateWithDuration:0.3f animations:^{
                _scrollView.contentOffset = CGPointMake(200.0 /320.0 * screen_W, -20);
            }];
        }
            break;
        case 4:
        {
            if (temp != nil) {
                [temp removeFromParentViewController];
                [temp.view removeFromSuperview];
                temp = nil;
            }
            self.setVC = [[XLSetViewController alloc]init];
            _setVC.view.frame = CM(200.0 / 320.0 * screen_W, 0, screen_W, screen_H);
            temp = _setVC;
            [self addChildViewController:_setVC];
            [_scrollView addSubview:_setVC.view];
            [_setVC.view addSubview:_shadowImageViewFive];
            [UIView animateWithDuration:0.3f animations:^{
                _scrollView.contentOffset = CGPointMake(200.0 /320.0 * screen_W, -20);
            }];
        }
            break;
        default:
            break;
    }
    
    
    
    
    
    
}
//XLNewsViewControllerDelegate代理方法  实现当出现抽屉时，点击新闻的单元格把抽屉回收
- (void)clickNewsCellAction:(NSIndexPath *)indexPath
{
     if (_scrollView.contentOffset.x == 0) {
        [UIView animateWithDuration:0.5f animations:^{
            _scrollView.contentOffset = CGPointMake(200.0 /320.0 * screen_W, -20);
        }];
        
    }
}

//观察者响应方法 实现出现抽屉时，把新闻的scrollView禁止滑动
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
      UIScrollView *tempscroll = object;
    _shadowImageViewOne.alpha = ( 200 - tempscroll.contentOffset.x )/ 300;
    _shadowImageViewTwo.alpha = ( 200 - tempscroll.contentOffset.x )/ 300;
    _shadowImageViewThree.alpha = ( 200 - tempscroll.contentOffset.x )/ 300;
    _shadowImageViewFourth.alpha = ( 200 - tempscroll.contentOffset.x )/ 300;
    _shadowImageViewFive.alpha = ( 200 - tempscroll.contentOffset.x )/ 300;

    if (tempscroll.contentOffset.x == 0) {//抽屉出来
        _newsVC.scrollView.scrollEnabled = NO;
     } else if (tempscroll.contentOffset.x <= 198) {
         
     }
    else if(tempscroll.contentOffset.x == 200) {//抽屉关闭
        _newsVC.scrollView.scrollEnabled = YES;
        //[aView removeFromSuperview];
     }
    
    
}


- (BOOL)prefersStatusBarHidden
{
    return isHiddenStatusBar;
}

- (void)showStatusBar
{
    isHiddenStatusBar = NO;
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        [self prefersStatusBarHidden];
        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    }
}

- (void)hideStatusBar
{
    isHiddenStatusBar = YES;
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        [self prefersStatusBarHidden];
        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
