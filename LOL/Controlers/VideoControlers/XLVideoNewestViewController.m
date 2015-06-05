//
//  XLVideoNewestViewController.m
//  LOL
//
//  Created by lanou3g on 14-7-24.
//  Copyright (c) 2014年 __许龙__. All rights reserved.
//

#import "XLVideoNewestViewController.h"
#import "XLVideoTableViewCell.h"
#import "XLVideoNewestObject.h"
#import "TFTJSONKit.h"
#import "UIImageView+WebCache.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import "XLJsonManager.h"
#import "MJRefresh.h"
#import "MONActivityIndicatorView.h"
#import "XLCustomBackView.h"



@interface XLVideoNewestViewController ()<MONActivityIndicatorViewDelegate>

@property (nonatomic,strong)NSMutableArray *videoNewestArray;//最新视频数据数组

@property (nonatomic,strong)UITableView *newestTableView;




@end

@implementation XLVideoNewestViewController
{
     MJRefreshHeaderView *_headerOfVideoNewest;
    BOOL isHiddenStatusBar;
    UIButton *whiteView;
    UIButton *blackView;
    MPMoviePlayerViewController *player;
    UIPanGestureRecognizer *_videoDePan;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
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
    
    [self getNewestVideoDataSource];
    
 
    
    //添加轻扫手势
        _videoDePan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(videoDePan:)];
     [self.view addGestureRecognizer:_videoDePan];
    
    
    //滑动动画
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.tag = 160;
    button1.frame = CM(0, 0, screen_W,  screen_H / 2 - 20);
    button1.backgroundColor = SkyBlueColor;
    [button1 setTitle:@"最新视频" forState:UIControlStateNormal];
    [button1 setTitleColor:BlackColor forState:UIControlStateNormal];
    button1.titleLabel.font = Font(15);
     [self.view addSubview:button1];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.tag = 161;
    button2.frame = CM(0, screen_H / 2 - 20, screen_W, screen_H / 2 - 20);
    button2.backgroundColor = SandColor;
    [button2 setTitle:@"解说视频" forState:UIControlStateNormal];
    [button2 setTitleColor:WhiteColor forState:UIControlStateNormal];
    button2.titleLabel.font = Font(15);
     [self.view addSubview:button2];
    
    XLCustomBackView *_videoNewesBackView = [[XLCustomBackView alloc]initWithFrame:CM(0, screen_H - 40, screen_W, 40)];
    _videoNewesBackView.backgroundColor = SandColor;
     [_videoNewesBackView.backButton addTarget:self action:@selector(videoNewestBack:) forControlEvents:UIControlEventTouchUpInside];
    [_videoNewesBackView.backButton setFrame:CM(20,5, 30, 30)];
    [_videoNewesBackView.backButton setImage:[UIImage imageNamed:@"iconfont_liebiao_1.png"] forState:UIControlStateNormal];
    _videoNewesBackView.shareButton.hidden = YES;
    [self.view addSubview:_videoNewesBackView];
    
    
    [UIView animateWithDuration:1.0 animations:^{
        button1.frame = CM(0, 0, screen_W, 0);
        button2.frame = CM(0, screen_H, screen_W, 0);
          } completion:^(BOOL finished) {
        if (finished) {
            button1.alpha = 0;
            button2.alpha = 0;
            _videoNewesBackView.textLabel.text = @"最新视频";
            [_videoNewesBackView.backButton setFrame:CM(20,7.5, 25, 25)];
            [_videoNewesBackView.backButton setImage:[UIImage imageNamed:@"iconfont-zuojiantou.png"] forState:UIControlStateNormal];

         }
    }];
    
    
    
    
    
}


//返回上一页面
- (void)videoNewestBack:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
            [[NSNotificationCenter defaultCenter]postNotificationName:NotificationOfDrawer object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"kai",@"1", nil]];
         [[NSNotificationCenter defaultCenter]postNotificationName:NotificationOfDrawer object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"showBar",@"1", nil]];
}];
}

- (void)videoDePan:(UIPanGestureRecognizer *)pangesture
{
    CGPoint point = [pangesture translationInView:self.view];
    if (point.x >= 90) {
        [self dismissViewControllerAnimated:YES completion:^{
                [[NSNotificationCenter defaultCenter]postNotificationName:NotificationOfDrawer object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"kai",@"1", nil]];
             [[NSNotificationCenter defaultCenter]postNotificationName:NotificationOfDrawer object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"showBar",@"1", nil]];
        }];
    }
}

- (void )getNewestVideoDataSource
{
    TFTJSONKit *_newestVideoCon = [[TFTJSONKit alloc]initWithGETRequestURL:VideoNewestPort];
    [_newestVideoCon didFinishUsingBlock:^(id jsonObject) {
        
        MONActivityIndicatorView *indicatorView = (MONActivityIndicatorView *)[self.view viewWithTag:170];
        [indicatorView stopAnimating];
        
        XLJsonManager *manager = [XLJsonManager jsonDefault];
        self.videoNewestArray = [NSMutableArray arrayWithArray:[manager videoArrayWithJson:jsonObject]];
        //得到数据源。回到主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            self.newestTableView = [[UITableView alloc]initWithFrame:CM(0, 20, screen_W, 508.0 / 568.0 *screen_H)];
            _newestTableView.delegate = self;
            _newestTableView.dataSource = self;
            [_newestTableView registerClass:[XLVideoTableViewCell class] forCellReuseIdentifier:NewestVideoIdentifier];
            [self.view addSubview:_newestTableView];
            UIButton *button = (UIButton *)[self.view viewWithTag:160];
            
            [self.view insertSubview:_newestTableView belowSubview:button];

            //刷新方法
            [_newestTableView addHeaderWithTarget:self action:@selector(headerOfVideoNewestAction)];
         });
     }];
}

