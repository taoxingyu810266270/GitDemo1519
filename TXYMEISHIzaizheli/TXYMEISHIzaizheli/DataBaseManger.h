//
//  DataBaseManger.h
//  TXYMEISHIzaizheli
//
//  Created by qianfeng1 on 16/3/5.
//  Copyright © 2016年 陶星宇. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CaidanDetailModel;

@interface DataBaseManger : NSObject
/**
 获得数据库单例
 */
+(instancetype)shareManager;
/**
 插入数据
 */
-(void)insertStudent:(CaidanDetailModel*)caidan;
///**
// 修改数据
// */
//-(void)updateStudentAge:(CaidanDetailModel*)caidan;
/**
 删除数据
 */
-(void)deleteStudent:(CaidanDetailModel*)caidan;
///**
// 查询数据
// */
//-(CaidanDetailModel*)selectStudentByID:(NSInteger)stuID;
///**
// 查询数据   按照id
// */
//-(NSArray*)selectcaidanByid:(NSInteger)caidanid;
///**
// 查询数据   按照年龄 和 多少条数据
// */
//-(NSArray*)selectcaidanid:(NSString*)caidanid andLimit:(NSInteger)limit;
//
@end
