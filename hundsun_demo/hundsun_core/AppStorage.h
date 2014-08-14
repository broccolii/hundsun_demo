//
//  AppStorage.h
//  GTT_IOS
//
//  Created by allen.huang on 13-7-1.
//  Copyright (c) 2013年 allen.huang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppStorage : NSObject

//文件根目录
+ (NSString *)folderWithRootCatalog:(NSString *)folder;
//folder：子目录 superPath：父目录
+ (NSString *)folderWithSubFolder:(NSString *)folder superFolder:(NSString *)superPath;//根目录
//临时目录
+ (NSString*)tmpPath;
//图片目录
+ (NSString*)imagePath;
//subFolder：在图片目录下的子目录
+ (NSString*)imagePath:(NSString *)subFolder;
//音频目录
+ (NSString*)audioPath;
//文件目录
+ (NSString*)filePath;
//表情目录
+ (NSString*)facePath;

//将urlString转换成本地文件地址  如果urlString是本地地址且存在该文件，则不做任何处理
+ (NSString *)toImagePath:(NSString *)urlString;//图片
+ (NSString *)toTmpPath:(NSString *)urlString;//临时
+ (NSString *)toAudioPath:(NSString *)urlString;//音频
+ (NSString *)toFacePath:(NSString *)urlString;//头像
+ (NSString *)toFilePath:(NSString *)urlString;//文档

//文件是否存在 如果urlString不是本地地址，则会根据规则拼接去相应的文件夹找
+ (BOOL)fileIsExists:(NSString *)urlString;


@end
