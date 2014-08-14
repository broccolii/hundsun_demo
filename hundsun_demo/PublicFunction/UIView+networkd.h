//
//  UIView+networkd.h
//  hundsun_zjfae
//
//  Created by 王金东 on 14-7-30.
//  Copyright (c) 2014年 王金东. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (networkd)

@property (nonatomic,strong) MKNetworkOperation *operation;


- (void)imagesForTag:(NSString*) tag completionHandler:(ResponseBlock) imageURLBlock errorHandler:(MKNKErrorBlock) errorBlock;

- (void)urlForTagWithProgressView:(NSString*) tag  completionHandler:(ResponseBlock) urlCompletionBlock errorHandler:(MKNKErrorBlock) errorBlock ;
- (void)urlForTagWithProgressView:(NSString*) tag  params:(NSDictionary *)params completionHandler:(ResponseBlock) urlCompletionBlock errorHandler:(MKNKErrorBlock) errorBlock;
- (void)urlForTagWithProgressView:(NSString*) tag  params:(NSDictionary *)params httpMethod:(NSString*)method completionHandler:(ResponseBlock) urlCompletionBlock errorHandler:(MKNKErrorBlock) errorBlock;

/**
 ** view自定义的等待框
 **/
- (void)urlForTag:(NSString*) tag  completionHandler:(ResponseBlock) urlCompletionBlock errorHandler:(MKNKErrorBlock) errorBlock ;
- (void)urlForTag:(NSString*) tag   params:(NSDictionary *)params completionHandler:(ResponseBlock) urlCompletionBlock errorHandler:(MKNKErrorBlock) errorBlock;
- (void)urlForTag:(NSString*) tag   params:(NSDictionary *)params httpMethod:(NSString*)method  completionHandler:(ResponseBlock) urlCompletionBlock errorHandler:(MKNKErrorBlock) errorBlock;

//上传文件
- (void)uploadImageFromFile:(NSString*) filePath name:(NSString*)key  mimeType:(NSString *)fileType tag:(NSString*)tag params:(NSDictionary *)params httpMethod:(NSString*)method  completionHandler:(ResponseBlock) urlCompletionBlock errorHandler:(MKNKErrorBlock) errorBlock;


@end

