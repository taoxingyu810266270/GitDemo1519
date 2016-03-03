//
//  ActivtiesModel.h
//  TXYMEISHIzaizheli
//
//  Created by qianfeng1 on 16/3/2.
//  Copyright © 2016年 陶星宇. All rights reserved.
//

#import "JSONModel.h"

@interface ActivtiesModel : JSONModel
@property (nonatomic, strong) NSString *hid;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *huodong_type;
@property (nonatomic, strong) NSString *img;


/*"hid": "97",
 "type": "2",
 "huodong_type": "4",
 "img": "http://static.meishij.net/zt/images/ad/liuye_xian.jpg"*/
@end
