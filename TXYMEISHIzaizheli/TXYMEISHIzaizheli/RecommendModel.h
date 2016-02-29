//
//  RecommendModel.h
//  TXYMEISHIzaizheli
//
//  Created by qianfeng1 on 16/2/24.
//  Copyright © 2016年 陶星宇. All rights reserved.
//

#import "JSONModel.h"
#import "SancanModel.h"
#import "SubTitleModel.h"
#import "FenleiModel.h"
#import "ZTModel.h"
@interface RecommendModel : JSONModel
@property (nonatomic, strong) SancanModel *san_can;
@property (nonatomic, strong) SubTitleModel *san_can_title;
@property (nonatomic, strong) FenleiModel *fenlei;
@property (nonatomic, strong) ZTModel *zt;

//@property (nonatomic, copy) NSString *title;





//"id": "1649497",
//"titlepic": "http://images.meishij.net/p/20160222/35c768447f78cf80c05394a0f8f51f40.jpg",
//"title": "自制美味素鸡",
//"descr": "豆皮含有人体必需的8种氨基酸，营养价值高",
//"click_type": "5",
//"click_obj": "1649497",
//"pv_trackingURL": "",
//"click_trackingURL": "",
//"sft": "0",
//"is_recipe": "1",
//"is_tj": "1",
//"tj_img": "http://site.meishij.net/r/15/151/1537765/a1537765_144446837623248.jpg",
//"fav_num": "10953",
//"jump": "{\"type\":\"5\",\"class_name\":\"MSRecipeDetailController\",\"property\":{\"recipeId\":\"1649497\"}}"
@end
