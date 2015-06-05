
#import "TFTJSONKit.h"
#import "TFTAsyncConnection.h"

@implementation TFTJSONKit {
    NSMutableData * receivedData;
    TFTAsyncConnection * connection;
    DidFinishBlocks didFinishBlock;
    DidFailBlocks didFailBlock;
    DidReiceiveResponseBlocks didReiceiveResponseBlock;
}

//  初始化方法
- (instancetype)initWithRequest:(NSURLRequest *)request {
    self = [super init];
    if(self) {
        connection = [[TFTAsyncConnection alloc] initWithRequest:request];
        [self setupConnection];
    }
    return self;
}

//  初始化方法
- (instancetype)initWithPOSTRequestURL:(NSString *)requestURL body:(NSString *)body {
    self = [super init];
    if(self) {
        connection = [TFTAsyncConnection asyncConnectionWithPostRequest:requestURL body:body];
        [self setupConnection];
    }
    return self;
}

//  初始化方法
- (instancetype)initWithGETRequestURL:(NSString *)requestURL {
    self = [super init];
    if(self) {
        connection = [TFTAsyncConnection asyncConnectionWithGetRequest:requestURL];
        [self setupConnection];
    }
    return self;
}

//  加载连接
- (void)setupConnection {
    receivedData = [NSMutableData dataWithCapacity:1];
    [connection didReceiveResponseUsingBlock:^(NSURLResponse *response) {
         [self didReiceiveResponse:response];
    }];
//    [connection didReceiveResponseUsingBlock:^(NSURLResponse *response) {
//        [self didReiceiveResponse:response];
//    }];
    [connection didReceiveDataUsingBlock:^(NSData *data) {
        [self didReiceivedData:data];
    }];
    [connection didFinishLoadingUsingBlock:^{
        [self didFinishLoad];
    }];
    [connection didFailUsingBlock:^(NSError *error) {
        [self didFail:error];
    }];
}

//接收到反应
- (void)didReiceiveResponse:(NSURLResponse *)response
{
    if (didReiceiveResponseBlock) {
        didReiceiveResponseBlock(response);
    }
}


//  已经接收到数据
- (void)didReiceivedData:(NSData *)data {
    [receivedData appendData:data];
}

//  已经完成加载
- (void)didFinishLoad {
    NSError * error;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:receivedData options:NSJSONReadingAllowFragments error:&error];
    if(error && didFailBlock) {
        didFailBlock(error);
    }else {
        if(didFinishBlock) {
            didFinishBlock(jsonObject);
        }
    }
}

//  连接失败
- (void)didFail:(NSError *)error {
    if(didFailBlock) {
        didFailBlock(error);
    }
}
//回调方法  开始反应
- (void)didReiceiveResponseBlock:(DidReiceiveResponseBlocks)didReiceiveResponse
{
    didReiceiveResponseBlock = [didReiceiveResponse copy];
}



//  回调方法 - 已经结束
- (void)didFinishUsingBlock:(DidFinishBlocks)didFinish {
    didFinishBlock = [didFinish copy];
}

//  回调方法 - 失败
- (void)didFailUsingBlock:(DidFailBlocks)didFail {
    didFailBlock = [didFail copy];
}

@end
