//
//  XLNewsViewController.h
//  LOL
//
//  Created by lanou3g on 14-7-19.
//  Copyright (c) 2014年 __许龙__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLDrawerViewController.h"

@protocol   XLNewsViewControllerDelegate<NSObject>

- (void)clickNewsCellAction:(NSIndexPath *)indexPath;//点击单元格回收抽屉

@end



@interface XLNewsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UIScrollView *scrollView;//scrollView



@property (nonatomic,strong)UIButton *backButton;//抽屉返回，出来Button；

@property (nonatomic,strong)XLDrawerViewController *drawerVC;//抽屉视图

@property (nonatomic,assign)id<XLNewsViewControllerDelegate> delegate;//新闻代理

@end
