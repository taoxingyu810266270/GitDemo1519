//
//  CaiDanDetailTableViewCell.h
//  TXYMEISHIzaizheli
//
//  Created by qianfeng1 on 16/2/28.
//  Copyright © 2016年 陶星宇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CaidanDetailModel.h"
@interface CaiDanDetailTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *star1;
@property (weak, nonatomic) IBOutlet UIImageView *star3;
@property (weak, nonatomic) IBOutlet UIImageView *star2;
@property (weak, nonatomic) IBOutlet UIImageView *star5;
@property (weak, nonatomic) IBOutlet UIImageView *star4;
@property (weak, nonatomic) IBOutlet UIImageView *caimao;
@property (weak, nonatomic) IBOutlet UIImageView *huomiao;
@property (weak, nonatomic) IBOutlet UILabel *buzoushijian;
@property (weak, nonatomic) IBOutlet UILabel *weidaozuofa;

-(void)config:(CaidanDetailModel*)model;

@end
