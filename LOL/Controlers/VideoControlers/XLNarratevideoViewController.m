//
//  XLNarratevideoViewController.m
//  LOL
//
//  Created by lanou3g on 14-7-28.
//  Copyright (c) 2014年 __许龙__. All rights reserved.
//

#import "XLNarratevideoViewController.h"
#import "TFTJSONKit.h"
#import "XLNarrateObject.h"
#import "XLJsonManager.h"
#import "XLNarrateViedeoTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "XLNarrateDetailVideoViewController.h"
#import "MONActivityIndicatorView.h"
#import "XLCustomBackView.h"

@interface XLNarratevideoViewController ()<MONActivityIndicatorViewDelegate>

@property (nonatomic,strong)NSMutableArray *dataOfArray;

@end

@implementation XLNarratevideoViewController

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
    
  
    
    
    [self getNarrateDataSource];

    //添加轻扫手势
    UIPanGestureRecognizer *_videoDePan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(narratvideoPan:)];
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
    _videoNewesBackView.tag = 170;
    [_videoNewesBackView.backButton addTarget:self action:@selector(videoNarraterBack:) forControlEvents:UIControlEventTouchUpInside];
    [_videoNewesBackView.backButton setFrame:CM(20,5, 30, 30)];
    [_videoNewesBackView.backButton setImage:[UIImage imageNamed:@"iconfont_liebiao_1.png"] forState:UIControlStateNormal];
    _videoNewesBackView.shareButton.hidden = YES;
    [self.view addSubview:_videoNewesBackView];
    
    
    [UIView animateWithDuration:1.0f animations:^{
        button1.frame = CM(0, 0, screen_W, 0);
        button2.frame = CM(0, screen_H, screen_W, 0);
    } completion:^(BOOL finished) {
        if (finished) {
            [button1 removeFromSuperview];
            [button2 removeFromSuperview];
            _videoNewesBackView.textLabel.text = @"解说列表";
            [_videoNewesBackView.backButton setFrame:CM(20,7.5, 25, 25)];
            [_videoNewesBackView.backButton setImage:[UIImage imageNamed:@"iconfont-zuojiantou.png"] forState:UIControlStateNormal];
            
        }
    }];
    
    
    
    

}
//返回上一页面
- (void)videoNarraterBack:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
         [[NSNotificationCenter defaultCenter]postNotificationName:NotificationOfDrawer object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"kai",@"1", nil]];
    }];
}



- (void)narratvideoPan:(UIPanGestureRecognizer *)pangesture
{
    
    CGPoint point = [pangesture translationInView:self.view];
     
    if (point.x >= 90) {
        [self dismissViewControllerAnimated:YES completion:^{
              [[NSNotificationCenter defaultCenter]postNotificationName:NotificationOfDrawer object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"kai",@"1", nil]];
        }];
    }
}

- (void)getNarrateDataSource
{
    TFTJSONKit *narrateconnet = [[TFTJSONKit alloc]initWithGETRequestURL:VideoNarratPort];
    [narrateconnet didFinishUsingBlock:^(id jsonObject) {
        
        MONActivityIndicatorView *indicatorView = (MONActivityIndicatorView *)[self.view viewWithTag:170];
        [indicatorView stopAnimating];
        
        XLJsonManager *jsonManager = [XLJsonManager jsonDefault];
        self.dataOfArray = [NSMutableArray array];
         _dataOfArray = [jsonManager videoNarratArrayWithJson:jsonObject];
        //回到主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            UITableView *narratTableView = [[UITableView alloc]initWithFrame:CM(0, 20, screen_W, screen_H - 60)];
            narratTableView.delegate = self;
            narratTableView.dataSource = self;
            narratTableView.rowHeight = 60;
            
            [narratTableView registerClass:[XLNarrateViedeoTableViewCell class] forCellReuseIdentifier:NarraterVideoIDentifier];
            [self.view addSubview:narratTableView];
            XLCustomBackView *view = (XLCustomBackView *)[self.view viewWithTag:170];

            [self.view insertSubview:narratTableView belowSubview:view];

            
        });
    }];
}

//TableView的代理方法
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XLNarrateViedeoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NarraterVideoIDentifier forIndexPath:indexPath];
    XLNarrateObject *narrater = [_dataOfArray objectAtIndex:indexPath.row];
    
    [cell.narratImgView sd_setImageWithURL:[NSURL URLWithString:narrater.narrateImgUrlString] placeholderImage:nil];
    cell.narratID = narrater.narrateId;
    cell.narratNameLabel.text = narrater.narrateName;
    cell.narratCountLabel.text = narrater.narrateCount;
    
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataOfArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    XLNarrateViedeoTableViewCell *cell = (XLNarrateViedeoTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    XLNarrateDetailVideoViewController *narrateDeVC = [[XLNarrateDetailVideoViewController alloc]init];
    narrateDeVC.narratId = cell.narratID;
    narrateDeVC.narratName = cell.narratNameLabel.text;
     [self presentViewController:narrateDeVC animated:YES completion:^{
    
    }];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
