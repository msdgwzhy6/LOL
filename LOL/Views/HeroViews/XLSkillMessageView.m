//
//  XLSkillMessageView.m
//  LOL
//
//  Created by lanou3g on 14-7-23.
//  Copyright (c) 2014年 __许龙__. All rights reserved.
//

#import "XLSkillMessageView.h"

@implementation XLSkillMessageView

- (id)initWithFrame:(CGRect)frame
                dic:(NSDictionary *)dic
        skillNumber:(NSInteger )skillNumber
  descriptionHeight:(CGFloat )descriHeight
       effectHeight:(CGFloat )effectHeight;
{
    self = [super initWithFrame:frame];
    if (self) {
        
        NSArray *nameArray = @[@"被动",@"Q",@"W",@"E",@"R"];
        
        if (skillNumber == 0) {
            
            UILabel *nameLabel = [[UILabel alloc]initWithFrame:CM(20, 10, self.bounds.size.width - 40, 20)];
            nameLabel.text = [NSString stringWithFormat:@"%@(%@)",[dic objectForKey:@"name"],[nameArray objectAtIndex:skillNumber]];
            nameLabel.textAlignment = NSTextAlignmentLeft;
            nameLabel.textColor = BlackColor;
            nameLabel.font = Font(13);
            [self addSubview:nameLabel];
            
            
            UILabel *descriptionLabel = [[UILabel alloc]initWithFrame:CM(20, 30, self.bounds.size.width - 40, descriHeight)];
            descriptionLabel.text = [dic objectForKey:@"description"];
            //  descriptionLabel.textAlignment = NSTextAlignmentLeft;
            descriptionLabel.textColor = BlackColor;
            descriptionLabel.numberOfLines = 0;
            descriptionLabel.font = Font(SizeOfSkillFont);
            [self addSubview:descriptionLabel];
            
        }else {
            
            UILabel *nameLabel = [[UILabel alloc]initWithFrame:CM(20, 10, self.bounds.size.width - 40, 20)];
            nameLabel.text = [NSString stringWithFormat:@"%@(%@)",[dic objectForKey:@"name"],[nameArray objectAtIndex:skillNumber]];;
            nameLabel.textAlignment = NSTextAlignmentLeft;
            nameLabel.textColor = BlackColor;
            nameLabel.font = Font(13);
            [self addSubview:nameLabel];
            
            UILabel *costLabel = [[UILabel alloc]initWithFrame:CM(20, 30, self.bounds.size.width - 40, 15)];
            costLabel.text = [NSString stringWithFormat:@"消耗:%@",[dic objectForKey:@"cost"]];
            costLabel.textAlignment = NSTextAlignmentLeft;
            costLabel.textColor = BlackColor;
            costLabel.font = Font(SizeOfSkillFont);
            [self addSubview:costLabel];
            
            UILabel *cooldownLabel = [[UILabel alloc]initWithFrame:CM(20, 45, self.bounds.size.width - 40, 15)];
            cooldownLabel.text = [NSString stringWithFormat:@"冷却:%@秒",[dic objectForKey:@"cooldown"]];
            cooldownLabel.textAlignment = NSTextAlignmentLeft;
            cooldownLabel.textColor = BlackColor;
            cooldownLabel.font = Font(SizeOfSkillFont);
            [self addSubview:cooldownLabel];
            
            UILabel *rangeLabel = [[UILabel alloc]initWithFrame:CM(20, 60, self.bounds.size.width - 40, 15)];
            rangeLabel.text = [NSString stringWithFormat:@"范围:%@",[dic objectForKey:@"range"]];
            rangeLabel.textAlignment = NSTextAlignmentLeft;
            rangeLabel.textColor = BlackColor;
            rangeLabel.font = Font(SizeOfSkillFont);
            [self addSubview:rangeLabel];
                               
                               
            UILabel *effectLabel = [[UILabel alloc]initWithFrame:CM(20, 75 , self.bounds.size.width - 40, effectHeight)];
            effectLabel.text = [NSString stringWithFormat:@"效果:%@",[dic objectForKey:@"effect"]];
            effectLabel.numberOfLines = 0;
            effectLabel.lineBreakMode = NSLineBreakByClipping;
           // effectLabel.textAlignment = NSTextAlignmentLeft;
            effectLabel.textColor = BlackColor;
            effectLabel.font = Font(SizeOfSkillFont);
            [self addSubview:effectLabel];
   
            UILabel *descriptionLabel = [[UILabel alloc]initWithFrame:CM(20, 75 + effectHeight + 10, self.bounds.size.width - 40, descriHeight)];
            descriptionLabel.text = [NSString stringWithFormat:@"描述:%@",[dic objectForKey:@"description"]];
            // descriptionLabel.textAlignment = NSTextAlignmentLeft;
            descriptionLabel.numberOfLines = 0;
            descriptionLabel.textColor = BlackColor;
            descriptionLabel.font = Font(SizeOfSkillFont);
            [self addSubview:descriptionLabel];
            
    
   
            
        }
        
        
        
        
        
        
        
        
        
        
        
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
