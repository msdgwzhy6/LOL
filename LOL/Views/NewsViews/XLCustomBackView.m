//
//  XLCustomBackView.m
//  LOL
//
//  Created by lanou3g on 14-7-28.
//  Copyright (c) 2014年 __许龙__. All rights reserved.
//

#import "XLCustomBackView.h"

@implementation XLCustomBackView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        self.backgroundColor = GrayColor;
        self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _backButton.frame = CM(10, 5, 40, 30);
        _backButton.titleLabel.font = Font(15);
        [_backButton setTitle:@"返回" forState:UIControlStateNormal];
        [self addSubview:_backButton];
        
        self.shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _shareButton.frame = CM(270, 5, 40, 30);
        _shareButton.titleLabel.font = Font(15);
        [_shareButton setTitle:@"分享" forState:UIControlStateNormal];
        [self addSubview:_shareButton];
    
        self.textLabel = [[UILabel alloc]initWithFrame:CM(60, 5, 200, 30)];
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.textColor = BlackColor;
        _textLabel.font = Font(13);
        [self addSubview:_textLabel];
    
    
    
    
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
