
#import <Foundation/Foundation.h>
typedef void (^DidReiceiveResponseBlocks)(NSURLResponse *response);
typedef void (^DidFailBlocks)(NSError * error);
typedef void (^DidFinishBlocks)(id jsonObject);

@interface TFTJSONKit : NSObject

//  初始化方法
- (instancetype)initWithRequest:(NSURLRequest *)request;

//  初始化方法
- (instancetype)initWithPOSTRequestURL:(NSString *)requestURL body:(NSString *)body;

//  初始化方法
- (instancetype)initWithGETRequestURL:(NSString *)requestURL;

//  回调方法 - 已经结束
- (void)didFinishUsingBlock:(DidFinishBlocks)didFinish;

//  回调方法 - 失败
- (void)didFailUsingBlock:(DidFailBlocks)didFail;
//回调 - 开士有相应
- (void)didReiceiveResponseBlock:(DidReiceiveResponseBlocks)didReiceiveResponse;

@end
