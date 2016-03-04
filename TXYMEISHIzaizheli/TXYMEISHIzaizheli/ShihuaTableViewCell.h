//
//  ShihuaTableViewCell.h
//  TXYMEISHIzaizheli
//
//  Created by qianfeng1 on 16/3/3.
//  Copyright © 2016年 陶星宇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotTopicModel.h"
@interface ShihuaTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UILabel *namelabel;
@property (weak, nonatomic) IBOutlet UILabel *fromlabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iamgeLabel1;
@property (weak, nonatomic) IBOutlet UIImageView *iamgeLable2;
@property (weak, nonatomic) IBOutlet UIImageView *iamgeLabel3;
@property (weak, nonatomic) IBOutlet UIImageView *imageLabel4;

-(void)config:(HotTopicModel*)model;

@end
