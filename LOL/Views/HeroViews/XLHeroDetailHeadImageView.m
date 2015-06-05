//
//  XLHeroDetailHeadImageView.m
//  LOL
//
//  Created by lanou3g on 14-7-23.
//  Copyright (c) 2014年 __许龙__. All rights reserved.
//

#import "XLHeroDetailHeadImageView.h"

@implementation XLHeroDetailHeadImageView

- (instancetype)initWithFrame:(CGRect)frame
                    goldPrice:(NSString *)gold
                dianquanPrice:(NSString *)dianquan
                  displayName:(NSString *)displayName
                       attack:(NSString *)attack
                      defense:(NSString *)defense
                        magic:(NSString *)magic
                   difficulty:(NSString *)difficulty;
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.hero_displayNameLabel = [[UILabel alloc]initWithFrame:CM(85, 10, 100, 20)];
        _hero_displayNameLabel.textAlignment = NSTextAlignmentLeft;
        _hero_displayNameLabel.text = displayName;
        _hero_displayNameLabel.font = Font(15);
        [self addSubview:_hero_displayNameLabel];
        
        self.hero_goldPriceLabel = [[UILabel alloc]initWithFrame:CM(85, 30, 60, 20)];
        _hero_goldPriceLabel.text = [NSString stringWithFormat:@"金币:%@",gold];
        _hero_goldPriceLabel.textColor = GrayColor;
        _hero_goldPriceLabel.font = Font(10);
        [self addSubview:_hero_goldPriceLabel];
        
        self.hero_dianquanPriceLabel = [[UILabel alloc]initWithFrame:CM(85 + 60, 30, 60, 20)];
        _hero_dianquanPriceLabel.text = [NSString stringWithFormat:@"点券:%@",dianquan];
        _hero_dianquanPriceLabel.textColor = GrayColor;
        _hero_dianquanPriceLabel.font = Font(10);
        [self addSubview:_hero_dianquanPriceLabel];
        
        self.hero_ratingLabel = [[UILabel alloc]initWithFrame:CM(85, 50, 150, 20)];
        _hero_ratingLabel.text = [NSString stringWithFormat:@"攻%@  防%@  法%@  难度%@",attack,defense,magic,difficulty];
        _hero_ratingLabel.textColor = GrayColor;
        _hero_ratingLabel.font = Font(10);
        [self addSubview:_hero_ratingLabel];
        
        
        
        
        
        
    }
    return self;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
