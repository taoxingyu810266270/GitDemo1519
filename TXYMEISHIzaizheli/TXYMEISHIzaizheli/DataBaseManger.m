//
//  DataBaseManger.m
//  TXYMEISHIzaizheli
//
//  Created by qianfeng1 on 16/3/5.
//  Copyright © 2016年 陶星宇. All rights reserved.
//

#import "DataBaseManger.h"
#import "FMDB.h"
//可以防止相互引用
#import "CaidanDetailModel.h"
@interface DataBaseManger ()
//数据库
@property (nonatomic, strong)FMDatabase *dbBase;
//数据库地址
@property (nonatomic, copy)NSString *dbPath;
@end
@implementation DataBaseManger

+(instancetype)shareManager {
    //    非线程安全的
    //    static DataBaseManager *manager = nil;
    //    if (manager == nil) {
    //        manager = [[DataBaseManager alloc]init];
    //
    //    }
    //    return manager;
    
    static DataBaseManger *manager = nil;
    //    dispatch_once_t   只执行一次
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        NSLog(@"只执行一次");
        manager = [[DataBaseManger alloc]init];
        
    });
    return manager;
}
-(instancetype)init {
    
    if (self = [super init]) {
        //        初始化数据库
        //        dbPath
        //        沙盒地址
        NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
        //        数据库地址
        _dbPath = [libraryPath stringByAppendingPathComponent:@"my.sqlite"];
        _dbBase = [FMDatabase databaseWithPath:_dbPath];
        
        //        如果数据库打了 就去创建表
        if ([_dbBase open]) {
            
            
            NSString *sql = @"CREATE TABLE IF NOT EXISTS T_CaidanfenDetail1(c_id TEXT PRIMARY KEY NOT NULL ,c_title TEXT ,c_titlepic TEXT ,c_gongyi TEXT, c_kouwei TEXT, c_mt TEXT, c_step TEXT,type Varchar(1024))";
            
            
            if ([_dbBase executeUpdate:sql]) {
                NSLog(@"创建表成功");
                NSLog(@"%@",NSHomeDirectory());
                
            }else {
                NSLog(@"创建表失败");
                
            }
            
        }
        
        
        
        
        
        
        
    }
    return self;
}
- (NSArray*)readModelsWithRecordType:(NSString *)type {
    
    FMResultSet *rs = nil;
    
    NSMutableArray *arr = [NSMutableArray array];
    
    if ([type isEqualToString:@"story"]) {
        
        NSString *sql = @"select * from T_CaidanfenDetail1 where type = ?";
        
        rs = [_dbBase executeQuery:sql,type];
        
        while ([rs next]) {
            
            CaidanDetailModel *model = [[CaidanDetailModel alloc]init];
            
            model.id = [rs stringForColumn:@"c_id"];
            
            model.title = [rs stringForColumn:@"c_title"];
            model.titlepic = [rs stringForColumn:@"c_titlepic"];
            model.gongyi = [rs stringForColumn:@"c_gongyi"];
            model.kouwei = [rs stringForColumn:@"c_kouwei"];
            model.mt = [rs stringForColumn:@"c_mt"];
            model.step = [rs stringForColumn:@"c_step"];

            
            
            
            [arr addObject:model];
            
        }
        
    }
    
    NSLog(@"%@VVVVVVVVVVVVVVV",arr);
    
    return arr;
    
    
}

//根据指定的类型 返回 这条记录在数据库中是否存在
- (BOOL)isExistInfoForid:(NSString *)spotId{
    
    
    NSString *sql;
    
    FMResultSet *rs = nil;
    
    
    sql = @"select * from T_CaidanfenDetail1 where c_id= ?";
    
    rs = [_dbBase executeQuery:sql,spotId];
    
    
    if ([rs next]) {//查看是否存在  下条记录  如果存在  肯定数据库中有记录
        
        return YES;
        
    }else {
        
        return NO;
    }
    
}

/**
 插入数据
 */
