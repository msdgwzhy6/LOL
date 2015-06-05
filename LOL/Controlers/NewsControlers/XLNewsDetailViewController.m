//
//  XLNewsDetailViewController.m
//  LOL
//
//  Created by lanou3g on 14-7-25.
//  Copyright (c) 2014年 __许龙__. All rights reserved.
//

#import "XLNewsDetailViewController.h"
#import "TFTJSONKit.h"
#import "TFHpple.h"
#import "ArticleEngine.h"
#import "XLNewsDetailTitleView.h"
#import "XLCustomBackView.h"
#import "MONActivityIndicatorView.h"
#import <Frontia/Frontia.h>



@interface XLNewsDetailViewController ()<MONActivityIndicatorViewDelegate>

@end

@implementation XLNewsDetailViewController
{
    NSString *textString;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - MONActivityIndicatorViewDelegate Methods

- (UIColor *)activityIndicatorView:(MONActivityIndicatorView *)activityIndicatorView
      circleBackgroundColorAtIndex:(NSUInteger)index {
    CGFloat red   = (arc4random() % 256)/255.0;
    CGFloat green = (arc4random() % 256)/255.0;
    CGFloat blue  = (arc4random() % 256)/255.0;
    CGFloat alpha = 1.0f;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = SkyBlueColor;
    //活动指示器
    MONActivityIndicatorView *indicatorView = [[MONActivityIndicatorView alloc] init];
    indicatorView.tag = 170;
    indicatorView.delegate = self;
    indicatorView.numberOfCircles = 7;
    indicatorView.radius = 10;
    indicatorView.internalSpacing = 3;
    indicatorView.center = self.view.center;
    [indicatorView startAnimating];
    [self.view addSubview:indicatorView];
    
    
    [self getNewsDetailSource];
    
    



    UIPanGestureRecognizer *newsDetailPan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(newsDetailPan:)];
    [self.view addGestureRecognizer:newsDetailPan];

     
    //初始化Frontia
   // [Frontia initWithApiKey:APP_KEY];
}

