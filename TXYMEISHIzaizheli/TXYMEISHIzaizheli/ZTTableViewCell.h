//
//  ZTTableViewCell.h
//  TXYMEISHIzaizheli
//
//  Created by qianfeng1 on 16/2/25.
//  Copyright © 2016年 陶星宇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZTModel.h"

@interface ZTTableViewCell : UITableViewCell
@property (nonatomic, strong)UIImageView *iamgeView;
@property (nonatomic, strong)UILabel *title;


-(void)config:(ZTModel*)model;

@end
