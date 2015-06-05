//
//  XLReferDetailViewController.m
//  LOL
//
//  Created by lanou3g on 14-7-27.
//  Copyright (c) 2014年 __许龙__. All rights reserved.
//

#import "XLReferDetailViewController.h"
#import "TFTJSONKit.h"
#import "XLReferMoreRecordViewController.h"
#import "XLReferCustomBackVIew.h"
#import "MONActivityIndicatorView.h"


@interface XLReferDetailViewController ()<MONActivityIndicatorViewDelegate>

@end

@implementation XLReferDetailViewController

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
    self.view.backgroundColor = WhiteColor;
   
 
    
    NSString *urlStr = [NSString stringWithFormat:@"http://lolbox.duowan.com/phone/playerDetail.php?playerName=%@&serverName=%@&sn=%@&target=%@&timestamp=1406354636&from=search&sk=92628711T",_summonerName,_summonerSeverName,_summonerSeverName,_summonerName];
    
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:urlStr];
      NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    UIWebView *searchWebView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    searchWebView.scrollView.bounces = NO;
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
    
    XLReferCustomBackVIew *customBackView = [[XLReferCustomBackVIew alloc]initWithFrame:CM(0, 528.0 / 568.0 * screen_H, screen_W, 40)];
    customBackView.backgroundColor = SandColor;
    [customBackView.backButton addTarget:self action:@selector(referDetailBackButton:) forControlEvents:UIControlEventTouchUpInside];
    [customBackView.backButton setFrame:CM(20,5, 30, 30)];
    [customBackView.backButton setImage:[UIImage imageNamed:@"iconfont-xiajiantou.png"] forState:UIControlStateNormal];
    [customBackView.shareButton addTarget:self action:@selector(shareDetailButton:) forControlEvents:UIControlEventTouchUpInside];
    //建立文件管理
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //找到Documents文件所在的路径
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //取得第一个Documents文件夹的路径
    NSString *filePath = [path firstObject];
    //把textPlist文件加入
    NSString *plistPath = [filePath stringByAppendingPathComponent:@"text.plist"];
    if ([fileManager fileExistsAtPath:plistPath]) {
        NSDictionary *referDic = [NSDictionary dictionaryWithContentsOfFile:plistPath];
        if ([_summonerName isEqualToString:[referDic objectForKey:@"name"]]) {
            [customBackView.shareButton setTitle:@"注销" forState:UIControlStateNormal];
        }
    }
    
    [customBackView.textButton addTarget:self action:@selector(moreRecordButton:) forControlEvents:UIControlEventTouchUpInside];
    [customBackView.textButton setFrame:CM(140, 0, 40, 40)];
    [customBackView.textButton setImage:[UIImage imageNamed:@"iconfont-gengduo.png"] forState:UIControlStateNormal];
     [self.view addSubview:customBackView];
    

    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CM(0,0 , 320, 50)];
    titleLabel.backgroundColor = BlackColor;
    titleLabel.textColor = WhiteColor;
    titleLabel.text = _titleName;
    titleLabel.font = Font(15);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleLabel];


    
    
    
    
    
}

//返回上一页面
- (void)referDetailBackButton:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        
        [[NSNotificationCenter defaultCenter]postNotificationName:NotificationOfDrawer object:self userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"kai",@"1", nil]];
     
    }];
}
//绑定按钮
- (void)shareDetailButton:(UIButton *)sender
{
    
    
    
    
    NSString *textString = @"";
    //建立文件管理
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //找到Documents文件所在的路径
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        //取得第一个Documents文件夹的路径
    NSString *filePath = [path firstObject];
    //把textPlist文件加入
    NSString *plistPath = [filePath stringByAppendingPathComponent:@"text.plist"];
    if ([fileManager fileExistsAtPath:plistPath]) {
       [fileManager createFileAtPath:plistPath contents:nil attributes:nil];
      }
    if ([sender.titleLabel.text isEqualToString:@"绑定"]) {
        //在写入数据之前，需要把要写入的数据先写入一个字典中，创建字典
        NSDictionary *dataDic = [NSDictionary dictionaryWithObjectsAndKeys:_summonerName,@"name",_summonerSeverName,@"severName", nil];
        //把数据写入plist文件
        [dataDic writeToFile:plistPath atomically:YES];
        [sender setTitle:@"注销" forState:UIControlStateNormal];
        textString = @"绑定成功!";
    }else if([sender.titleLabel.text isEqualToString:@"注销"]){
        [fileManager removeItemAtPath:plistPath error:nil];
        textString = @"注销成功!";
        [sender setTitle:@"绑定" forState:UIControlStateNormal];

    }
 
    UILabel *alterText = [[UILabel alloc]initWithFrame:CGRectMake(50.0 / 320.0  * screen_W, 350.0 / 568.0 * screen_H , 220, 30)];
    alterText.text = textString;
    alterText.font = [UIFont systemFontOfSize:15];
    alterText.textAlignment = NSTextAlignmentCenter;
    alterText.textColor = RedColor;
    [self.view addSubview:alterText];
    //渐隐
    [UIView animateWithDuration:1.5f animations:^{
        alterText.alpha = 0;
    }];
    //移除
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [alterText removeFromSuperview];
        
    });
    
    
 }

//查询更多实现
- (void)moreRecordButton:(UIButton *)sender
{
   
    XLReferMoreRecordViewController *_referMoreVC = [[XLReferMoreRecordViewController alloc]init];
    _referMoreVC.summonerName = _summonerName;
    _referMoreVC.summonerSeverName = _summonerSeverName;
    [self presentViewController:_referMoreVC animated:YES completion:^{
        
    }];
    
}
//uiwebView的代理方法
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    whatIs(error);
    [self dismissViewControllerAnimated:YES completion:^{
    }];
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
