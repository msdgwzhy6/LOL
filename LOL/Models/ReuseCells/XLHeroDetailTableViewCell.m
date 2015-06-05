//
//  XLHeroDetailTableViewCell.m
//  LOL
//
//  Created by lanou3g on 14-7-24.
//  Copyright (c) 2014年 __许龙__. All rights reserved.
//

#import "XLHeroDetailTableViewCell.h"
#import "XLSkillMessageView.h"
#import "XLHeroDetailObject.h"

@implementation XLHeroDetailTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier skillNumber:(NSInteger)skillNumber b:(CGFloat )b qd:(CGFloat )qd qe:(CGFloat )qe wd:(CGFloat)wd we:(CGFloat)we ed:(CGFloat)ed ee:(CGFloat)ee rd:(CGFloat)rd re:(CGFloat)re object:(XLHeroDetailObject *)_heroDetail indexpath:(NSIndexPath *)indexPath tipsHeight:(CGFloat)tipHeight oppoentHeight:(CGFloat)oppoentHeight
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
      
        
        switch (indexPath.section) {
            case 0:
            {
                switch (skillNumber) {
                    case 0:
                    {
                        XLSkillMessageView *skillView = [[XLSkillMessageView alloc]initWithFrame:CM(0, 0, self.bounds.size.width, b + 30) dic:_heroDetail.de_B skillNumber:0 descriptionHeight:b effectHeight:0];
                        [self addSubview:skillView];
                    }
                        break;
                    case 1:
                    {
                        XLSkillMessageView *skillView = [[XLSkillMessageView alloc]initWithFrame:CM(0, 0, self.bounds.size.width, qd + qe + 75 + 30) dic:_heroDetail.de_Q skillNumber:1 descriptionHeight:qd   effectHeight:qe];
                        [self addSubview:skillView];
                    }
                        break;
                    case 2:
                    {
                        XLSkillMessageView *skillView = [[XLSkillMessageView alloc]initWithFrame:CM(0, 0, self.bounds.size.width, wd + we + 75 + 30) dic:_heroDetail.de_W skillNumber:2 descriptionHeight:wd   effectHeight:we];
                        [self addSubview:skillView];
                    }
                        break;
                    case 3:
                    {
                        XLSkillMessageView *skillView = [[XLSkillMessageView alloc]initWithFrame:CM(0, 0, self.bounds.size.width, ed + ee + 75 + 30) dic:_heroDetail.de_E skillNumber:3 descriptionHeight:ed  effectHeight:ee];
                        [self addSubview:skillView];
                    }
                        break;
                    case 4:
                    {
                        XLSkillMessageView *skillView = [[XLSkillMessageView alloc]initWithFrame:CM(0, 0, self.bounds.size.width, rd + re + 75 + 30) dic:_heroDetail.de_R skillNumber:4 descriptionHeight:rd  effectHeight:re];
                        [self addSubview:skillView];
                    }
                        break;
                    default:
                        break;
                }

            }
                break;
                case 1:
            {
                UILabel *tipsLabel = [[UILabel alloc]initWithFrame:CM(10, 10, self.bounds.size.width - 15, tipHeight)];
                tipsLabel.text = _heroDetail.de_tips;
                tipsLabel.font = Font(SizeOfFont);
                tipsLabel.numberOfLines = 0;
                [self addSubview:tipsLabel];
            }
                break;
                case 2:
            {
                UILabel *tipsLabel = [[UILabel alloc]initWithFrame:CM(10, 10, self.bounds.size.width - 15, oppoentHeight)];
                tipsLabel.text = _heroDetail.de_opponentTips;
                tipsLabel.font = Font(SizeOfFont);
                tipsLabel.numberOfLines = 0;
                [self addSubview:tipsLabel];
            }
                break;
                case 3:
            {
                
            }
                break;
                case 4:
            {
                
            }
                break;
            default:
                break;
        }
        
        
        
        


        
        
        
        
        
        
    }
    return self;
}
- (void)labelWithFrame:(CGRect )frame name:(NSString *)name value:(NSString *)value tag:(NSInteger )tag superView:(UIView *)aview
{
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    label.backgroundColor = colorRandom;
    label.text =[NSString stringWithFormat:@"%@:%@",name,value];
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.font = Font(12);
    label.tag = tag;
    [aview addSubview:label];
    
}
- (void)labelWithFrame:(CGRect )frame name:(NSString *)name value:(NSString *)value tag:(NSInteger )tag superView:(UIView *)aview levelValue:(NSString *)levelValue
{
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    label.backgroundColor = colorRandom;
    levelValue = [NSString stringWithFormat:@"%.2f",[levelValue floatValue]];
    label.text =[NSString stringWithFormat:@"%@:%@(%@)",name,value,levelValue];
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.font = Font(12);
    label.tag = tag;
    [aview addSubview:label];
    
}

