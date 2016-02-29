//
//  CaipuidaquanModel.h
//  TXYMEISHIzaizheli
//
//  Created by qianfeng1 on 16/2/26.
//  Copyright © 2016年 陶星宇. All rights reserved.
//

#import "JSONModel.h"
#import "XifenleiModel.h"

@protocol XifenleiModel <NSObject>
@end


@interface CaipuidaquanModel : JSONModel
@property (nonatomic, copy)NSString *t;
@property (nonatomic)NSInteger im;
@property (nonatomic, strong)NSArray <XifenleiModel> *d;
@end
