//
//  XLReferMoreRecordViewController.m
//  LOL
//
//  Created by lanou3g on 14-7-27.
//  Copyright (c) 2014年 __许龙__. All rights reserved.
//

#import "XLReferMoreRecordViewController.h"
#import "XLCustomBackView.h"
#import "MONActivityIndicatorView.h"

@interface XLReferMoreRecordViewController ()<MONActivityIndicatorViewDelegate>

@end

@implementation XLReferMoreRecordViewController

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
    
    NSString *urlStr = [NSString stringWithFormat:@"http://lolbox.duowan.com/phone/matchList_ios.php?playerName=%@&serverName=%@",_summonerName,_summonerSeverName];
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    UIWebView *searchWebView = [[UIWebView alloc]initWithFrame:CM(0, 0, screen_W, screen_H - 40)];
    searchWebView.delegate = self;
    [searchWebView loadRequest:request];
    [self.view addSubview:searchWebView];

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
    
    
    XLCustomBackView *customBackView = [[XLCustomBackView alloc]initWithFrame:CM(0, 528.0 / 568.0 * screen_H, screen_W, 40)];
    customBackView.backgroundColor = SandColor;
    [customBackView.backButton addTarget:self action:@selector(referMoreDetailBackButton:) forControlEvents:UIControlEventTouchUpInside];
    [customBackView.backButton setFrame:CM(20,5, 30, 30)];
    [customBackView.backButton setImage:[UIImage imageNamed:@"iconfont-xiajiantou.png"] forState:UIControlStateNormal];
    customBackView.shareButton.hidden = YES;
    customBackView.textLabel.text = @"";
    [self.view addSubview:customBackView];


}

//返回上一页面
- (void)referMoreDetailBackButton:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:^{

    }];
}
//分享按钮
- (void)shareMoreDetailButton:(UIButton *)sender
{
    whatIs(@"fenxiabng");
}

//加载完成
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    MONActivityIndicatorView *indicatorView = (MONActivityIndicatorView *)[self.view viewWithTag:170];
    [indicatorView stopAnimating];
    [indicatorView removeFromSuperview];
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
