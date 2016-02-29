//
//  CaipufenleiTableViewCell.h
//  TXYMEISHIzaizheli
//
//  Created by qianfeng1 on 16/2/26.
//  Copyright © 2016年 陶星宇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CaipuidaquanModel.h"
@interface CaipufenleiTableViewCell : UITableViewCell
@property (nonatomic, strong)UIImageView *imageview;
@property (nonatomic, strong)UILabel *titleLabel;
-(void)config:(CaipuidaquanModel*)model;

@end
