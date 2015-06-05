//
//  XLJsonManager.h
//  LOL
//
//  Created by lanou3g on 14-7-24.
//  Copyright (c) 2014年 __许龙__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XLJsonManager : NSObject


+ (instancetype)jsonDefault;


//给一个json字典或者数组返回一个存储着该对象的可变数组  ....视频界面
- (NSMutableArray *)videoArrayWithJson:(id)json;
//。。。。。。新闻界面
- (NSMutableArray *)newsArrayWithJson:(id)json;

//视频解说界面
- (NSMutableArray *)videoNarratArrayWithJson:(id)json;

@end
