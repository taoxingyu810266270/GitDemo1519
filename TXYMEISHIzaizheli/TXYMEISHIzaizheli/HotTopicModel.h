//
//  HotTopicModel.h
//  TXYMEISHIzaizheli
//
//  Created by qianfeng1 on 16/3/2.
//  Copyright © 2016年 陶星宇. All rights reserved.
//

#import "JSONModel.h"

@interface HotTopicModel : JSONModel
@property (nonatomic, strong) NSDictionary *user_info;
@property (nonatomic, strong) NSString *gid;
@property (nonatomic, strong) NSString *tid;
@property (nonatomic, strong) NSDictionary *from;
@property (nonatomic, strong) NSString *img_num;
@property (nonatomic, strong) NSString *summary;
@property (nonatomic, strong) NSArray *imgs;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSString *comment_num;
@property (nonatomic, strong) NSString *ding_num;


/*
 "user_info": {
 "user_id": "2664346",
 "user_name": "一一描（微信：miao-63）",
 "avatar": "http://site.meishij.net/user/96/157/t2664346_144302158566493.jpg"
 },
 "gid": "20",
 "tid": "989692",
 "from": {
 "gid": "20",
 "type": "1",
 "name": "烹饪秀"
 },
 "img_num": 4,
 "summary": "#炸酱面➕银耳汤#拖油瓶粑粑对今天的炸酱面赞不绝口，吃了一碗多，他说撑死了[偷笑][...",
 "imgs": [
 {
 "small": "http://site.meishij.net/msq/96/157/2664346/s1622664346_145687886728592.jpg",
 "big": "http://site.meishij.net/msq/96/157/2664346/n2664346_145687886728592.jpg",
 "width": "162",
 "height": "162"
 },
 {
 "small": "http://site.meishij.net/msq/96/157/2664346/s1622664346_145687886769481.jpg",
 "big": "http://site.meishij.net/msq/96/157/2664346/n2664346_145687886769481.jpg",
 "width": "162",
 "height": "162"
 },
 {
 "small": "http://site.meishij.net/msq/96/157/2664346/s1622664346_145687887187505.jpg",
 "big": "http://site.meishij.net/msq/96/157/2664346/n2664346_145687887187505.jpg",
 "width": "162",
 "height": "162"
 },
 {
 "small": "http://site.meishij.net/msq/96/157/2664346/s1622664346_145687887111893.jpg",
 "big": "http://site.meishij.net/msq/96/157/2664346/n2664346_145687887111893.jpg",
 "width": "162",
 "height": "162"
 }
 ],
 "time": "08:39发布",
 "comment_num": 11,
 "is_ding": "0",
 "is_cai": "0",
 "ding_num": "12",
 "cai_num": "0",
 "zhiding": "",
 "recipes": [],
 "sourceType": "0"
 }
 */
@end
