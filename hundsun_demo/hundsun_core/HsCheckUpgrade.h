//
//  HsCheckUpgrade.h
//  hospitalcloud_jkhn
//
//  Created by wjd on 14-5-15.
//  Copyright (c) 2014年 hundsun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HsCheckUpgrade : NSObject

HEAD_SINGLETON(HsCheckUpgrade)

- (void)showCheckMessage:(NSString *)message downUrl:(NSString *)url ipUp:(NSString *)isup currentVersion:(NSString *)currentVersion;

- (void)showCheckMessage:(NSString *)message downUrl:(NSString *)url;

@end
