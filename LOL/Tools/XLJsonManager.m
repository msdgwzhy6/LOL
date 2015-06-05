//
//  XLJsonManager.m
//  LOL
//
//  Created by lanou3g on 14-7-24.
//  Copyright (c) 2014年 __许龙__. All rights reserved.
//

#import "XLJsonManager.h"
#import "XLVideoNewestObject.h"
#import "XLNewsObject.h"
#import "XLNarrateObject.h"

@implementation XLJsonManager

+ (instancetype)jsonDefault
{
    static XLJsonManager *_jsonManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_jsonManager == nil) {
            _jsonManager = [[XLJsonManager alloc]init];
        
        }
    });
    return _jsonManager;
}


//给一个json字典或者数组返回一个存储着该对象的可变数组
- (NSMutableArray *)videoArrayWithJson:(id)jsonObject
{
    NSMutableArray *videoNewestArray = [NSMutableArray array];
    for (NSInteger i = 0; i <[jsonObject count] ; i++) {
        NSDictionary *tempDi = [jsonObject objectAtIndex:i];
        XLVideoNewestObject *videoObject = [[XLVideoNewestObject alloc]
                   initWithVideoId:[tempDi objectForKey:@"id"]
                   videoName:[tempDi objectForKey:@"name"]
                   videoImg:[tempDi objectForKey:@"img"]
                   videoSuperUrl:[tempDi objectForKey:@"video_addr_super"]
                   videoHighUrl:[tempDi objectForKey:@"video_addr_high"]
                   videoUrl:[tempDi objectForKey:@"video_addr"]
                   videoLength:[tempDi objectForKey:@"length"]
                   videoTime:[NSString stringWithFormat:@"%@",[tempDi objectForKey:@"time"]]];
        [videoNewestArray addObject:videoObject];
    }
    return videoNewestArray;
}

- (NSMutableArray *)newsArrayWithJson:(id)json
{
    NSArray *array = (NSArray *)json;
    NSMutableArray *dataArray = [NSMutableArray array];
    for (NSInteger i = 0; i < array.count;i++ ) {
        NSDictionary *_tempDC = [array objectAtIndex:i];
        XLNewsObject *_newsObject = [XLNewsObject newsWithId:[_tempDC objectForKey:@"id"] title:[_tempDC objectForKey:@"title"] imgurl:[_tempDC objectForKey:@"img"] desc:[_tempDC objectForKey:@"desc"] posttime:[_tempDC objectForKey:@"posttime"] site:[_tempDC objectForKey:@"site"]];
        if (_newsObject != nil) {
            [dataArray addObject:_newsObject];
        }
    }
        return dataArray;
}

- (NSMutableArray *)videoNarratArrayWithJson:(id)json
{
    NSArray *array = (NSArray *)json;
    NSMutableArray *dataArray = [NSMutableArray array];
    for (NSInteger i = 0; i < array.count; i++) {
        NSDictionary *_tempDC = [array objectAtIndex:i];
        XLNarrateObject *narratObjdet = [[XLNarrateObject alloc]initWithId:[_tempDC objectForKey:@"id"] name:[_tempDC objectForKey:@"name"] count:[_tempDC objectForKey:@"count"] imgUrlString:[_tempDC objectForKey:@"img"]];
        if (narratObjdet != nil) {
            [dataArray addObject:narratObjdet];
        }
    }
    return dataArray;
}






















@end
