//
//  NSString+hospitalcloud.m
//  hospitalcloud
//
//  Created by 123 on 14-6-20.
//  Copyright (c) 2014年 chenjiong. All rights reserved.
//

#import "NSString+file.h"
#include <sys/stat.h>
#include <dirent.h>
#import "HsAppPlatform.h"

@implementation NSString (file)

+ (instancetype)stringWithBundleNameForKey:(NSString *)key{
    NSString *table = [@"String" stringByAppendingString:[HsAppPlatform bundleName]];
    NSString *value = NSLocalizedStringFromTable(key, table, nil);
    if(value == nil || [key isEqualToString:value]){//如果String_bundleName里面没有 则从String公共里面去取
        value = NSLocalizedStringFromTable(key, @"String", nil);
    }
    return value;
}

+ (NSString *)pathWithBundleNameForResource:(NSString *)fileName ofType:(NSString *)ext{
    NSString *path = [[NSBundle mainBundle] pathForResource:[fileName  stringByAppendingString:[HsAppPlatform bundleName]] ofType:ext];
    if(path == nil){
        path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@",fileName] ofType:ext];
    }
    return path;
}


#pragma mark File

//文件路径
- (NSString *)appFilePath{
    return [AppStorage filePath];
}
//图片路径
- (NSString *)appImagePath{
    return [AppStorage imagePath];
}
//音频路径
- (NSString *)appAudioPath{
    return [AppStorage audioPath];
}
// 头像路径
- (NSString *)appFacePath{
    return [AppStorage facePath];
}

- (NSString*)filename_document
{
    return [AppStorage folderWithRootCatalog:self];
}

- (NSString*)filename_bundle
{
    return [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:self];
}

- (BOOL)is_directory
{
	BOOL	b;
    NSFileManager *file_manager = [NSFileManager defaultManager];
	[file_manager fileExistsAtPath:[self filename_document] isDirectory:&b];
	return b;
}

- (BOOL)file_exists
{
    NSFileManager *file_manager = [NSFileManager defaultManager];
    return [file_manager fileExistsAtPath:[self filename_document]];
}

- (BOOL)file_exists_bundle
{
    NSFileManager *file_manager = [NSFileManager defaultManager];
    return [file_manager fileExistsAtPath:[self filename_bundle]];
}

- (BOOL)create_dir
{
	NSFileManager*	manager = [NSFileManager defaultManager];
	return [manager createDirectoryAtPath:[self filename_document] withIntermediateDirectories:YES attributes:nil error:nil];
}

- (BOOL)file_backup
{
	NSError* error;
    
	if ([[self filename_document] file_exists])
		return NO;
	else
	{
		[[NSFileManager defaultManager]
         //linkItemAtPath:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:name]
         copyItemAtPath:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:self]
         toPath:[self filename_document]
         error:&error];
        //handler:nil];
		if (error != nil)
		{
			NSLog(@"ERROR backup: %@", error.localizedDescription);
			return NO;
		}
		else
			return YES;
	}
    
	return NO;
}

- (BOOL)file_backup_to:(NSString*)dest
{
	return [[NSString stringWithFormat:@"%@/%@", dest, self] file_backup];
}

//获取改文件的大小
- (long long) fileSize
{
    struct stat st;
    if(lstat([self cStringUsingEncoding:NSUTF8StringEncoding], &st) == 0){
        return st.st_size;
    }
    return 0;
}

//获取该文件夹下的大小
- (long long)folderSize
{
    return [NSString folderSizeAtPath:[self cStringUsingEncoding:NSUTF8StringEncoding]];
}

+ (long long)folderSizeAtPath:(const char*)folderPath
{
    long long folderSize = 0;
    DIR* dir = opendir(folderPath);
    if (dir == NULL) return 0;
    struct dirent* child;
    while ((child = readdir(dir))!=NULL) {
        if (child->d_type == DT_DIR && (
                                        (child->d_name[0] == '.' && child->d_name[1] == 0) || // 忽略目录 .
                                        (child->d_name[0] == '.' && child->d_name[1] == '.' && child->d_name[2] == 0) // 忽略目录 ..
                                        )) continue;
        
        int folderPathLength = strlen(folderPath);
        char childPath[1024]; // 子文件的路径地址
        stpcpy(childPath, folderPath);
        if (folderPath[folderPathLength-1] != '/'){
            childPath[folderPathLength] = '/';
            folderPathLength++;
        }
        stpcpy(childPath+folderPathLength, child->d_name);
        childPath[folderPathLength + child->d_namlen] = 0;
        if (child->d_type == DT_DIR){ // directory
            folderSize += [NSString folderSizeAtPath:childPath]; // 递归调用子目录
            // 把目录本身所占的空间也加上
            struct stat st;
            if(lstat(childPath, &st) == 0) folderSize += st.st_size;
        }else if (child->d_type == DT_REG || child->d_type == DT_LNK){ // file or link
            struct stat st;
            if(lstat(childPath, &st) == 0) folderSize += st.st_size;
        }
    }
    return folderSize;
}

@end
