//
//  ColumnModel.h
//  TXYMEISHIzaizheli
//
//  Created by qianfeng1 on 16/3/2.
//  Copyright © 2016年 陶星宇. All rights reserved.
//

#import "JSONModel.h"

@interface ColumnModel : JSONModel
@property (nonatomic, strong) NSString *gid;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *img;

//"gid": "20",
//"type": "1",
//"name": "餐桌食光",
//"img": "http://static.meishij.net/wap/images/v6/zhms1.png"
@end
