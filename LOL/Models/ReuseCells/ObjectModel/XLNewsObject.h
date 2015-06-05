//
//  XLNewsObject.h
//  LOL
//
//  Created by lanou3g on 14-7-21.
//  Copyright (c) 2014年 __许龙__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XLNewsObject : NSObject

@property (nonatomic,strong)NSString *news_Id;//进入下个（详细界面）的唯一标示符

@property (nonatomic,strong)NSString *news_Title;//新闻信息的标题

@property (nonatomic,strong)NSString *news_Imgurl;//新闻信息的图片

@property (nonatomic,strong)NSString *news_Desc;//新闻信息的简介

@property (nonatomic,strong)NSString *news_Posttime;//新闻信息发布的时间

@property (nonatomic,strong)NSString *news_Site;//新闻信息的来源


- (instancetype)initWithId:(NSString *)newsId
                     title:(NSString *)title
                    imgurl:(NSString *)imgurl
                      desc:(NSString *)desc
                  posttime:(NSString *)posttime
                      site:(NSString *)site;


+ (instancetype)newsWithId:(NSString *)newsId
                     title:(NSString *)title
                    imgurl:(NSString *)imgurl
                      desc:(NSString *)desc
                  posttime:(NSString *)posttime
                      site:(NSString *)site;




@end
