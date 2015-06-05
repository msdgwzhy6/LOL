//
//  XLNewsDetailTitleView.m
//  LOL
//
//  Created by lanou3g on 14-7-26.
//  Copyright (c) 2014年 __许龙__. All rights reserved.
//

#import "XLNewsDetailTitleView.h"

@implementation XLNewsDetailTitleView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        self.titleOfNewsDeLabel = [[UILabel alloc]initWithFrame:CM(0, 25, self.bounds.size.width, 20)];
        _titleOfNewsDeLabel.font = Font(13);
        _titleOfNewsDeLabel.numberOfLines = 1;
        _titleOfNewsDeLabel.lineBreakMode = NSLineBreakByCharWrapping;
       // _titleOfNewsDeLabel.backgroundColor = WhiteColor;
        _titleOfNewsDeLabel.textAlignment = NSTextAlignmentCenter;
        _titleOfNewsDeLabel.textColor = BlackColor;
        [self addSubview:_titleOfNewsDeLabel];

    
        self.postOfNewsDeLabel = [[UILabel alloc]initWithFrame:CM(15, 50, 145.0 / 320.0 * self.bounds.size.width, 10)];
        _postOfNewsDeLabel.font = Font(11);
       // _postOfNewsDeLabel.backgroundColor = WhiteColor;
        _postOfNewsDeLabel.textAlignment = NSTextAlignmentLeft;
        _postOfNewsDeLabel.textColor = WhiteColor;
        [self addSubview:_postOfNewsDeLabel];
    
        self.siteOfNewsDeLabel = [[UILabel alloc]initWithFrame:CM( 160.0 / 320.0 * self.bounds.size.width, 50,145.0 / 320.0 * self.bounds.size.width, 10)];
        _siteOfNewsDeLabel.font = Font(11);
        //_siteOfNewsDeLabel.backgroundColor = WhiteColor;
        _siteOfNewsDeLabel.textAlignment = NSTextAlignmentLeft;
        _siteOfNewsDeLabel.textColor = WhiteColor;
        [self addSubview:_siteOfNewsDeLabel];
    
    
    
    
    
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
