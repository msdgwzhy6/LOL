//
//  XLHeroObject.m
//  LOL
//
//  Created by lanou3g on 14-7-22.
//  Copyright (c) 2014年 __许龙__. All rights reserved.
//

#import "XLHeroObject.h"

@implementation XLHeroObject


- (instancetype)initWithEnname:(NSString *)enName
                        cnName:(NSString *)cnName
                         title:(NSString *)title
                          tags:(NSString *)tags
{
    if (self = [super init]) {
        self.enName = enName;
        self.cnName = cnName;
        self.title = title;
        self.tags = tags;
    }
    return self;
}

+ (instancetype)heroWithEnname:(NSString *)enName
                        cnName:(NSString *)cnName
                         title:(NSString *)title
                          tags:(NSString *)tags
{
    return [[XLHeroObject alloc]initWithEnname:enName cnName:cnName title:title tags:tags];

}

@end
