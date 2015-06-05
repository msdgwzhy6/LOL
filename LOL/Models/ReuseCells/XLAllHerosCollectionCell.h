//
//  XLAllHerosCollectionCell.h
//  LOL
//
//  Created by lanou3g on 14-7-22.
//  Copyright (c) 2014年 __许龙__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XLAllHerosCollectionCell : UICollectionViewCell

@property (nonatomic,strong)UIImageView *heroImageView;//英雄图片

@property (nonatomic,strong)UILabel *heroTitleLabel;//英雄昵称

@property (nonatomic,strong)UILabel *heroCnNameLabel;//英雄中文名

@property (nonatomic,strong)NSString *heroEnName;//英雄英文名

@property (nonatomic,strong)NSString *herotags;//英雄定位

@end
