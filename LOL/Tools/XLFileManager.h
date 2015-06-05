//
//  XLFileManager.h
//  LOL
//
//  Created by lanou3g on 14-7-30.
//  Copyright (c) 2014年 __许龙__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XLFileManager : NSObject


+ (instancetype)fileManagerDefault;

//在documents中创建文件
- (void)creatFileAtPathString:(NSString *)plistPath;

//删除文件
- (void)deleteFileAtPathString:(NSString *)plistPath;

 
@end