//最新视频的下拉刷新
- (void)headerOfVideoNewestAction
{
    
    TFTJSONKit *_newestVideoCon = [[TFTJSONKit alloc]initWithGETRequestURL:VideoNewestPort];
    [_newestVideoCon didFinishUsingBlock:^(id jsonObject) {
        XLJsonManager *manager = [XLJsonManager jsonDefault];
        _videoNewestArray = [manager videoArrayWithJson:jsonObject];
        //得到数据源。回到主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            [_newestTableView reloadData];
            [_newestTableView headerEndRefreshing];
        });
    }];

}



//TableView的代理方法
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XLVideoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NewestVideoIdentifier forIndexPath:indexPath];
    XLVideoNewestObject *_videoNewsObject = [_videoNewestArray objectAtIndex:indexPath.row];
    [cell.titleImageView sd_setImageWithURL:[NSURL URLWithString:_videoNewsObject.videoImg]];
    cell.titleLabel.text = _videoNewsObject.videoName;
    cell.postLabel.text = [NSString stringWithFormat:@"更新时间:%@",_videoNewsObject.videoTime];
    cell.timeLegthLabel.text = [NSString stringWithFormat:@"时长:%@",_videoNewsObject.videoLength];
    
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _videoNewestArray.count;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    _videoDePan.enabled = NO;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NotificationOfDrawer object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"hiddenBar",@"1" ,nil]];
    

    XLVideoNewestObject *_videoNewsObject = [_videoNewestArray objectAtIndex:indexPath.row];
    
    
    NSURL *url = [NSURL URLWithString:_videoNewsObject.video_addr_url];
        player = [[MPMoviePlayerViewController alloc]init];
    
    [player.moviePlayer setMovieSourceType:MPMovieSourceTypeFile];
    [player.moviePlayer setContentURL:url];
    [player.moviePlayer setControlStyle:MPMovieControlStyleFullscreen];
    
    player.view.frame = CM(0, 0, self.view.bounds.size.height, self.view.bounds.size.width);
    player.view.center = Point(self.view.bounds.size.width/2, self.view.bounds.size.height/2);
    CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI_2);
    [player.view setTransform:transform];
    
     
    [self.view addSubview:player.view];

//    [self presentMoviePlayerViewControllerAnimated:player];
    [player.moviePlayer play];

    /*
        NSURL *movieURL = [NSURL fileURLWithPath:_videoNewsObject.video_addr_url];
        
        MPMoviePlayerController *movewController =[[MPMoviePlayerController alloc] initWithContentURL:movieURL];
        
        [movewController prepareToPlay];
    
    movewController.view.frame = CM(0, 0, self.view.bounds.size.height, self.view.bounds.size.width);
    movewController.view.center = Point(self.view.bounds.size.width/2, self.view.bounds.size.height/2);
    CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI_2);
    [movewController.view setTransform:transform];
    
         [self.view addSubview:movewController.view];//设置写在添加之后   // 这里是addSubView
        movewController.shouldAutoplay=YES;
        [movewController setControlStyle:MPMovieControlStyleDefault];
        [movewController setFullscreen:YES];
        [movewController.view setFrame:self.view.bounds];
    
    */
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(movieFinishedCallBack:) name:MPMoviePlayerPlaybackDidFinishNotification object:player.moviePlayer];
    
 
    
    
    /*
    //AVPlayerLayer 播放在线视频
   
   
        AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:_videoNewsObject.video_addr_url]];
    
    AVPlayer *player = [AVPlayer playerWithPlayerItem:playerItem];
    
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
    
    playerLayer.frame = self.view.layer.bounds;
    
    playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    
    [self.view.layer addSublayer:playerLayer];
    
    [player play];
  */
    
    /*
    //UIWebView 加在网络视频 在线播放  有声音
    
    UIWebView *myWeb = [[UIWebView alloc] initWithFrame:self.view.bounds];
    
    NSURL *url = [NSURL URLWithString:_videoNewsObject.video_addr_url];
                  
                  NSURLRequest *request = [NSURLRequest requestWithURL:url];
                  myWeb.delegate = self;
                  [myWeb loadRequest:request];
                  [self.view addSubview:myWeb];
    */
    
}




- (void)movieFinishedCallBack:(NSNotification *)notifition
{
    _videoDePan.enabled = YES;
       [[NSNotificationCenter defaultCenter]postNotificationName:NotificationOfDrawer object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"showBar",@"1", nil]];
    //视频播放玩或者按下done按钮时的响应方法
    MPMoviePlayerController *theMovie = notifition.object;
  [[NSNotificationCenter defaultCenter]removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:theMovie];
    [player.view removeFromSuperview];
   // [theMovie.view removeFromSuperview];
 
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
