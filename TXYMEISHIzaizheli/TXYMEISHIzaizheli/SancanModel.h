//
//  SancanModel.h
//  TXYMEISHIzaizheli
//
//  Created by qianfeng1 on 16/2/25.
//  Copyright © 2016年 陶星宇. All rights reserved.
//

#import "JSONModel.h"

@interface SancanModel : JSONModel

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *titlepic;
@property (nonatomic, copy) NSString *descr;
@property (nonatomic, copy) NSString *id;

//"id": "501916",
//"titlepic": "http://images.meishij.net/p/20160219/c30eaa3b07ab3f4eb238bfa7c1c5f3f6.jpg",
//"title": "六招教你熬出美味的粥",
//"descr": "掌握熬粥的秘诀，让粥美味又营养",
//"click_type": "5",
//"click_obj": "501916",
//"pv_trackingURL": "",
//"click_trackingURL": "",
//"sft": "0",
//"is_recipe": "1",
//"is_tj": "1",
//"tj_img": "http://images.meishij.net/p/20120511/01fda7e3e152a3d1014d08f629552928_150x150.jpg",
//"fav_num": "3749",
//"jump": "{\"type\":\"5\",\"class_name\":\"MSRecipeDetailController\",\"property\":{\"recipeId\":\"501916\"}}"
@end
