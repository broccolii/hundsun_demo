//
//  NSString+hospitalcloud.h
//  hospitalcloud
//
//  Created by 123 on 14-6-20.
//  Copyright (c) 2014年 chenjiong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (file)

//从app中根据key来取字符串 规则是先从String_bundlename取，如果没有再从String里面取
+ (instancetype)stringWithBundleNameForKey:(NSString *)key;

//从app中根据fileName和ext来取文件 规则是先根据fileName_bundlename取，如果没有再根据fileName取
+ (NSString *)pathWithBundleNameForResource:(NSString *)fileName ofType:(NSString *)ext;


#pragma mark  --------------	file操作   --------------

//文件路径
- (NSString *)appFilePath;
//图片路径
- (NSString *)appImagePath;
//音频路径
- (NSString *)appAudioPath;
// 头像路径
- (NSString *)appFacePath;

//document下的文件地址
- (NSString*)filename_document;
//bundle下的文件地址
- (NSString*)filename_bundle;
//是否是目录
- (BOOL)is_directory;
//文件是否存在
- (BOOL)file_exists;
//文件是否存在在bundle
- (BOOL)file_exists_bundle;
//是否能创建目录
- (BOOL)create_dir;
//文件备份
- (BOOL)file_backup;

//文件备份到指定目录
- (BOOL)file_backup_to:(NSString*)dest;

//获取该文件的大小
- (long long)fileSize;
//获取该文件夹下的大小
- (long long)folderSize;
+ (long long)folderSizeAtPath:(const char*)folderPath;

@end
