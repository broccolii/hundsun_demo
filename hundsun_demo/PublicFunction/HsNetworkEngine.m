//
//  HsNetworkEngine.m
//  hundsun_zjfae
//
//  Created by 王金东 on 14-7-29.
//  Copyright (c) 2014年 王金东. All rights reserved.
//

#import "HsNetworkEngine.h"

@implementation HsNetworkEngine

- (MKNetworkOperation*) imagesForTag:(NSString*) tag completionHandler:(ResponseBlock) imageURLBlock errorHandler:(MKNKErrorBlock) errorBlock {
    
    MKNetworkOperation *op = [self operationWithPath:[NSString stringWithFormat:@"doctors"] ];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        
        [completedOperation responseJSONWithCompletionHandler:^(id jsonObject) {
            imageURLBlock(jsonObject);
        }];
        
    } errorHandler:^(MKNetworkOperation *errorOp, NSError* error) {
        
        errorBlock(error);
    }];
    
    [self enqueueOperation:op];
    return op;
}

/**
 上传文件
 */
- (MKNetworkOperation*) uploadImageFromFile:(NSString*) filePath name:(NSString*)key  mimeType:(NSString *)fileType tag:(NSString*)tag params:(NSDictionary *)params httpMethod:(NSString*)method  completionHandler:(ResponseBlock) urlCompletionBlock errorHandler:(MKNKErrorBlock) errorBlock{
    
    __weak MKNetworkOperation *op;
    if ([method isEqualToString:@"GET"]) {
        op = [self operationWithPath:tag];
    }
    else
    {
        op = [self operationWithPath:tag params:params httpMethod:method];
        if (params!=nil) {
            if ([method isEqualToString:@"POST"]) {
                op.postDataEncoding= MKNKPostDataEncodingTypeJSON;
            }
        }
    }
    [op addFile:filePath forKey:key mimeType:fileType];
    
    // setFreezable uploads your images after connection is restored!
    [op setFreezable:YES];
    
    [op addCompletionHandler:^(MKNetworkOperation* completedOperation) {
        
        [completedOperation responseJSONWithCompletionHandler:^(id jsonObject) {
            [self checkAndPrecessError:self completionHandler:urlCompletionBlock errorHandler:errorBlock tag:tag params:params httpMethod:method sourceDic:jsonObject inView:nil isProgressView:NO];
            
        }];
        
    } errorHandler:^(MKNetworkOperation *errorOp, NSError* err){
        
        errorBlock(err);
    }];
    
    [self enqueueOperation:op];
    
    return op;
}

- (MKNetworkOperation*)urlForTag:(NSString*) tag  completionHandler:(ResponseBlock) urlCompletionBlock errorHandler:(MKNKErrorBlock) errorBlock
{
    return [self urlForTag:tag  params:nil completionHandler: urlCompletionBlock errorHandler: errorBlock];
}

- (MKNetworkOperation*)urlForTag:(NSString*) tag   params:(NSDictionary *)params  completionHandler:(ResponseBlock) urlCompletionBlock errorHandler:(MKNKErrorBlock) errorBlock
{
    return [self urlForTag:tag  params:params httpMethod:@"GET" completionHandler: urlCompletionBlock errorHandler: errorBlock];
}


- (MKNetworkOperation*)urlForTag:(NSString*) tag   params:(NSDictionary *)params httpMethod:(NSString*)method  completionHandler:(ResponseBlock) urlCompletionBlock errorHandler:(MKNKErrorBlock) errorBlock
{
    return [self urlForTagWithProgressView:tag params:params httpMethod:method completionHandler:urlCompletionBlock errorHandler:errorBlock inView:nil];
}



- (MKNetworkOperation*)urlForTagWithProgressView:(NSString*) tag  completionHandler:(ResponseBlock) urlCompletionBlock errorHandler:(MKNKErrorBlock) errorBlock{
    return [self urlForTagWithProgressView:tag params:nil completionHandler:urlCompletionBlock errorHandler:errorBlock];
}

- (MKNetworkOperation*)urlForTagWithProgressView:(NSString*) tag  params:(NSDictionary *)params completionHandler:(ResponseBlock) urlCompletionBlock errorHandler:(MKNKErrorBlock) errorBlock{
    return [self urlForTagWithProgressView:tag params:params httpMethod:@"GET" completionHandler:urlCompletionBlock errorHandler:errorBlock];
}

- (MKNetworkOperation*)urlForTagWithProgressView:(NSString*) tag  params:(NSDictionary *)params httpMethod:(NSString*)method completionHandler:(ResponseBlock) urlCompletionBlock errorHandler:(MKNKErrorBlock) errorBlock{
    
    return [self urlForTagWithProgressView:tag params:params httpMethod:method completionHandler:urlCompletionBlock errorHandler:errorBlock inView:nil isProgressView:YES];
}


