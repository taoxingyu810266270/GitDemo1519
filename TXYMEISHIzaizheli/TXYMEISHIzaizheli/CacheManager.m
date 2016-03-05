//
//  CacheManager.m
//  TXYMEISHIzaizheli
//
//  Created by qianfeng1 on 16/3/5.
//  Copyright © 2016年 陶星宇. All rights reserved.
//

#import "CacheManager.h"
#import "NSString+Hashing.h"
@implementation CacheManager
//指定一个存数据的路径 方便存取
+(NSString*)cacheDirectory {
//创建一个路径
    NSString *cacheDir = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
    cacheDir = [cacheDir stringByAppendingPathComponent:@"maycache"];

    NSError *error;
    BOOL bret = [[NSFileManager defaultManager]createDirectoryAtPath:cacheDir withIntermediateDirectories:YES attributes:nil error:&error];
    if (!bret) {
        return nil;
    }
    return cacheDir;
}
//返回 指定URL  数据保存的全部路径
+(NSString*)fullPathWithUrl:(NSString*)urlStr{
    //先去得到缓存的路径
    NSString *cacheDir = [self cacheDirectory];
    
    //    得到URL加密以后的字符串
    NSString *md5Str = [urlStr MD5Hash];
    //    拼成完整的路径
    NSString *fullPath = [cacheDir stringByAppendingPathComponent:md5Str];
    
    return fullPath;
    
}


//存数据
+(void)saveData:(id)objecet withUrl:(NSString *)urlStr {
    //    首先拿到 文件存的地址
    NSString *path = [self fullPathWithUrl:urlStr];
    //    把对象转为二进制数据
    NSData *data  = [NSKeyedArchiver archivedDataWithRootObject:objecet];
    //    把数据写入文件
    [data writeToFile:path atomically:YES];
    
}
//读数据
+(id)readDataWithUrl:(NSString *)urlStr {
    //      先把URL 转换为地址路径
    NSString *path  =[self fullPathWithUrl:urlStr];
    
    //    读取数据
    NSData *data = [NSData dataWithContentsOfFile:path];
    //    最后返回的时候 需要把二进制数据转化为对象 （解归档）
    return [NSKeyedUnarchiver unarchiveObjectWithData:data ] ;
}
@end
