//
//  XLHeroObject.h
//  LOL
//
//  Created by lanou3g on 14-7-22.
//  Copyright (c) 2014年 __许龙__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XLHeroObject : NSObject

@property (nonatomic,strong)NSString *enName;//英文名字

@property (nonatomic,strong)NSString *cnName;//中文名字

@property (nonatomic,strong)NSString *title;//英雄昵称

@property (nonatomic,strong)NSString *tags;//英雄定位


- (instancetype)initWithEnname:(NSString *)enName
                        cnName:(NSString *)cnName
                         title:(NSString *)title
                          tags:(NSString *)tags;

+ (instancetype)heroWithEnname:(NSString *)enName
                        cnName:(NSString *)cnName
                         title:(NSString *)title
                          tags:(NSString *)tags;


@end
