//
//  XLNarrateObject.m
//  LOL
//
//  Created by lanou3g on 14-7-28.
//  Copyright (c) 2014年 __许龙__. All rights reserved.
//

#import "XLNarrateObject.h"

@implementation XLNarrateObject

- (instancetype)initWithId:(NSString *)narrateId
                      name:(NSString *)name
                     count:(NSString *)count
              imgUrlString:(NSString *)urlStr
{
    if (self = [super init]) {
        self.narrateId = narrateId;
        self.narrateName = name;
        self.narrateCount = count;
        self.narrateImgUrlString = urlStr;
    }
    return self;
}

@end
