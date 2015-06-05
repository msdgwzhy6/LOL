//
//  XLNetRequestManager.m
//  LOL
//
//  Created by lanou3g on 14-7-22.
//  Copyright (c) 2014年 __许龙__. All rights reserved.
//

#import "XLNetRequestManager.h"
#import "TFTJSONKit.h"
#import "XLNewsObject.h"

@implementation XLNetRequestManager



+ (instancetype)netRequestManagerDefault
{
    static XLNetRequestManager *_manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_manager == nil) {
            _manager = [[XLNetRequestManager alloc]init];
        }
    });
    return _manager;
}


//根据传的URL得到新闻界面的一页信息
- (NSMutableArray *)getNewsOfPageWithUrl:(NSString *)url
{
    NSMutableArray *_dataArray = [NSMutableArray array];
    TFTJSONKit *newsOfPage_1_Connectiond = [[TFTJSONKit alloc]initWithGETRequestURL:url];
    [newsOfPage_1_Connectiond didFinishUsingBlock:^(id jsonObject) {
        
        NSArray *array = (NSArray *)jsonObject;
        for (NSInteger i = 0; i < array.count;i++ ) {
            NSDictionary *_tempDC = [array objectAtIndex:i];
            XLNewsObject *_newsObject = [XLNewsObject newsWithId:[_tempDC objectForKey:@"id"] title:[_tempDC objectForKey:@"title"] imgurl:[_tempDC objectForKey:@"img"] desc:[_tempDC objectForKey:@"desc"] posttime:[_tempDC objectForKey:@"posttime"] site:[_tempDC objectForKey:@"site"]];
            if (_newsObject != nil) {
                [_dataArray addObject:_newsObject];
            }
            
        }
     
    }];
    return _dataArray;

}













@end
