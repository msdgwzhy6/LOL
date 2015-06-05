//
//  XLNetRequestManager.h
//  LOL
//
//  Created by lanou3g on 14-7-22.
//  Copyright (c) 2014年 __许龙__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XLNetRequestManager : NSObject



+ (instancetype)netRequestManagerDefault;


- (NSMutableArray *)getNewsOfPageWithUrl:(NSString *)url;




@end
