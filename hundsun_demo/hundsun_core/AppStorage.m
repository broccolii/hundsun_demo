//
//  AppStorage.m
//  GTT_IOS
//
//  Created by allen.huang on 13-7-1.
//  Copyright (c) 2013年 allen.huang. All rights reserved.
//

#import "AppStorage.h"

#define TMPFolder @"TMP"
#define ImageFolder @"Image"
#define AudioFolder @"Audio"
#define FileFolder @"File"
#define FaceFolder @"Face"


@implementation AppStorage
//临时文件
+ (NSString*)tmpPath{
  return [AppStorage folderWithRootCatalog:TMPFolder];
}
//图片
+ (NSString*)imagePath{
   return [AppStorage folderWithRootCatalog:ImageFolder];
}
+ (NSString*)imagePath:(NSString *)subFolder{
    return [AppStorage folderWithSubFolder:subFolder superFolder:AppStorage.imagePath];
}
//音频
+ (NSString*)audioPath{
    return [AppStorage folderWithRootCatalog:AudioFolder];
}
//文档
+ (NSString*)filePath{
    return [AppStorage folderWithRootCatalog:FileFolder];
}
//头像
+ (NSString*)facePath{
    return [AppStorage folderWithRootCatalog:FaceFolder];
}

+ (NSString *)folderWithRootCatalog:(NSString *)folder{//根目录
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *savePath = [paths objectAtIndex:0];
    return [AppStorage folderWithSubFolder:folder superFolder:savePath];
}

+ (NSString *)folderWithSubFolder:(NSString *)folder superFolder:(NSString *)superPath{//根目录
    if(folder == nil || folder.length == 0){
        return superPath;
    }
    NSString *downloadDic = [NSString stringWithFormat:@"%@/%@", superPath, folder];
    // 文件下载存放路径
    NSFileManager *fm = [NSFileManager defaultManager];
    if ( ![fm fileExistsAtPath:downloadDic] )
    {
        [fm createDirectoryAtPath:downloadDic withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return downloadDic;
}


//如果文件不存在 则返回处理后的本地字符串
+ (NSString *)toImagePath:(NSString *)urlString
{
    return [AppStorage convertPath:AppStorage.imagePath withUrl:urlString];
}
+ (NSString *)toTmpPath:(NSString *)urlString{
    return [AppStorage convertPath:AppStorage.tmpPath withUrl:urlString];
}
+ (NSString *)toAudioPath:(NSString *)urlString{
    return [AppStorage convertPath:AppStorage.audioPath withUrl:urlString];
}
+ (NSString *)toFacePath:(NSString *)urlString{
    return [AppStorage convertPath:AppStorage.facePath withUrl:urlString];
}
+ (NSString *)toFilePath:(NSString *)urlString{
    return [AppStorage convertPath:AppStorage.filePath withUrl:urlString];
}

//将指定地址，服务器路径解析成本地路径
+ (NSString*)convertPath:(NSString*)path withUrl:(NSString*)urlString{
    NSFileManager *fm = [NSFileManager defaultManager];
    if ( [fm fileExistsAtPath:urlString] )
    {
        return urlString;
    }else
    {
        NSString *fileName = [urlString lastPathComponent];             // 文件名
        NSString *downPath = [NSString stringWithFormat:@"%@/%@", path,fileName];   // 下载保存的路径
        if([fm fileExistsAtPath:downPath]){
            return downPath;
        }
        return urlString;
    }
}

+ (BOOL)fileIsExists:(NSString *)urlString
{
    NSFileManager *fm = [NSFileManager defaultManager];
    
    if ( [fm fileExistsAtPath:urlString] )
    {
        return YES;
    }
    else
    {
        NSString *fileName = [urlString lastPathComponent];             // 文件名
        NSString *downPath = [AppStorage fetchDownloadDir:fileName];            // 文件下载存放路径
        NSString *path = [NSString stringWithFormat:@"%@/%@", downPath,fileName];   // 下载保存的路径
        
        return [fm fileExistsAtPath:path];
    }
}

#pragma mark - 设置下载目录 参数：根据文件名的后缀判断存在Audio目录还是Download目录
+ (NSString *)fetchDownloadDir:(NSString *)fileName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *savePath = [paths objectAtIndex:0];
    
    NSString *subDic;
    if ([fileName hasSuffix:@".mp3"])
    {
        subDic = AudioFolder;
    }
    else
    {
        subDic = FileFolder;
    }
    
    NSString *downloadDic = [NSString stringWithFormat:@"%@/%@", savePath, subDic];   // 文件下载存放路径
    
    NSFileManager *fm = [NSFileManager defaultManager];
    if ( ![fm fileExistsAtPath:downloadDic] )
    {
        [fm createDirectoryAtPath:downloadDic withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    return downloadDic;
}

@end
