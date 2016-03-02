//
//  VideoModel.h
//  TXYMEISHIzaizheli
//
//  Created by qianfeng1 on 16/3/1.
//  Copyright © 2016年 陶星宇. All rights reserved.
//

#import "JSONModel.h"

@interface VideoModel : JSONModel
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *titlepic;
@property (nonatomic, copy) NSString *gongyi;
@property (nonatomic, copy) NSString *kouwei;
@property (nonatomic, copy) NSString *step;
@property (nonatomic, copy) NSString *mt;

@property (nonatomic) int rate;

//{
//    "title": "视频菜谱合辑",
//    "photo": "http://static.meishij.net/images/mobileimg/dashu_topimg.jpg",
//    "words": "视频菜谱",
//    "total": 42,
//    "data": [
//             {
//                 "id": "1640235",
//                 "title": "川贝炖雪梨",
//                 "titlepic": "http://site.meishij.net/r/85/125/4406335/a4406335_143685509320077.jpg",
//                 "gongyi": "煮",
//                 "kouwei": "酸甜味",
//                 "md": "新手尝试",
//                 "mt": "<数小时",
//                 "step": "2",
//                 "smalltext": "川贝炖雪梨",
//                 "is_recipe": 1,
//                 "item_type": "1",
//                 "rate": 4,
//                 "is_video": "1",
//                 "is_fav": 0,
//                 "is_see": 0
//             },
//

@end