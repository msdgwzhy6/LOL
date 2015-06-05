//
//  XLNewsTableViewCell.h
//  LOL
//
//  Created by lanou3g on 14-7-21.
//  Copyright (c) 2014年 __许龙__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XLNewsTableViewCell : UITableViewCell

@property (nonatomic,strong)NSString *newsCell_Id;//进入下个（详细界面）的唯一标示符

@property (nonatomic,strong)UILabel *newsLabel_Title;//新闻信息的标题

@property (nonatomic,strong)UIImageView *news_ImageView;//新闻信息的图片

@property (nonatomic,strong)UILabel *newsLabel_Desc;//新闻信息的简介

@property (nonatomic,strong)UILabel *newsLabel_Posttime;//新闻信息发布的时间

@property (nonatomic,strong)UILabel *newsLabel_Site;//新闻信息的来源


@end
