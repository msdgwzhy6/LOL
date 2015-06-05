//
//  XLNarrateDetailVideoViewController.m
//  LOL
//
//  Created by lanou3g on 14-7-28.
//  Copyright (c) 2014年 __许龙__. All rights reserved.
//

#import "XLNarrateDetailVideoViewController.h"
#import "XLVideoTableViewCell.h"
#import "XLVideoNewestObject.h"
#import "TFTJSONKit.h"
#import "UIImageView+WebCache.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import "XLJsonManager.h"
#import "Reachability.h"
#import "MJRefresh.h"
#import "MONActivityIndicatorView.h"
#import "XLCustomBackView.h"

@interface XLNarrateDetailVideoViewController ()<MONActivityIndicatorViewDelegate>

@property (nonatomic,strong)NSMutableArray *videoNarratertArray;//最新视频数据数组

@property (nonatomic,strong)UITableView *narraterTableView;

@property (nonatomic,strong)Reachability *hostReach;

@end

@implementation XLNarrateDetailVideoViewController
{
    NSInteger numberOfNarrater;
    MJRefreshHeaderView *_headerOfNarrater;
    MJRefreshFooterView *_footerOfNarrater;
    UIPanGestureRecognizer *videoDePan;
    MPMoviePlayerViewController *player;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        numberOfNarrater = 1;
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
    
    
    XLCustomBackView *_videoNarraterDeBackView = [[XLCustomBackView alloc]initWithFrame:CM(0, screen_H - 40, screen_W, 40)];
    _videoNarraterDeBackView.backgroundColor = SandColor;
    _videoNarraterDeBackView.tag = 171;
    [_videoNarraterDeBackView.backButton addTarget:self action:@selector(videoNarraterDetailBack:) forControlEvents:UIControlEventTouchUpInside];
    [_videoNarraterDeBackView.backButton setFrame:CM(20,5, 30, 30)];
    [_videoNarraterDeBackView.backButton setImage:[UIImage imageNamed:@"iconfont-xiajiantou.png"] forState:UIControlStateNormal];
    _videoNarraterDeBackView.shareButton.hidden = YES;
    _videoNarraterDeBackView.textLabel.text = [NSString stringWithFormat:@"%@视频列表",_narratName];
    [self.view addSubview:_videoNarraterDeBackView];
    
    
    [self getNarraterVideoDataSource];
    
    
    
    
    //添加轻扫手势
     videoDePan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(videoDePan:)];
    [self.view addGestureRecognizer:videoDePan];
    
    
    
}



- (void)videoNarraterDetailBack:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

- (void)videoDePan:(UIPanGestureRecognizer *)pangesture
{
    
    CGPoint point = [pangesture translationInView:self.view];
    if (point.x >= 90) {
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }
}

