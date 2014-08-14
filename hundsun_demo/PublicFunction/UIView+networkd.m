//
//  UIView+networkd.m
//  hundsun_zjfae
//
//  Created by 王金东 on 14-7-30.
//  Copyright (c) 2014年 王金东. All rights reserved.
//

#import "UIView+networkd.h"
#import <objc/runtime.h>


static const void *operationKey = &operationKey;

@implementation UIView (networkd)
@dynamic operation;

+ (void)load
{
    Method m1;
    Method m2;
    //将方法替换
    m1 = class_getInstanceMethod(self, @selector(newRemoveFromSuperview));
    m2 = class_getInstanceMethod(self, @selector(removeFromSuperview));
    method_exchangeImplementations(m1, m2);
}

- (void)newRemoveFromSuperview
{
    if(self.operation != nil){
        [self.operation cancel];
        self.operation = nil;
    }
    //表面调用的自己 其实调用的是dealloc方法
    [self newRemoveFromSuperview];
}


- (void)setOperation:(MKNetworkOperation *)operation{
    objc_setAssociatedObject(self, operationKey, operation, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (MKNetworkOperation *)operation{
    return objc_getAssociatedObject(self, operationKey);
}

- (void)imagesForTag:(NSString*)tag completionHandler:(ResponseBlock) imageURLBlock errorHandler:(MKNKErrorBlock)errorBlock{
    if(self.operation != nil){
        [self.operation cancel];
    }
     self.operation = [[HsNetworkEngine netWorkEngine] imagesForTag:tag completionHandler:imageURLBlock errorHandler:errorBlock];
}

- (void)urlForTagWithProgressView:(NSString*) tag  completionHandler:(ResponseBlock) urlCompletionBlock errorHandler:(MKNKErrorBlock) errorBlock{
     [self urlForTagWithProgressView:tag  params:nil httpMethod:@"GET" completionHandler: urlCompletionBlock errorHandler: errorBlock];
}
- (void)urlForTagWithProgressView:(NSString*) tag  params:(NSDictionary *)params completionHandler:(ResponseBlock) urlCompletionBlock errorHandler:(MKNKErrorBlock) errorBlock{
     [self urlForTagWithProgressView:tag  params:params httpMethod:@"GET" completionHandler: urlCompletionBlock errorHandler: errorBlock];
}
- (void)urlForTagWithProgressView:(NSString*) tag  params:(NSDictionary *)params httpMethod:(NSString*)method completionHandler:(ResponseBlock) urlCompletionBlock errorHandler:(MKNKErrorBlock) errorBlock{
    if(self.operation != nil){
        [self.operation cancel];
    }
     self.operation = [[HsNetworkEngine netWorkEngine] urlForTagWithProgressView:tag params:params httpMethod:method completionHandler:urlCompletionBlock errorHandler:errorBlock inView:self];
    
}


- (void)urlForTag:(NSString*) tag  completionHandler:(ResponseBlock) urlCompletionBlock errorHandler:(MKNKErrorBlock) errorBlock{
     [self urlForTag:tag params:nil httpMethod:@"GET" completionHandler:urlCompletionBlock errorHandler:errorBlock];
}
- (void)urlForTag:(NSString*) tag   params:(NSDictionary *)params completionHandler:(ResponseBlock) urlCompletionBlock errorHandler:(MKNKErrorBlock) errorBlock{
     [self urlForTag:tag params:params httpMethod:@"GET" completionHandler:urlCompletionBlock errorHandler:errorBlock];
}

- (void)urlForTag:(NSString*) tag   params:(NSDictionary *)params httpMethod:(NSString*)method  completionHandler:(ResponseBlock) urlCompletionBlock errorHandler:(MKNKErrorBlock) errorBlock{
    
    if(self.operation != nil){
        [self.operation cancel];
    }
    self.operation = [[HsNetworkEngine netWorkEngine] urlForTagWithProgressView:tag params:params httpMethod:method completionHandler:urlCompletionBlock errorHandler:errorBlock inView:nil];
}

//上传文件
- (void)uploadImageFromFile:(NSString*) filePath name:(NSString*)key  mimeType:(NSString *)fileType tag:(NSString*)tag params:(NSDictionary *)params httpMethod:(NSString*)method  completionHandler:(ResponseBlock) urlCompletionBlock errorHandler:(MKNKErrorBlock) errorBlock{
    if(self.operation != nil){
        [self.operation cancel];
    }
    self.operation = [[HsNetworkEngine netWorkEngine] uploadImageFromFile:filePath name:key mimeType:fileType tag:tag params:params httpMethod:method completionHandler:urlCompletionBlock errorHandler:errorBlock];
}

@end
