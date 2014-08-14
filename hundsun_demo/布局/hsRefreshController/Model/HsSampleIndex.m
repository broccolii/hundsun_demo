//
//  HsSampleIndex.m
//  快速集成下拉刷新
//
//  Created by Hs on 14-1-3.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "HsSampleIndex.h"

@implementation HsSampleIndex
+ (instancetype)sampleIndexWithTitle:(NSString *)title controllerClass:(Class)controllerClass
{
    HsSampleIndex *si = [[self alloc] init];
    
    si.title = title;
    si.controllerClass = controllerClass;
    
    return si;
}
@end
