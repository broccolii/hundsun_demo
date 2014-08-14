//
//  MKNetworkEngine+filedown.m
//  hospitalcloud
//
//  Created by 123 on 14-6-19.
//  Copyright (c) 2014年 chenjiong. All rights reserved.
//

#import "MKNetworkEngine+filedown.h"

static MKNetworkEngine *defaultEngine;

@implementation MKNetworkEngine (filedown)

+ (instancetype)defaultEngine{
    @synchronized(defaultEngine){
        if(defaultEngine == nil){
            defaultEngine = [[MKNetworkEngine alloc] init];
        }
    }
    return defaultEngine;
}
+ (void)downloadWithURL:(NSURL *)url{
    [[MKNetworkEngine defaultEngine] downLoadFile:url completionHandler:nil errorHandler:nil];
}
//下载文件
- (MKNetworkOperation *)downLoadFile:(NSURL *)url  completionHandler:(HsFileDownResponseBlock) urlCompletionBlock errorHandler:(MKNKErrorBlock) errorBlock{
    NSString *filePath = [NSString stringWithFormat:@"%@/%@",AppStorage.filePath,[url lastPathComponent]];
    return [self downLoadFile:url toFile:filePath completionHandler:urlCompletionBlock errorHandler:errorBlock];
}
/**
 *下载文件
 *url:远程服务器地址
 *urlCompletionBlock:成功后回调
 *errorBlock:错误后回调
 **/
- (MKNetworkOperation *)downLoadFile:(NSURL *)url progress:(HsDownLoadProgress)fileProgress  completionHandler:(HsFileDownResponseBlock) urlCompletionBlock errorHandler:(MKNKErrorBlock) errorBlock{
    NSString *filePath = [NSString stringWithFormat:@"%@/%@",AppStorage.filePath,[url lastPathComponent]];
    return [self downLoadFile:url toFile:filePath progress:fileProgress completionHandler:urlCompletionBlock errorHandler:errorBlock];
}
//下载文件
- (MKNetworkOperation *)downLoadFile:(NSURL *)url toFile:(NSString *)filePath completionHandler:(HsFileDownResponseBlock) urlCompletionBlock errorHandler:(MKNKErrorBlock) errorBlock{
    return [self downLoadFile:url toFile:filePath progress:nil completionHandler:urlCompletionBlock errorHandler:errorBlock];
}

//下载文件
- (MKNetworkOperation *)downLoadFile:(NSURL *)url toFolder:(NSString *)folder completionHandler:(HsFileDownResponseBlock) urlCompletionBlock errorHandler:(MKNKErrorBlock) errorBlock{
    if(folder == nil){
        folder = AppStorage.filePath;
    }
    NSString *filePath = [NSString stringWithFormat:@"%@/%@",folder,[url lastPathComponent]];
    return [self downLoadFile:url toFile:filePath progress:nil completionHandler:urlCompletionBlock errorHandler:errorBlock];
}

//下载文件
- (MKNetworkOperation *)downLoadFile:(NSURL *)url toFile:(NSString *)filePath progress:(HsDownLoadProgress)fileProgress completionHandler:(HsFileDownResponseBlock) urlCompletionBlock errorHandler:(MKNKErrorBlock) errorBlock{
    if(url == nil){
        urlCompletionBlock(nil,nil,nil);
        return nil;
    }
    //如果不传路径 则给一个默认的路径  规则是file目录+文件名称
    if(filePath == nil){
        filePath = [NSString stringWithFormat:@"%@/%@",AppStorage.filePath,[url lastPathComponent]];
    }
    NSLog(@"file url:%@",filePath);
    __block MKNetworkOperation *op = [self operationWithURLString:[url absoluteString]];
    op.shouldNotCacheResponse = YES;
    //[op addDownloadStream:[NSOutputStream outputStreamToFileAtPath:@"test.pdf" append:NO]];//定义输出流
    [op onDownloadProgressChanged:^(double progress) {
        if(fileProgress != nil){
            fileProgress(progress);
        }
    }];//显示进度条
    [op addCompletionHandler:^(MKNetworkOperation* completedOperation) {
        NSLog(@"url:%@ download success",filePath);
        if(completedOperation.responseData != nil){//判断字节不为空 则保存到指定的目录
            [completedOperation.responseData writeToFile:filePath atomically:YES];
        }
        if(urlCompletionBlock != nil){
            urlCompletionBlock([url absoluteString],filePath,completedOperation.responseData);
        }
    } errorHandler:^(MKNetworkOperation *errorOp, NSError* err){
        if(errorBlock != nil){
            errorBlock(err);
        }
    }];
    //开启线程
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSFileManager *fm = [NSFileManager defaultManager];
        if ( [fm fileExistsAtPath:filePath] )//如果存在本地文件，则直接取出来
        {
            NSData *data = [NSData dataWithContentsOfFile:filePath];
            dispatch_async(dispatch_get_main_queue(), ^{
                if(urlCompletionBlock != nil){
                    urlCompletionBlock([url absoluteString],filePath,data);
                }
            });
        }
        else{//不存在 则开启线程
            [self enqueueOperation:op];
        }
    });
    return op;
}


@end
