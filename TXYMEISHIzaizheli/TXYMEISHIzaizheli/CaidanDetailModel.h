//
//  CaidanDetailModel.h
//  TXYMEISHIzaizheli
//
//  Created by qianfeng1 on 16/2/28.
//  Copyright © 2016年 陶星宇. All rights reserved.
//

#import "JSONModel.h"

@interface CaidanDetailModel : JSONModel
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *titlepic;
@property (nonatomic, copy) NSString *gongyi;
@property (nonatomic, copy) NSString *kouwei;
@property (nonatomic, copy) NSString *mt;
@property (nonatomic) int rate;
@property (nonatomic, copy) NSString *step;



//"id": "191009",
//"title": "微波炉烤红薯",
//"titlepic": "http://images.meishij.net/p/20141026/e2db115ef8899e0e4fb7c87525f217e7_150x150.jpg",
//"gongyi": "微波",
//"kouwei": "甜味",
//"md": "新手尝试",
//"mt": "<5分钟",
//"step": "4",
//"smalltext": "原料：红薯2个。做法：1、红薯洗净，不用擦水，保留外皮的水分。",
//"is_recipe": 1,
//"item_type": "1",
//"rate": "5",
//"is_video": "0",
//"is_fav": 0,
//"is_see": 0
@end
