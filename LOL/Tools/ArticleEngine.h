//
//  NetEngine.h
//  HTTPjiexi
//
//  Created by Fkx on 14-6-18.
//  Copyright (c) 2014年 WangCe. All rights reserved.
//


#import <Foundation/Foundation.h>
@interface ArticleEngine : NSObject
+ (ArticleEngine *)sharedEngine;

- (NSArray *)getArticleContentWith:(NSString *)string XPathQuery:(NSString *)XPathQuery;

@end





