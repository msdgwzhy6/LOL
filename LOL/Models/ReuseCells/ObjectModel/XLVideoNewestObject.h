//
//  XLVideoNewestObject.h
//  LOL
//
//  Created by lanou3g on 14-7-24.
//  Copyright (c) 2014年 __许龙__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XLVideoNewestObject : NSObject

@property (nonatomic,strong)NSString *videoId;

@property (nonatomic,strong)NSString *videoName;

@property (nonatomic,strong)NSString *videoImg;

@property (nonatomic,strong)NSString *video_addr_super_url;

@property (nonatomic,strong)NSString *video_addr_high_url;

@property (nonatomic,strong)NSString *video_addr_url;

@property (nonatomic,strong)NSString *videoLength;

@property (nonatomic,strong)NSString *videoTime;//视频更新时间

- (instancetype)initWithVideoId:(NSString *)videoId
                      videoName:(NSString *)videoName
                       videoImg:(NSString *)videoImg
                  videoSuperUrl:(NSString *)superUrl
                   videoHighUrl:(NSString *)highUrl
                       videoUrl:(NSString *)url
                    videoLength:(NSString *)length
                      videoTime:(NSString *)time;



@end
