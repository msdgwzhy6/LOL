//
//  XLVideoNewestObject.m
//  LOL
//
//  Created by lanou3g on 14-7-24.
//  Copyright (c) 2014年 __许龙__. All rights reserved.
//

#import "XLVideoNewestObject.h"

@implementation XLVideoNewestObject

- (instancetype)initWithVideoId:(NSString *)videoId
                      videoName:(NSString *)videoName
                       videoImg:(NSString *)videoImg
                  videoSuperUrl:(NSString *)superUrl
                   videoHighUrl:(NSString *)highUrl
                       videoUrl:(NSString *)url
                    videoLength:(NSString *)length
                      videoTime:(NSString *)time
{
    if (self = [super init]) {
        self.videoId = videoId;
        self.videoName = videoName;
        self.videoImg = videoImg;
        self.video_addr_super_url = superUrl;
        self.video_addr_high_url = highUrl;
        self.video_addr_url = url;
        self.videoLength = length;
        self.videoTime = time;
    }
    return self;
}

@end
