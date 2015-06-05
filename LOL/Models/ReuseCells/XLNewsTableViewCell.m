//
//  XLNewsTableViewCell.m
//  LOL
//
//  Created by lanou3g on 14-7-21.
//  Copyright (c) 2014年 __许龙__. All rights reserved.
//

#import "XLNewsTableViewCell.h"

@implementation XLNewsTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //图片
       
        self.news_ImageView = [[UIImageView alloc]initWithFrame:CM(5, 5, 60, 50)];
         [self addSubview:_news_ImageView];
        
        
        //发布时间Label
        self.newsLabel_Posttime = [[UILabel alloc]initWithFrame:CM(15, 60, 100, 10)];
        _newsLabel_Posttime.font = Font(9) ;
        _newsLabel_Posttime.textColor = GrayColor;
       //  _newsLabel_Posttime.backgroundColor = [UIColor orangeColor];
        [self addSubview:_newsLabel_Posttime];
        
        
        //标题Label
        self.newsLabel_Title = [[UILabel alloc]initWithFrame:CM(70, 5, 240, 35)];
        _newsLabel_Title.textColor = [UIColor blackColor];
        _newsLabel_Title.font = Font(13);
        _newsLabel_Title.numberOfLines = 2;
        _newsLabel_Title.lineBreakMode = NSLineBreakByClipping;
      //  _newsLabel_Title.backgroundColor = [UIColor redColor];
         [self addSubview:_newsLabel_Title];
        
        //简介Label
        self.newsLabel_Desc = [[UILabel alloc]initWithFrame:CM(70, 30, 240, 40)];
         _newsLabel_Desc.font = Font(10);
        _newsLabel_Desc.lineBreakMode = NSLineBreakByTruncatingTail;
        _newsLabel_Desc.numberOfLines = 2;
       // _newsLabel_Desc.backgroundColor = [UIColor greenColor];
        [self addSubview:_newsLabel_Desc];
    
    
    
    
    
    
    
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    
    
    // Configure the view for the selected state
}

@end
