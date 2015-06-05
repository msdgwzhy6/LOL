//
//  NetEngine.m
//  HTTPjiexi
//
//  Created by Fkx on 14-6-18.
//  Copyright (c) 2014年 WangCe. All rights reserved.
//

#import "ArticleEngine.h"
#import <libxml/HTMLparser.h>
#import "TFHpple.h"
#import "TFHppleElement.h"


@interface ArticleEngine ()<NSURLConnectionDataDelegate>

@property (retain,nonatomic) TFHpple *parser;
@property (retain, nonatomic) NSMutableArray *strWeNeed;
@property (retain, nonatomic) NSMutableString *tempStr;

@end


@implementation ArticleEngine

-(NSArray *)getArticleContentWith:(NSString *)string XPathQuery:(NSString *)XPathQuery{
    NSData *HTMLdata = [string dataUsingEncoding:NSUTF8StringEncoding];
    self.parser=[TFHpple hppleWithHTMLData:HTMLdata];
    
  //  TFHppleElement *contentNode=
    NSMutableArray *arr=[NSMutableArray array];

    NSArray *elementArray = [self.parser searchWithXPathQuery:XPathQuery];
    for (TFHppleElement *contentNode in elementArray) {
        
 
    NSMutableArray *changeArr=[NSMutableArray arrayWithArray:contentNode.children];
#pragma mark 去尾，不完美

    for (int i=0; i<changeArr.count; i++) {
        NSMutableString *str=[NSMutableString string];
        [self parseNode:[changeArr objectAtIndex:i] WithString:str];
        [arr addObject:str];
        
    }
    }
    return arr;
}



+ (ArticleEngine *)sharedEngine{
    @synchronized(self){
        static ArticleEngine *articleEngine = nil;
        if (articleEngine == nil) {
            articleEngine = [[ArticleEngine alloc] init];
        }
        return articleEngine;
    }
}
//获得字符串
#pragma mark 核心算法

- (void)parseNode:(TFHppleElement *)node WithString:(NSMutableString *)strWeNeed{
    if ([node isTextNode]) {
        [strWeNeed appendString:node.content];
        return;
    }
    if ([node.tagName isEqualToString:@"img"]) {
        if([node objectForKey:@"src"]){
            [strWeNeed appendString:[node  objectForKey:@"src"]];
            return;
        }return;
    }

    if ([node hasChildren]) {
        for (TFHppleElement *node2 in node.children) {
            [self parseNode:node2 WithString:strWeNeed];
        }
    }
}



@end
