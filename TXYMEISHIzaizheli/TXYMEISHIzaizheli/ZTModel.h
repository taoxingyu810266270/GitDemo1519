//
//  ZTModel.h
//  TXYMEISHIzaizheli
//
//  Created by qianfeng1 on 16/2/25.
//  Copyright © 2016年 陶星宇. All rights reserved.
//

#import "JSONModel.h"

@interface ZTModel : JSONModel
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *f_s_type;
@property (nonatomic, copy) NSString *photo;


//"id": "7965698",
//"title": "春季养肝正当时",
//"type": "1",
//"tj_type": "0",
//"f_s_type": "http://m.meishij.net/huodong/zt.php?zt_id=83",
//"photo": "http://images.meishij.net/p/20160219/8e368ab9c94f159ceb46926d670eedab.jpg",
//"descr": "",
//"jump": "{\"type\":\"103\",\"class_name\":\"MSJWebAdvViewController\",\"property\":{\"urlString\":\"http:\\/\\/m.meishij.net\\/huodong\\/zt.php?zt_id=83\"}}"
@end
