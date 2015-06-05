
#import "TFTAsyncConnection.h"


@implementation TFTAsyncConnection {
    //  回调用 Blocks
    DidReceiveResponseBlocks didReceiveResponseBlock;
    DidReceiveDataBlocks didReceiveDataBlock;
    DidFinishLoadingBlocks didFinishLoadingBlock;
    DidFailBlocks didFailBlock;
}

#pragma mark - 初始化

//  初始化方法 - 指定初始化方法
- (instancetype)initWithRequest:(NSURLRequest *)request {
    self = [super initWithRequest:request delegate:self];
    if(self) {
        [self start];
    }
    return self;
}

//  便利构造方法 - 创建一个Get请求的异步连接，requestString为URL。
+ (instancetype)asyncConnectionWithGetRequest:(NSString *)requestString {
    NSURL * url = [NSURL URLWithString:requestString];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    TFTAsyncConnection * connection = [[TFTAsyncConnection alloc] initWithRequest:request];
    return connection;
}

//  便利构造方法 - 创建一个Post请求的异步连接，requestString为URL。Body可以为空。
+ (instancetype)asyncConnectionWithPostRequest:(NSString *)requestString body:(NSString *)body {
    NSURL * url = [NSURL URLWithString:requestString];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    if(body && ![body isEqualToString:@""]) {
        NSData * bodyData = [body dataUsingEncoding:NSUTF8StringEncoding];
        [request setHTTPBody:bodyData];
    }
    TFTAsyncConnection * connection = [[TFTAsyncConnection alloc] initWithRequest:request];
    return connection;
}

#pragma mark - 用 Blocks 回调 NSURLConnectionDelegate 和 NSURLConnectionDataDelegate 方法

//  代理方法 - 已经接收到响应
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
     if(didReceiveResponseBlock) {
        didReceiveResponseBlock(response);
    }
}

//  回调方法 - 已经接收到响应
- (void)didReceiveResponseUsingBlock:(DidReceiveResponseBlocks)didReceiveResponse {
    didReceiveResponseBlock = [didReceiveResponse copy];
}

//  代理方法 - 已经接收到数据
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    if(didReceiveDataBlock) {
        didReceiveDataBlock(data);
    }
}

//  回调方法 - 已经接收到数据
- (void)didReceiveDataUsingBlock:(DidReceiveDataBlocks)didReceiveData {
    didReceiveDataBlock = [didReceiveData copy];
}

//  代理方法 - 加载已完成
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    if(didFinishLoadingBlock) {
        didFinishLoadingBlock();
    }
}

//  回调方法 - 加载已完成
- (void)didFinishLoadingUsingBlock:(DidFinishLoadingBlocks)didFinishLoading {
    didFinishLoadingBlock = [didFinishLoading copy];
}

//  代理方法 - 连接失败
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    if(didFailBlock) {
        didFailBlock(error);
    }
}

//  回调方法 - 连接失败
- (void)didFailUsingBlock:(DidFailBlocks)didFail {
    didFailBlock = [didFail copy];
}

@end
