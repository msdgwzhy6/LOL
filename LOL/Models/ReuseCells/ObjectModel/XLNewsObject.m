//
//  XLNewsObject.m
//  LOL
//
//  Created by lanou3g on 14-7-21.
//  Copyright (c) 2014年 __许龙__. All rights reserved.
//

#import "XLNewsObject.h"

@implementation XLNewsObject

- (instancetype)initWithId:(NSString *)newsId
                     title:(NSString *)title
                    imgurl:(NSString *)imgurl
                      desc:(NSString *)desc
                  posttime:(NSString *)posttime
                      site:(NSString *)site
{
    if (self = [super init]) {
        self.news_Id = newsId;
        self.news_Title = title;
        self.news_Imgurl = imgurl;
        self.news_Desc = desc;
        self.news_Posttime = posttime;
        self.news_Site = site;
    }
    return self;
}


+ (instancetype)newsWithId:(NSString *)newsId title:(NSString *)title imgurl:(NSString *)imgurl desc:(NSString *)desc posttime:(NSString *)posttime site:(NSString *)site
{
    return [[XLNewsObject alloc]initWithId:newsId title:title imgurl:imgurl desc:desc posttime:posttime site:site];
}








@end
