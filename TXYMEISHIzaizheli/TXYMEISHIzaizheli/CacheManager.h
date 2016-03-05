//
//  CacheManager.h
//  TXYMEISHIzaizheli
//
//  Created by qianfeng1 on 16/3/5.
//  Copyright © 2016年 陶星宇. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 sdwebimage 缓存原理（图片）就是把请求回来的数据存在本地沙盒里，把这个请求的URL用MD5加密一下 当做文件名称
 */
@interface CacheManager : NSObject
//存数据
+(void)saveData:(id)objecet withUrl:(NSString *)urlStr;
//读数据
+(id)readDataWithUrl:(NSString *)urlStr;

@end
