//
//  XLAllHerosCollectionCell.m
//  LOL
//
//  Created by lanou3g on 14-7-22.
//  Copyright (c) 2014年 __许龙__. All rights reserved.
//

#import "XLAllHerosCollectionCell.h"

@implementation XLAllHerosCollectionCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        self.heroImageView = [[UIImageView alloc]initWithFrame:CM(0, 0, self.bounds.size.width, 65)];
        [self addSubview:_heroImageView];
        
        self.heroTitleLabel = [[UILabel alloc]initWithFrame:CM(0, 66, self.bounds.size.width, 10)];
        _heroTitleLabel.font = Font(9);
        _heroTitleLabel.textAlignment = NSTextAlignmentCenter;
        _heroTitleLabel.textColor = BlackColor;
        [self addSubview:_heroTitleLabel];
        
        
        self.heroCnNameLabel = [[UILabel alloc]initWithFrame:CM(0, 79, self.bounds.size.width, 8)];
        _heroCnNameLabel.font = Font(8);
        _heroCnNameLabel.textAlignment = NSTextAlignmentCenter;
        _heroCnNameLabel.textColor = WhiteColor;
        [self addSubview:_heroCnNameLabel];
    
    
    
    
    
    
    
    
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
