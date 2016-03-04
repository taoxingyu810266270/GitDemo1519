//
//  ImgsModel.h
//  TXYMEISHIzaizheli
//
//  Created by qianfeng1 on 16/3/3.
//  Copyright © 2016年 陶星宇. All rights reserved.
//

#import "JSONModel.h"

@interface ImgsModel : JSONModel
@property (nonatomic, copy) NSString *height;
@property (nonatomic, copy) NSString *width;
@property (nonatomic, copy) NSString *big;
@property (nonatomic, copy) NSString *small;


/*
 "small": "http://site.meishij.net/msq/96/157/2664346/s1622664346_145687886728592.jpg",
 "big": "http://site.meishij.net/msq/96/157/2664346/n2664346_145687886728592.jpg",
 "width": "162",
 "height": "162"
 */
@end
