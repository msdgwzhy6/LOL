//
//  XLNewsDetailViewController.h
//  LOL
//
//  Created by lanou3g on 14-7-25.
//  Copyright (c) 2014年 __许龙__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XLNewsDetailViewController : UIViewController<UIScrollViewDelegate,UIWebViewDelegate>

@property (nonatomic,strong)NSString *newsId;//进入详情界面的唯一标示符

@end
