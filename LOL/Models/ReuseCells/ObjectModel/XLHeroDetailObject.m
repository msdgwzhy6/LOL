//
//  XLHeroDetailObject.m
//  LOL
//
//  Created by lanou3g on 14-7-22.
//  Copyright (c) 2014年 __许龙__. All rights reserved.
//

#import "XLHeroDetailObject.h"

@implementation XLHeroDetailObject

- (instancetype)initWithId:(NSString *)deId name:(NSString *)name displayName:(NSString *)displayName title:(NSString *)title tags:(NSString *)tags description:(NSString *)description tips:(NSString *)tips opponentTips:(NSString *)opponentTips B:(NSDictionary *)b Q:(NSDictionary *)q W:(NSDictionary *)w E:(NSDictionary *)e R:(NSDictionary *)r price:(NSString *)price like:(NSArray *)like hate:(NSArray *)hate range:(NSString *)range moveSpeed:(NSString *)moveSpeed armorBase:(NSString *)armorBase armorLevel:(NSString *)armorLevel manaBase:(NSString *)manaBase manaLevel:(NSString *)manaLevel criticalChanceBase:(NSString *)criticalChanceBase criticalChanceLevel:(NSString *)criticalChanceLevel manaRegenBase:(NSString *)manaRegenBase manaRegenLevel:(NSString *)manaRegenLevel healthRegenBase:(NSString *)healthRegenBase healthRegenLevel:(NSString *)healthRegenLevel magicResistBase:(NSString *)magicResistBase magicResistLevel:(NSString *)magicResistLevel healthBase:(NSString *)healthBase healthLevel:(NSString *)healthLevel attackBase:(NSString *)attackBase attackLevel:(NSString *)attackLevel ratingDefense:(NSString *)ratingDefense ratingMagic:(NSString *)ratingMagic ratingDifficulty:(NSString *)ratingDifficulty ratingAttack:(NSString *)ratingAttack
{
    if (self = [super init]) {
        self.de_id = deId;
        self.de_name = name;
        self.de_displayName = displayName;
        self.de_title = title;
        self.de_tags = tags;
        self.de_description = description;
        self.de_tips = tips;
        self.de_opponentTips = opponentTips;
        self.de_B = b;
        self.de_Q = q;
        self.de_W = w;
        self.de_E = e;
        self.de_R = r;
        self.de_price = price;
        self.de_like = like;
        self.de_hate = hate;
        self.de_range = range;
        self.de_moveSpeed = moveSpeed;
        self.de_armorBase = armorBase;
        self.de_armorLevel = armorLevel;
        self.de_manaBase = manaBase;
        self.de_manaLevel = manaLevel;
        self.de_criticalChanceBase = criticalChanceBase;
        self.de_criticalChanceLevel = criticalChanceLevel;
        self.de_manaRegenBase = manaRegenBase;
        self.de_manaRegenLevel = manaRegenLevel;
        self.de_healthRegenBase = healthRegenBase;
        self.de_healthRegenLevel = healthRegenLevel;
        self.de_magicResistBase = magicResistBase;
        self.de_magicResistLevel = magicResistLevel;
        self.de_healthBase = healthBase;
        self.de_heathLevel = healthLevel;
        self.de_attackBase = attackBase;
        self.de_attackLevel = attackLevel;
        self.de_ratingDefense = ratingDefense;
        self.de_ratingMagic = ratingMagic;
        self.de_ratingDifficulty = ratingDifficulty;
        self.de_ratingAttack = ratingAttack;
        
    }
    return  self;
}





















@end