- (MKNetworkOperation*)urlForTagWithProgressView:(NSString*) tag  params:(NSDictionary *)params httpMethod:(NSString*)method  completionHandler:(ResponseBlock) urlCompletionBlock errorHandler:(MKNKErrorBlock) errorBlock inView:(UIView *)view{
    
    return [self urlForTagWithProgressView:tag params:params httpMethod:method completionHandler:urlCompletionBlock errorHandler:errorBlock inView:view isProgressView:NO];
}


/**
 ** 网络加载
 **/

- (MKNetworkOperation*)urlForTagWithProgressView:(NSString*) tag  params:(NSDictionary *)params httpMethod:(NSString*)method  completionHandler:(ResponseBlock) urlCompletionBlock errorHandler:(MKNKErrorBlock) errorBlock  inView:(UIView *)view isProgressView:(BOOL)isProgressView;
{
    __weak MKNetworkOperation *op;
    if(view != nil){
        [view showEmptyView:NetWorkLoading];
    }else if(isProgressView){
        [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleFade];
        [MMProgressHUD showWithStatus:@"正在加载..."];
    }
    if ([method isEqualToString:@"GET"]) {
        op = [self operationWithPath:tag];
    }
    else
    {
        op = [self operationWithPath:tag params:params httpMethod:method];
    }
    op.shouldNotCacheResponse = YES;
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation)
     {
         if(view != nil){
             [view hideEmptyView];
         }
         __weak HsNetworkEngine *engine = self;
         [completedOperation responseJSONWithCompletionHandler:^(id jsonObject) {
             [engine checkAndPrecessError:self completionHandler:urlCompletionBlock errorHandler:errorBlock tag:tag params:params httpMethod:method sourceDic:jsonObject inView:view isProgressView:isProgressView];
         }];
     } errorHandler:^(MKNetworkOperation *errorOp, NSError* error)
     {
         if(view != nil){
             //网络请求失败 显示失败界面 并增加点击事件
             __weak HsNetworkEngine *engine = self;
             [view showEmptyView:NetWorkFailView clickBlock:^(void){
                 [engine urlForTagWithProgressView:tag params:params httpMethod:method completionHandler:urlCompletionBlock errorHandler:errorBlock inView:view];
             }];
         }else if(isProgressView){
               [MMProgressHUD dismissWithError:@"网络请求失败！" afterDelay:1.0];
         }
         errorBlock(error);
     }];
    [self enqueueOperation:op];
    return op;
}



//缓存目录
- (NSString*) cacheDirectoryName {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = paths[0];
    NSString *cacheDirectoryName = [documentsDirectory stringByAppendingPathComponent:@"FlickrImages"];
    return cacheDirectoryName;
}




//处理异常
- (void) checkAndPrecessError:(HsNetworkEngine *) mkNetworkEngine completionHandler:(ResponseBlock) urlCompletionBlock errorHandler:(MKNKErrorBlock) errorBlock tag:(NSString*) tag  params:(NSDictionary *)params httpMethod:(NSString*)method sourceDic:(NSMutableDictionary*) sourceDic inView:view isProgressView:(BOOL)isProgressView{
    if (sourceDic != nil) {
        NSString *returnNo = sourceDic[@"returnNo"];
        if([@"0000" isEqualToString:returnNo]){
            urlCompletionBlock(sourceDic);
            [MMProgressHUD dismiss];
        }else{
            if(view != nil){
                __weak HsNetworkEngine *engine = self;
                [view showEmptyTitle:sourceDic[@"returnInfo"] clickBlock:^(void){
                    [engine urlForTagWithProgressView:tag params:params httpMethod:method completionHandler:urlCompletionBlock errorHandler:errorBlock inView:view];
                }];
            }else if(isProgressView){
                [MMProgressHUD dismissWithError:sourceDic[@"returnInfo"] afterDelay:2.0];
            }
        }
    }else{
        [MMProgressHUD dismiss];
        errorBlock(nil);
    }
}



@end

static HsNetworkEngine *_pushEngine;
static HsNetworkEngine *_netWorkEngine;

@implementation HsNetworkEngine (instance)


+ (HsNetworkEngine *)netWorkEngine{
    GCD_OnceBlock(^{
        _netWorkEngine = [[HsNetworkEngine alloc] initWithHostName:@"192.168.0.1"];
        _netWorkEngine.portNumber = 8080;
        _netWorkEngine.apiPath = @"server";
    });
    return _netWorkEngine;
}

+ (HsNetworkEngine *)pushEngine{
    @synchronized(_pushEngine){
        if(_pushEngine == nil){
            _pushEngine = [[HsNetworkEngine alloc] init];
        }
    }
    return _pushEngine;
}

@end