- (void)newsDetailPan:(UIPanGestureRecognizer *)pangesture
{
    CGPoint point = [pangesture translationInView:self.view];
    if (point.x >= 90) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)getNewsDetailSource
{
    TFTJSONKit *newsDetailconnet = [[TFTJSONKit alloc]initWithGETRequestURL:[NSString stringWithFormat:@"http://lolbox.oss.aliyuncs.com/json/v3/news/content/%@.json",_newsId]];
    
    
    
     [newsDetailconnet didFinishUsingBlock:^(id jsonObject) {
         
         MONActivityIndicatorView *indicatorView = (MONActivityIndicatorView *)[self.view viewWithTag:170];
         [indicatorView stopAnimating];
         [indicatorView removeFromSuperview];
         
         NSString *htmlStr = [jsonObject objectForKey:@"content"];
         dispatch_async(dispatch_get_main_queue(), ^{
             //回到主线程更新UI
             UIWebView *view = [[UIWebView alloc]initWithFrame:CM(0, 60, screen_W, screen_H - 100)];
             view.scrollView.contentSize = Size(0, view.scrollView.contentSize.height + 40);
             view.scalesPageToFit=YES;
              view.backgroundColor = [UIColor whiteColor];
             [view setOpaque:NO];
             
             view.tag = 151;
             NSString *str1 = [NSString stringWithFormat:@"<html> \n"
                              "<head> \n"
                              "<style type=\"text/css\"> \n"
                              "body {font-size: %f;}\n"
                              "</style> \n"
                              "</head> \n"
                              "<body>%@</body> \n"
                               "</html>", 30.0, htmlStr];
             //   "img {width:280;hight:210}\n"改变图片大小
             view.scrollView.bounces=YES;
             view.scrollView.delegate = self;
              [view loadHTMLString:str1 baseURL:nil];
            
             //观察者
             [view.scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
             [self.view addSubview:view];
             
             XLNewsDetailTitleView *_newsDeTitleView = [[XLNewsDetailTitleView alloc]initWithFrame:CM(0, 0, screen_W, 60 )];
             _newsDeTitleView.backgroundColor = SkyBlueColor;
             _newsDeTitleView.tag = 150;
             textString = [jsonObject objectForKey:@"title"];
        _newsDeTitleView.titleOfNewsDeLabel.text = [jsonObject objectForKey:@"title"];
             _newsDeTitleView.postOfNewsDeLabel.text = [NSString stringWithFormat:@"发布时间:%@",[jsonObject objectForKey:@"posttime"]];
             _newsDeTitleView.siteOfNewsDeLabel.text = [NSString stringWithFormat:@"来源:%@",[jsonObject objectForKey:@"site"]];
             [self.view addSubview:_newsDeTitleView];
             
             //自定义视图footer视图
             XLCustomBackView *customBackView = [[XLCustomBackView alloc]initWithFrame:CM(0, screen_H - 40, screen_W, 40)];
             customBackView.backgroundColor = SandColor;
             [customBackView.backButton addTarget:self action:@selector(customBackButton:) forControlEvents:UIControlEventTouchUpInside];
             [customBackView.backButton setFrame:CM(10,7.5, 25, 25)];
             [customBackView.backButton setImage:[UIImage imageNamed:@"iconfont-zuojiantou.png"] forState:UIControlStateNormal];
               [customBackView.shareButton addTarget:self action:@selector(customShareButton:) forControlEvents:UIControlEventTouchUpInside];
             [customBackView.shareButton setFrame:CM(275, 2.5, 35, 35)];
             [customBackView.shareButton setImage:[UIImage imageNamed:@"iconfont-fenxiang-2.png"] forState:UIControlStateNormal];
             customBackView.textLabel.text = @"资讯详情";
             [self.view addSubview:customBackView];
             
         });
    }];
}
//返回上一个页面
- (void)customBackButton:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
//分享
- (void)customShareButton:(UIButton *)sender
{
    whatIs(@"分享");
    /*
    FrontiaShare *share = [Frontia getShare];
    
    [share registerQQAppId:@"100358052" enableSSO:NO];
    [share registerWeixinAppId:@"wx712df8473f2a1dbe"];
    
    //授权取消回调函数
    FrontiaShareCancelCallback onCancel = ^(){
        NSLog(@"OnCancel: share is cancelled");
    };
    
    //授权失败回调函数
    FrontiaShareFailureCallback onFailure = ^(int errorCode, NSString *errorMessage){
        NSLog(@"OnFailure: %d  %@", errorCode, errorMessage);
    };
    
    //授权成功回调函数
    FrontiaMultiShareResultCallback onResult = ^(NSDictionary *respones){
        NSLog(@"OnResult: %@", [respones description]);
    };
    
    FrontiaShareContent *content=[[FrontiaShareContent alloc] init];
    content.url = @"http://developer.baidu.com/soc/share";
    content.title = @"社会化分享";
    //分享的文字
    content.description = textString;
    //分享的图片链接
    content.imageObj = @"http://apps.bdimg.com/developer/static/04171450/developer/images/icon/terminal_adapter.png";
    
    NSArray *platforms = @[FRONTIA_SOCIAL_SHARE_PLATFORM_SINAWEIBO,FRONTIA_SOCIAL_SHARE_PLATFORM_QQWEIBO,FRONTIA_SOCIAL_SHARE_PLATFORM_QQ,FRONTIA_SOCIAL_SHARE_PLATFORM_RENREN,FRONTIA_SOCIAL_SHARE_PLATFORM_KAIXIN,FRONTIA_SOCIAL_SHARE_PLATFORM_EMAIL,FRONTIA_SOCIAL_SHARE_PLATFORM_SMS];
    
    [share showShareMenuWithShareContent:content displayPlatforms:platforms supportedInterfaceOrientations:UIInterfaceOrientationMaskPortrait isStatusBarHidden:NO targetViewForPad:sender cancelListener:onCancel failureListener:onFailure resultListener:onResult];
     */
}

//观察者
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    
    UIScrollView *scrollView = object;
    CGPoint point = scrollView.contentOffset;
    UIWebView *webView = (UIWebView *)[self.view viewWithTag:151];
    
    
    if (point.y < 40 && point.y > 0) {
        UIView *aView = [self.view viewWithTag:150];
        [UIView animateWithDuration:0.5f animations:^{
            aView.alpha = 1;

        }];
        webView.frame = CM(0, 20 + 40 - point.y, screen_W, screen_H - 60);
         
         }else if (point.y >= 40) {
        UIView *aView = [self.view viewWithTag:150];
             [UIView animateWithDuration:0.5f animations:^{
                 aView.alpha = 0;

             }];
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
