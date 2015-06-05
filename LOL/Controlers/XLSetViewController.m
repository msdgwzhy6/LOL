//
//  XLSetViewController.m
//  LOL
//
//  Created by lanou3g on 14-8-1.
//  Copyright (c) 2014年 __许龙__. All rights reserved.
//

#import "XLSetViewController.h"
#import "XLCustomBackView.h"

@interface XLSetViewController ()

@end

@implementation XLSetViewController
{
    NSInteger count;
    UIDynamicAnimator *animator;
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

    self.view.backgroundColor = SandColor;
//    UIButton *_aboutUsButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    _aboutUsButton.frame = CM(30, 80, 50, 30);
//    _aboutUsButton.backgroundColor = BurntOrangeColor;
//    [_aboutUsButton addTarget:self action:@selector(aboutUsAction:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:_aboutUsButton];
//    
//    
//    UIButton *_clearButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    _clearButton.frame = CM(100, 80, 50, 30);
//    _clearButton.backgroundColor = BurntOrangeColor;
//    [_clearButton addTarget:self action:@selector(clearButtonAction:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:_clearButton];








   // animator = [[UIDynamicAnimator alloc]initWithReferenceView:self.view];


    UIImageView *aboutUsImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"about-us.png"]];
    aboutUsImage.frame = CM(10, 80, 300, 400);
    [self.view addSubview:aboutUsImage];
    
    
    XLCustomBackView *_setCustomBackView = [[XLCustomBackView alloc]initWithFrame:CM(0, screen_H - 40, screen_W, 40)];
    _setCustomBackView.backgroundColor = SandColor;
    [_setCustomBackView.backButton setFrame:CM(20,5, 30, 30)];
    [_setCustomBackView.backButton setImage:[UIImage imageNamed:@"iconfont_liebiao_1.png"] forState:UIControlStateNormal];
    [_setCustomBackView.backButton addTarget:self action:@selector(setViewButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    _setCustomBackView.textLabel.text = @"";
    _setCustomBackView.shareButton.hidden = YES;
    [self.view addSubview:_setCustomBackView];


}
- (void)setViewButtonAction:(UIButton *)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:NotificationOfDrawer object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"drawer",@"1", nil]];
}

////关于我们
//- (void)aboutUsAction:(UIButton *)sender
//{
//    count = 0;
//    
//    UIView *aView = [[UIView alloc]initWithFrame:CM(20, 20, 200, 300)];
//    aView.backgroundColor = BurntOrangeColor;
//    [self.view addSubview:aView];
////添加行为
//    UIGravityBehavior *gravity = [[UIGravityBehavior alloc]initWithItems:@[aView]];
//    [gravity setAction:^{
//        count++;
//        if (count == 30) {
//            UIAttachmentBehavior *attachment = [[UIAttachmentBehavior alloc]initWithItem:aView attachedToAnchor:Point(160, 50)];
//            attachment.length = 250.0f;
//            attachment.damping = 1;
//            attachment.frequency = 10;
//            
//            [animator addBehavior:attachment];
//        }
//    }];
//    [animator addBehavior:gravity];
//    
//    
//}
//
////清楚缓存
//- (void)clearButtonAction:(UIButton *)sender
//{
//    run;
//}


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
