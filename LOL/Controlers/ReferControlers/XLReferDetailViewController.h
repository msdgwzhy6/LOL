//
//  XLReferDetailViewController.h
//  LOL
//
//  Created by lanou3g on 14-7-27.
//  Copyright (c) 2014年 __许龙__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XLReferDetailViewController : UIViewController<UIWebViewDelegate>

@property (nonatomic,strong)NSString *summonerName;//召唤师名字

@property (nonatomic,strong)NSString *summonerSeverName;//服务器名字

@property (nonatomic,strong)NSString *titleName;

@end
