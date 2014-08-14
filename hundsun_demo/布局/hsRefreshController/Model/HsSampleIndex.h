//
//  HsSampleIndex.h
//  快速集成下拉刷新
//
//  Created by Hs on 14-1-3.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HsSampleIndex : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) Class controllerClass;

+ (instancetype)sampleIndexWithTitle:(NSString *)title controllerClass:(Class)controllerClass;
@end