- (void )getNarraterVideoDataSource
{
    TFTJSONKit *_newestVideoCon = [[TFTJSONKit alloc]initWithGETRequestURL:[NSString stringWithFormat:@"http://lolbox.oss.aliyuncs.com/json/v4/video/videolist_2_%@_1.json?r=772632",_narratId]];
    [_newestVideoCon didFinishUsingBlock:^(id jsonObject) {
        
        MONActivityIndicatorView *indicatorView = (MONActivityIndicatorView *)[self.view viewWithTag:170];
        [indicatorView stopAnimating];
        
        XLJsonManager *jsonManager = [XLJsonManager jsonDefault];
        self.videoNarratertArray = [NSMutableArray arrayWithArray:[jsonManager videoArrayWithJson:jsonObject]];
          //得到数据源。回到主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            self.narraterTableView = [[UITableView alloc]initWithFrame:CM(0, 20, screen_W,  screen_H - 60)];
            _narraterTableView.delegate = self;
            _narraterTableView.dataSource = self;
            [_narraterTableView registerClass:[XLVideoTableViewCell class] forCellReuseIdentifier:NewestVideoIdentifier];
            [self.view addSubview:_narraterTableView];
            //刷新
            _headerOfNarrater = [[MJRefreshHeaderView alloc]init];
            [_narraterTableView addHeaderWithTarget:self action:@selector(headerOfNarraterAction)];
            _footerOfNarrater = [[MJRefreshFooterView alloc]init];
            [_narraterTableView addFooterWithTarget:self action:@selector(footerOfNarraterAction)];
            
        });
    }];
}
//下拉
- (void)headerOfNarraterAction
{
    TFTJSONKit *_newestVideoCon = [[TFTJSONKit alloc]initWithGETRequestURL:[NSString stringWithFormat:@"http://lolbox.oss.aliyuncs.com/json/v4/video/videolist_2_%@_1.json?r=772632",_narratId]];
    [_newestVideoCon didFinishUsingBlock:^(id jsonObject) {
        XLJsonManager *jsonManager = [XLJsonManager jsonDefault];
        _videoNarratertArray = [jsonManager videoArrayWithJson:jsonObject];
        //得到数据源。回到主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            [_narraterTableView reloadData];
            [_narraterTableView headerEndRefreshing];
            [_narraterTableView removeFooter];
            [_narraterTableView addFooterWithTarget:self action:@selector(footerOfNarraterAction)];
        });
    }];
}
//上拉
- (void)footerOfNarraterAction
{
    numberOfNarrater++;
    NSLog(@"ddddddddddddddddddddddddddd%d",numberOfNarrater);
    TFTJSONKit *_newestVideoCon = [[TFTJSONKit alloc]initWithGETRequestURL:[NSString stringWithFormat:@"http://lolbox.oss.aliyuncs.com/json/v4/video/videolist_2_%@_%d.json?r=772632",_narratId,numberOfNarrater]];
    [_newestVideoCon didFinishUsingBlock:^(id jsonObject) {
        if (jsonObject == nil) {
            [_narraterTableView removeFooter];
        } else {
        XLJsonManager *jsonManager = [XLJsonManager jsonDefault];
        NSMutableArray *tempArray = [jsonManager videoArrayWithJson:jsonObject];
        [_videoNarratertArray addObjectsFromArray:tempArray];
        //得到数据源。回到主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            [_narraterTableView reloadData];
            [_narraterTableView footerEndRefreshing];
        });
        }
    }];
}



//TableView的代理方法
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XLVideoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NewestVideoIdentifier forIndexPath:indexPath];
    XLVideoNewestObject *_videoNewsObject = [_videoNarratertArray objectAtIndex:indexPath.row];
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
    return _videoNarratertArray.count;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    videoDePan.enabled = NO;
    
    //检测网络状况
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    //    _hostReach = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    //    [_hostReach startNotifier];
    XLVideoNewestObject *_videoNewsObject = [_videoNarratertArray objectAtIndex:indexPath.row];
    
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
    
     [player.moviePlayer play];
    
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(movieFinishedCallBack:) name:MPMoviePlayerPlaybackDidFinishNotification object:player.moviePlayer];
    
    
    
    
    /*
     //AVPlayerLayer 播放在线视频  无声音
     
     
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
    
    videoDePan.enabled = YES;
    //视频播放玩或者按下done按钮时的响应方法
    MPMoviePlayerController *theMovie = notifition.object;
    [[NSNotificationCenter defaultCenter]removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:theMovie];
    [player.view removeFromSuperview];

 }

- (void)reachabilityChanged:(NSNotification *)sender
{
    Reachability *curReach = [sender object];
    NSParameterAssert([curReach isKindOfClass:[Reachability class]]);
    NetworkStatus status = [curReach currentReachabilityStatus];
    
    UILabel *_netLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 400, 320, 30)];
    _netLabel.textAlignment = NSTextAlignmentCenter;
    _netLabel.textColor = [UIColor blackColor];
    [self.view addSubview:_netLabel];
    
    
    switch (status) {
        case NotReachable:
            _netLabel.text = @"当前网络不可用！";
            break;
        case ReachableViaWiFi:
            _netLabel.text = @"当前网络为WIFI！";
            break;
        case ReachableViaWWAN:
            _netLabel.text = @"当前网络为3G网络！";
            break;
        default:
            break;
    }
    
    
    [UIView animateWithDuration:3 animations:^{
        _netLabel.alpha = 0;
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [_netLabel removeFromSuperview];
        
    });
    
    
    
    
    
    
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
