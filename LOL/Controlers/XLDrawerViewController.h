//
//  XLDrawerViewController.h
//  LOL
//
//  Created by lanou3g on 14-7-19.
//  Copyright (c) 2014年 __许龙__. All rights reserved.
//

#import <UIKit/UIKit.h>



//抽屉视图的协议
@protocol XLDrawerViewDelegate <NSObject>

//选中items的方法
- (void)clickItemsAction:(NSIndexPath *)indexPath;

@end

@interface XLDrawerViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate>


@property (nonatomic,assign)id<XLDrawerViewDelegate> delegate;//协议代理


@end
