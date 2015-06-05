//
//  XLNarrateObject.h
//  LOL
//
//  Created by lanou3g on 14-7-28.
//  Copyright (c) 2014年 __许龙__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XLNarrateObject : NSObject

@property (nonatomic,strong)NSString *narrateId;

@property (nonatomic,strong)NSString *narrateName;

@property (nonatomic,strong)NSString *narrateCount;

@property (nonatomic,strong)NSString *narrateImgUrlString;


- (instancetype)initWithId:(NSString *)narrateId
                      name:(NSString *)name
                     count:(NSString *)count
              imgUrlString:(NSString *)urlStr;


@end
