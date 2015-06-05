//
//  XLReferCustomBackVIew.m
//  LOL
//
//  Created by lanou3g on 14-7-28.
//  Copyright (c) 2014年 __许龙__. All rights reserved.
//

#import "XLReferCustomBackVIew.h"

@implementation XLReferCustomBackVIew

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _backButton.frame = CM(10, 5, 40, 30);
        _backButton.titleLabel.font = Font(15);
        [_backButton setTitle:@"返回" forState:UIControlStateNormal];
        [self addSubview:_backButton];
        
        self.shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _shareButton.frame = CM(270, 5, 40, 30);
        _shareButton.titleLabel.font = Font(15);
        [_shareButton setTitle:@"绑定" forState:UIControlStateNormal];
        [self addSubview:_shareButton];
        
        
        self.textButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _textButton.frame = CM(110, 5, 100, 30);
        _textButton.titleLabel.font = Font(13);
         [self addSubview:_textButton];
       
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
