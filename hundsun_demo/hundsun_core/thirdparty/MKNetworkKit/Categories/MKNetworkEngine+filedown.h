//
//  MKNetworkEngine+filedown.h
//  hospitalcloud
//
//  Created by 123 on 14-6-19.
//  Copyright (c) 2014年 chenjiong. All rights reserved.
//

#import "MKNetworkEngine.h"

typedef void (^HsFileDownResponseBlock)(NSString *remotePath,NSString *localPath,NSData *data);
typedef void (^HsDownLoadProgress)(double progress);

@interface MKNetworkEngine (filedown)

+ (instancetype)defaultEngine;

+ (void)downloadWithURL:(NSURL *)url;
/**
 *下载文件
 *url:远程服务器地址
 *urlCompletionBlock:成功后回调
 *errorBlock:错误后回调
 **/
- (MKNetworkOperation *)downLoadFile:(NSURL *)url  completionHandler:(HsFileDownResponseBlock) urlCompletionBlock errorHandler:(MKNKErrorBlock) errorBlock;
/**
 *下载文件
 *url:远程服务器地址
 *urlCompletionBlock:成功后回调
 *errorBlock:错误后回调
 **/
- (MKNetworkOperation *)downLoadFile:(NSURL *)url progress:(HsDownLoadProgress)fileProgress  completionHandler:(HsFileDownResponseBlock) urlCompletionBlock errorHandler:(MKNKErrorBlock) errorBlock;

/**
 *下载文件
 *url:远程服务器地址
 *filePath:存放本地目标地址
 *urlCompletionBlock:成功后回调
 *errorBlock:错误后回调
 **/
- (MKNetworkOperation *)downLoadFile:(NSURL *)url toFile:(NSString *)filePath completionHandler:(HsFileDownResponseBlock) urlCompletionBlock errorHandler:(MKNKErrorBlock) errorBlock;

/**
 *下载文件
 *url:远程服务器地址
 *folder:存放本地目标地址的文件夹
 *urlCompletionBlock:成功后回调
 *errorBlock:错误后回调
 **/
//下载文件
- (MKNetworkOperation *)downLoadFile:(NSURL *)url toFolder:(NSString *)folder completionHandler:(HsFileDownResponseBlock) urlCompletionBlock errorHandler:(MKNKErrorBlock) errorBlock;

/**
 *下载文件
 *url:远程服务器地址
 *filePath:存放本地目标地址
 *fileProgress:进度
 *urlCompletionBlock:成功后回调
 *errorBlock:错误后回调
 **/

//下载文件
- (MKNetworkOperation *)downLoadFile:(NSURL *)url toFile:(NSString *)filePath progress:(HsDownLoadProgress)fileProgress  completionHandler:(HsFileDownResponseBlock) urlCompletionBlock errorHandler:(MKNKErrorBlock) errorBlock;

@end
