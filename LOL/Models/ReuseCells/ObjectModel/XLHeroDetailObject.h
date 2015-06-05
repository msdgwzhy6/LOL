//
//  XLHeroDetailObject.h
//  LOL
//
//  Created by lanou3g on 14-7-22.
//  Copyright (c) 2014年 __许龙__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XLHeroDetailObject : NSObject

@property (nonatomic,strong)NSString *de_id;

@property (nonatomic,strong)NSString *de_name;//英雄英文名字

@property (nonatomic,strong)NSString *de_displayName;//英雄昵称

@property (nonatomic,strong)NSString *de_title;//英雄中文名

@property (nonatomic,strong)NSString *de_tags;//英雄定位

@property (nonatomic,strong)NSString *de_description;//英雄背景描述

@property (nonatomic,strong)NSString *de_tips;//英雄使用技巧

@property (nonatomic,strong)NSString *de_opponentTips;//英雄应对技巧

@property (nonatomic,strong)NSDictionary *de_B;//英雄的被动技能字典

@property (nonatomic,strong)NSDictionary *de_Q;//英雄的Q技能字典

@property (nonatomic,strong)NSDictionary *de_W;//英雄的W技能字典

@property (nonatomic,strong)NSDictionary *de_E;//英雄的E技能字典

@property (nonatomic,strong)NSDictionary *de_R;//英雄的R技能字典

@property (nonatomic,strong)NSString *de_price;//英雄价钱

@property (nonatomic,strong)NSArray *de_like;//搭档

@property (nonatomic,strong)NSArray *de_hate;//克制

@property (nonatomic,strong)NSString *de_range;//攻击距离

@property (nonatomic,strong)NSString *de_moveSpeed;//移动速度

@property (nonatomic,strong)NSString *de_armorBase;//基础护甲

@property (nonatomic,strong)NSString *de_armorLevel;//每升一级，护甲增加量

@property (nonatomic,strong)NSString *de_manaBase;//基础蓝量

@property (nonatomic,strong)NSString *de_manaLevel;//每升一级，蓝量增加量

@property (nonatomic,strong)NSString *de_criticalChanceBase;//基础暴击几率

@property (nonatomic,strong)NSString *de_criticalChanceLevel;//每升一级，暴击几率增加量

@property (nonatomic,strong)NSString *de_manaRegenBase;//基础魔法恢复

@property (nonatomic,strong)NSString *de_manaRegenLevel;//每升一级，魔法恢复增加量

@property (nonatomic,strong)NSString *de_healthRegenBase;//基础生命恢复

@property (nonatomic,strong)NSString *de_healthRegenLevel;//每升一级，生命恢复增加量

@property (nonatomic,strong)NSString *de_magicResistBase;//基础魔法抗性

@property (nonatomic,strong)NSString *de_magicResistLevel;//每升一级，魔法抗性增加量

@property (nonatomic,strong)NSString *de_healthBase;//基础生命值

@property (nonatomic,strong)NSString *de_heathLevel;//每升一级，生命值增加量

@property (nonatomic,strong)NSString *de_attackBase;//基础攻击力

@property (nonatomic,strong)NSString *de_attackLevel;//每升一级，攻击力增加量

@property (nonatomic,strong)NSString *de_ratingDefense;//防御成长系数

@property (nonatomic,strong)NSString *de_ratingMagic;//法术成长系数

@property (nonatomic,strong)NSString *de_ratingDifficulty;//操作难度系数

@property (nonatomic,strong)NSString *de_ratingAttack;//攻击成长系数



- (instancetype)initWithId:(NSString *)deId
                      name:(NSString *)name
               displayName:(NSString *)displayName
                     title:(NSString *)title
                      tags:(NSString *)tags
               description:(NSString *)description
                      tips:(NSString *)tips
              opponentTips:(NSString *)opponentTips
                         B:(NSDictionary *)b
                         Q:(NSDictionary *)q
                         W:(NSDictionary *)w
                         E:(NSDictionary *)e
                         R:(NSDictionary *)r
                     price:(NSString *)price
                      like:(NSArray *)like
                      hate:(NSArray *)hate
                     range:(NSString *)range
                 moveSpeed:(NSString *)moveSpeed
                 armorBase:(NSString *)armorBase
                armorLevel:(NSString *)armorLevel
                  manaBase:(NSString *)manaBase
                 manaLevel:(NSString *)manaLevel
        criticalChanceBase:(NSString *)criticalChanceBase
       criticalChanceLevel:(NSString *)criticalChanceLevel
             manaRegenBase:(NSString *)manaRegenBase
            manaRegenLevel:(NSString *)manaRegenLevel
           healthRegenBase:(NSString *)healthRegenBase
          healthRegenLevel:(NSString *)healthRegenLevel
           magicResistBase:(NSString *)magicResistBase
          magicResistLevel:(NSString *)magicResistLevel
                healthBase:(NSString *)healthBase
               healthLevel:(NSString *)healthLevel
                attackBase:(NSString *)attackBase
               attackLevel:(NSString *)attackLevel
             ratingDefense:(NSString *)ratingDefense
               ratingMagic:(NSString *)ratingMagic
          ratingDifficulty:(NSString *)ratingDifficulty
              ratingAttack:(NSString *)ratingAttack;









@end
