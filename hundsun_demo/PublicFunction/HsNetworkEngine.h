//
//  HsNetworkEngine.h
//  hundsun_zjfae
//
//  Created by 王金东 on 14-7-29.
//  Copyright (c) 2014年 王金东. All rights reserved.
//

#import "MKNetworkEngine.h"

typedef void (^ResponseBlock)(NSMutableDictionary* result);

@interface HsNetworkEngine : MKNetworkEngine

- (MKNetworkOperation*) imagesForTag:(NSString*) tag completionHandler:(ResponseBlock) imageURLBlock errorHandler:(MKNKErrorBlock) errorBlock;

- (MKNetworkOperation*)urlForTag:(NSString*) tag  completionHandler:(ResponseBlock) urlCompletionBlock errorHandler:(MKNKErrorBlock) errorBlock ;
- (MKNetworkOperation*)urlForTag:(NSString*) tag   params:(NSDictionary *)params completionHandler:(ResponseBlock) urlCompletionBlock errorHandler:(MKNKErrorBlock) errorBlock;
- (MKNetworkOperation*)urlForTag:(NSString*) tag   params:(NSDictionary *)params httpMethod:(NSString*)method  completionHandler:(ResponseBlock) urlCompletionBlock errorHandler:(MKNKErrorBlock) errorBlock;


/**
 ** 带有等待框
 **/
- (MKNetworkOperation*)urlForTagWithProgressView:(NSString*) tag  completionHandler:(ResponseBlock) urlCompletionBlock errorHandler:(MKNKErrorBlock) errorBlock;

- (MKNetworkOperation*)urlForTagWithProgressView:(NSString*) tag  params:(NSDictionary *)params completionHandler:(ResponseBlock) urlCompletionBlock errorHandler:(MKNKErrorBlock) errorBlock;

- (MKNetworkOperation*)urlForTagWithProgressView:(NSString*) tag  params:(NSDictionary *)params httpMethod:(NSString*)method completionHandler:(ResponseBlock) urlCompletionBlock errorHandler:(MKNKErrorBlock) errorBlock;


- (MKNetworkOperation*)urlForTagWithProgressView:(NSString*) tag  params:(NSDictionary *)params httpMethod:(NSString*)method  completionHandler:(ResponseBlock) urlCompletionBlock errorHandler:(MKNKErrorBlock) errorBlock inView:(UIView *)view;

//上传文件
- (MKNetworkOperation*)uploadImageFromFile:(NSString*) filePath name:(NSString*)key  mimeType:(NSString *)fileType tag:(NSString*)tag params:(NSDictionary *)params httpMethod:(NSString*)method  completionHandler:(ResponseBlock) urlCompletionBlock errorHandler:(MKNKErrorBlock) errorBlock;

@end


@interface HsNetworkEngine (instance)

+ (HsNetworkEngine *)netWorkEngine;

+ (HsNetworkEngine *)pushEngine;

@end