-(void)insertStudent:(CaidanDetailModel*)caidan {
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO T_CaidanfenDetail1(c_id,c_title,c_titlepic,c_gongyi,c_kouwei, c_mt, c_step ,type) VALUES ('%@','%@','%@','%@','%@','%@','%@','%@')",caidan.id,caidan.title,caidan.titlepic,caidan.gongyi,caidan.kouwei,caidan.mt,caidan.step,@"story"];
    BOOL res  = [self.dbBase executeUpdate:sql];
    if (res) {
        NSLog(@"插入数据成功");
    }else {
        NSLog(@"插入失败");
    }
    
    
    
}
///**
// 修改数据
// */
//-(void)updateStudentAge:(Student*)stu{
//    
//    NSString *sql = [NSString stringWithFormat: @"UPDATE T_Student SET s_age = %ld WHERE s_id ='%ld'",stu.age,stu.sid];
//    if ([self.dbBase executeUpdate:sql]) {
//        NSLog(@"修改成功");
//    }else {
//        NSLog(@"修改失败");
//    }
//    
//    
//}
/**
 删除数据
 */
-(void)deleteStudent:(CaidanDetailModel*)caidan {
    
    NSString *sql = [ NSString stringWithFormat: @"DELETE FROM T_CaidanfenDetail1 WHERE c_id = '%@'",caidan.id ];
    BOOL res = [self.dbBase executeUpdate:sql];
    if (res) {
        NSLog(@"删除成功");
    }else {
        NSLog(@"删除失败");
    }
    
    
}
///**
// 查询数据
// */
//-(CaidanDetailModel*)selectStudentByID:(NSInteger)stuID{
//    
//    NSString *sql =[NSString stringWithFormat: @"SELECT * FROM T_Student WHERE s_id = %ld ",stuID];
//    FMResultSet *resultSet = [self.dbBase executeQuery:sql];
//    Student * stu = [[Student alloc]init];
//    
//    while ([resultSet next]) {
//        //得到每个字段的值
//        stu.sid = [resultSet intForColumn:@"s_id"];
//        stu.name = [resultSet stringForColumn:@"s_name"];
//        stu.age = [resultSet intForColumn:@"s_age"];
//        stu.score = [resultSet intForColumn:@"s_score"];
//        stu.sex = [resultSet intForColumn:@"s_sex"];
//        //     NSLog(@"%ld %@ %ld",stu.sid,stu.name,stu.age);
//    }
//    
//    return stu;
//    
//}
///**
// 查询数据   按照年龄
// */
//-(NSArray*)selectStudentByAge:(NSInteger)stuAge
//{
//    NSMutableArray *arr= [NSMutableArray new];
//    NSString *sql =[NSString stringWithFormat: @"SELECT * FROM T_Student WHERE s_age = %ld ",stuAge];
//    FMResultSet *resultSet = [self.dbBase executeQuery:sql];
//    
//    while ([resultSet next]) {
//        CaidanDetailModel * caidan = [[CaidanDetailModel alloc]init];
//        
//        //得到每个字段的值
//        stu.sid = [resultSet intForColumn:@"s_id"];
//        stu.name = [resultSet stringForColumn:@"s_name"];
//        stu.age = [resultSet intForColumn:@"s_age"];
//        stu.score = [resultSet intForColumn:@"s_score"];
//        stu.sex = [resultSet intForColumn:@"s_sex"];
//        [arr addObject:stu];
//        //     NSLog(@"%ld %@ %ld",stu.sid,stu.name,stu.age);
//    }
//    
//    return arr;
//    
//}
///**
// 查询数据   按照年龄 和 多少条数据
// */
//-(NSArray*)selectStudentByAge:(NSInteger)stuAge andLimit:(NSInteger)limit {
//    
//    NSMutableArray *arr= [NSMutableArray new];
//    NSString *sql =[NSString stringWithFormat: @"SELECT * FROM T_Student WHERE s_age = %ld LIMIT %ld",stuAge,limit];
//    FMResultSet *resultSet = [self.dbBase executeQuery:sql];
//    
//    while ([resultSet next]) {
//        Student * stu = [[Student alloc]init];
//        
//        //得到每个字段的值
//        stu.sid = [resultSet intForColumn:@"s_id"];
//        stu.name = [resultSet stringForColumn:@"s_name"];
//        stu.age = [resultSet intForColumn:@"s_age"];
//        stu.score = [resultSet intForColumn:@"s_score"];
//        stu.sex = [resultSet intForColumn:@"s_sex"];
//        [arr addObject:stu];
//        //     NSLog(@"%ld %@ %ld",stu.sid,stu.name,stu.age);
//    }
//    
//    return arr;
//    
//    
//}


@end
