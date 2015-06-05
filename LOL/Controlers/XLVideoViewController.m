//
//  XLVideoViewController.m
//  LOL
//
//  Created by lanou3g on 14-7-21.
//  Copyright (c) 2014年 __许龙__. All rights reserved.
//

#import "XLVideoViewController.h"
#import "TFTJSONKit.h"
#import "XLNarratevideoViewController.h"
#import "XLCustomBackView.h"
@interface XLVideoViewController ()

@end

@implementation XLVideoViewController

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
    self.view.backgroundColor = [UIColor whiteColor];


 
    

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CM(0, 0, screen_W,  screen_H / 2 - 20);
    button.backgroundColor = SkyBlueColor;
    [button setTitle:@"最新视频" forState:UIControlStateNormal];
    [button setTitleColor:BlackColor forState:UIControlStateNormal];
    button.titleLabel.font = Font(18);
    [button addTarget:self action:@selector(button:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
 
    
    UIButton *buttonTwo = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonTwo.frame = CM(0, screen_H / 2 - 20, screen_W, screen_H / 2 - 20);
    buttonTwo.backgroundColor = SandColor;
    [buttonTwo setTitle:@"解说视频" forState:UIControlStateNormal];
    [buttonTwo setTitleColor:WhiteColor forState:UIControlStateNormal];
    buttonTwo.titleLabel.font = Font(18);
    [buttonTwo addTarget:self action:@selector(buttonTwo:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonTwo];
    
    XLCustomBackView *_videoCustomBackView = [[XLCustomBackView alloc]initWithFrame:CM(0, screen_H - 40, screen_W, 40)];
    _videoCustomBackView.backgroundColor = SandColor;
    [_videoCustomBackView.backButton setFrame:CM(20,5, 30, 30)];
    [_videoCustomBackView.backButton setImage:[UIImage imageNamed:@"iconfont_liebiao_1.png"] forState:UIControlStateNormal];
    [_videoCustomBackView.backButton addTarget:self action:@selector(videoViewButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    _videoCustomBackView.textLabel.text = @"";
    _videoCustomBackView.shareButton.hidden = YES;
    [self.view addSubview:_videoCustomBackView];

}

- (void)videoViewButtonAction:(UIButton *)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:NotificationOfDrawer object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"drawer",@"1", nil]];
}

- (void)buttonTwo:(UIButton *)sender
{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NotificationOfDrawer object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"offDrawer",@"1", nil]];
    
    XLNarratevideoViewController *narrateVC = [[XLNarratevideoViewController alloc]init];
 
    narrateVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
     [self presentViewController:narrateVC animated:NO completion:^{
            [[NSNotificationCenter defaultCenter]postNotificationName:NotificationOfDrawer object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"guan",@"1", nil]];
    }];
}





- (void)button:(UIButton *)sender
{
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationOfDrawer object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"offDrawer",@"1", nil]];
    
     XLVideoNewestViewController *videoNewstVC = [[XLVideoNewestViewController alloc]init];
    videoNewstVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
     [self presentViewController:videoNewstVC animated:NO completion:^{
          [[NSNotificationCenter defaultCenter]postNotificationName:NotificationOfDrawer object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"guan",@"1", nil]];
    }];

}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}








@end
