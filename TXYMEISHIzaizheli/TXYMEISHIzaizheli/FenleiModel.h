//
//  FenleiModel.h
//  TXYMEISHIzaizheli
//
//  Created by qianfeng1 on 16/2/25.
//  Copyright © 2016年 陶星宇. All rights reserved.
//

#import "JSONModel.h"

@interface FenleiModel : JSONModel
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *image;


//"title": "菜谱分类",
//"image": "http://static.meishij.net/wap6/images/v6/quanbu.png",
//"click_type": "24",
//"click_obj": "全部菜谱",
//"jump": "{\"type\":\"24\",\"class_name\":\"MSCategoryController\",\"property\":{}}"
@end
