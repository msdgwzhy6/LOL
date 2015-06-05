//
//  XLHeroDetailHeadImageView.h
//  LOL
//
//  Created by lanou3g on 14-7-23.
//  Copyright (c) 2014年 __许龙__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XLHeroDetailHeadImageView : UIView



@property (nonatomic,strong)UILabel *hero_goldPriceLabel;//金币价格

@property (nonatomic,strong)UILabel *hero_dianquanPriceLabel;//点券价格

@property (nonatomic,strong)UILabel *hero_ratingLabel;//攻防系数总共4个

@property (nonatomic,strong)UILabel *hero_displayNameLabel;//昵称


- (instancetype)initWithFrame:(CGRect)frame
                    goldPrice:(NSString *)gold
                dianquanPrice:(NSString *)dianquan
                  displayName:(NSString *)displayName
                       attack:(NSString *)attack
                      defense:(NSString *)defense
                        magic:(NSString *)magic
                   difficulty:(NSString *)difficulty;




@end
