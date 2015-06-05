//
//  XLFileManager.m
//  LOL
//
//  Created by lanou3g on 14-7-30.
//  Copyright (c) 2014年 __许龙__. All rights reserved.
//

#import "XLFileManager.h"

@implementation XLFileManager

+ (instancetype)fileManagerDefault
{
    static XLFileManager *fileManger = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (fileManger == nil) {
            fileManger = [[XLFileManager alloc]init];
        }
    });
    return fileManger;
}


@end