//英雄数据
- (UIView *)heroDataViewWithheroDetail:(XLHeroDetailObject *)_heroDetail
{
    UIView *aView = [[UIView alloc]initWithFrame:CM(0, 0, screen_W, 300)];
    
    [self labelWithFrame:CM(10, 5, 150, 20) name:@"等级" value:@"0" tag:150 superView:aView];
    [self labelWithFrame:CM(20, 35, 150, 20) name:@"攻击距离" value:_heroDetail.de_range  tag:151 superView:aView];
    [self labelWithFrame:CM(20, 55, 150, 20) name:@"移动速度" value:_heroDetail.de_moveSpeed  tag:152 superView:aView];
    [self labelWithFrame:CM(20, 75, 150, 20) name:@"基础攻击" value:_heroDetail.de_attackBase  tag:153 superView:aView levelValue:_heroDetail.de_attackLevel];
    [self labelWithFrame:CM(20, 95, 150, 20) name:@"基础物理防御" value:_heroDetail.de_armorBase  tag:154 superView:aView levelValue:_heroDetail.de_armorLevel];
    [self labelWithFrame:CM(20, 115, 150, 20) name:@"基础魔法抗性" value:_heroDetail.de_magicResistBase  tag:155 superView:aView  levelValue:_heroDetail.de_magicResistLevel];
    [self labelWithFrame:CM(20, 135, 150, 20) name:@"基础魔法值" value:_heroDetail.de_manaBase  tag:156 superView:aView levelValue:_heroDetail.de_manaLevel];
    [self labelWithFrame:CM(20, 155, 150, 20) name:@"基础生命值" value:_heroDetail.de_healthBase  tag:157 superView:aView levelValue:_heroDetail.de_heathLevel];
    [self labelWithFrame:CM(20, 175, 150, 20) name:@"暴击概率" value:_heroDetail.de_criticalChanceBase  tag:158 superView:aView levelValue:_heroDetail.de_criticalChanceLevel];
    [self labelWithFrame:CM(20, 195, 150, 20) name:@"魔法回复" value:_heroDetail.de_manaRegenBase  tag:159 superView:aView levelValue:_heroDetail.de_manaRegenLevel];
    [self labelWithFrame:CM(20, 215, 150, 20) name:@"生命回复" value:_heroDetail.de_healthRegenBase  tag:160 superView:aView levelValue:_heroDetail.de_healthRegenLevel];
    
    
    UISlider *slider = [[UISlider alloc]initWithFrame:CM(30, 260, 260, 20)];
    slider.backgroundColor = GrayColor;
    slider.tag = 200;
    slider.minimumValue = 1;
    slider.maximumValue = 18;
   // [slider addTarget:self action:@selector(slider:) forControlEvents:UIControlEventValueChanged];
    
    [aView addSubview:slider];
    
    return aView;
}

- (void)changeValueWithTag:(NSInteger )tag name:(NSString *)name sliderValue:(NSInteger )value baseValue:(NSString *)baseValue levelValue:(NSString *)levelValue
{
    UILabel *label = (UILabel *)[self viewWithTag:tag];
    baseValue =  [NSString stringWithFormat:@"%.2f",([baseValue floatValue] + value * [levelValue floatValue])];
    levelValue = [NSString stringWithFormat:@"%.2f",[levelValue floatValue]];
    label.text =[NSString stringWithFormat:@"%@:%@(%@)",name,baseValue,levelValue];
}

////滑动条滑动的实现
//- (void)slider:(UISlider *)slider
//{
//    UILabel *label = (UILabel *)[self.view viewWithTag:150];
//    label.text = [NSString stringWithFormat:@"等级:%d",(NSInteger )slider.value];
//    
//    [self changeValueWithTag:153 name:@"基础攻击" sliderValue:(NSInteger )slider.value baseValue:_heroDetail.de_attackBase levelValue:_heroDetail.de_attackLevel];
//    [self changeValueWithTag:154 name:@"基础物理防御" sliderValue:(NSInteger )slider.value baseValue:_heroDetail.de_armorBase levelValue:_heroDetail.de_armorLevel];
//    [self changeValueWithTag:155 name:@"基础魔法抗性" sliderValue:(NSInteger )slider.value baseValue:_heroDetail.de_magicResistBase  levelValue:_heroDetail.de_magicResistLevel];
//    [self changeValueWithTag:156 name:@"基础魔法值" sliderValue:(NSInteger )slider.value baseValue:_heroDetail.de_manaBase levelValue:_heroDetail.de_manaLevel];
//    [self changeValueWithTag:157 name:@"基础生命值" sliderValue:(NSInteger )slider.value baseValue:_heroDetail.de_healthBase levelValue:_heroDetail.de_heathLevel];
//    [self changeValueWithTag:158 name:@"暴击概率" sliderValue:(NSInteger )slider.value baseValue:_heroDetail.de_criticalChanceBase levelValue:_heroDetail.de_criticalChanceLevel];
//    [self changeValueWithTag:159 name:@"魔法回复" sliderValue:(NSInteger )slider.value baseValue:_heroDetail.de_manaRegenBase levelValue:_heroDetail.de_manaRegenLevel];
//    [self changeValueWithTag:160 name:@"生命回复" sliderValue:(NSInteger )slider.value baseValue:_heroDetail.de_healthRegenBase levelValue:_heroDetail.de_healthRegenLevel];
//}




@end
