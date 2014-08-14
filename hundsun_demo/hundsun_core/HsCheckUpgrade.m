//
//  HsCheckUpgrade.m
//  hospitalcloud_jkhn
//
//  Created by wjd on 14-5-15.
//  Copyright (c) 2014年 hundsun. All rights reserved.
//

#import "HsCheckUpgrade.h"

@interface HsCheckUpgrade ()

@property (nonatomic,strong) NSString *downUrl;
@property (nonatomic,strong) NSString *serviceVersion;

@end

@implementation HsCheckUpgrade

IMP_SINGLETON(HsCheckUpgrade)

- (void)showCheckMessage:(NSString *)message downUrl:(NSString *)url{
    [self showCheckMessage:message downUrl:url ipUp:nil currentVersion:nil];

}
- (void)showCheckMessage:(NSString *)message downUrl:(NSString *)url ipUp:(NSNumber *)isup currentVersion:(NSString *)currentVersion{
    self.serviceVersion = currentVersion;
    self.downUrl = url;
    [self updateUpgradeStatus:YES];
    if(isup.integerValue == 1){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"升级提示" message:[NSString stringWithFormat:@"%@",message] delegate:self cancelButtonTitle:@"升级" otherButtonTitles:nil, nil];
        alertView.tag = 1;
        [alertView show];
    }else{
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSString *localVersion = [userDefaults objectForKey:@"ignoreCurrentVersion"];
        if(![currentVersion isEqual:localVersion]){
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"升级提示" message:[NSString stringWithFormat:@"%@",message] delegate:self cancelButtonTitle:@"忽略此版本" otherButtonTitles:@"升级", nil];
            alertView.tag = 2;
            [alertView show];
        }
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(alertView.tag == 1){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.downUrl]];
    }else{
        if(buttonIndex == 1){
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.downUrl]];
        }else{
            self.downUrl = nil;
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setObject:self.serviceVersion forKey:@"ignoreCurrentVersion"];
            [userDefaults synchronize];
        }
    }
}

- (void)updateUpgradeStatus:(BOOL)needUpgrade{
    
}

@end
