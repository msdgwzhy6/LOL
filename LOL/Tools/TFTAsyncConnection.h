
#import <Foundation/Foundation.h>

//  回调用 Blocks
typedef void (^DidReceiveResponseBlocks)(NSURLResponse * response);
typedef void (^DidReceiveDataBlocks)(NSData * data);
typedef void (^DidFinishLoadingBlocks)(void);
typedef void (^DidFailBlocks)(NSError * error);

@interface TFTAsyncConnection : NSURLConnection <NSURLConnectionDelegate, NSURLConnectionDataDelegate>

#pragma mark - 初始化

//  初始化方法 - 指定初始化方法
- (instancetype)initWithRequest:(NSURLRequest *)request;

//  便利构造方法 - 创建一个Get请求的异步连接，requestString为URL。
+ (instancetype)asyncConnectionWithGetRequest:(NSString *)requestString;

//  便利构造方法 - 创建一个Post请求的异步连接，requestString为URL。Body可以为空。
+ (instancetype)asyncConnectionWithPostRequest:(NSString *)requestString body:(NSString *)body;

#pragma mark - 用 Blocks 回调 NSURLConnectionDelegate 和 NSURLConnectionDataDelegate 方法

//  回调方法 - 已经接收到响应
- (void)didReceiveResponseUsingBlock:(DidReceiveResponseBlocks)didReceiveResponse;

//  回调方法 - 已经接收到数据
- (void)didReceiveDataUsingBlock:(DidReceiveDataBlocks)didReceiveData;

//  回调方法 - 加载已完成
- (void)didFinishLoadingUsingBlock:(DidFinishLoadingBlocks)didFinishLoading;

//  回调方法 - 连接失败
- (void)didFailUsingBlock:(DidFailBlocks)didFail;

@end
