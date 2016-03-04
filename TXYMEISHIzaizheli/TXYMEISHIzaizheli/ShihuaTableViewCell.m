//
//  ShihuaTableViewCell.m
//  TXYMEISHIzaizheli
//
//  Created by qianfeng1 on 16/3/3.
//  Copyright © 2016年 陶星宇. All rights reserved.
//

#import "ShihuaTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "ImgsModel.h"
@implementation ShihuaTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)config:(HotTopicModel *)model {

    _detailLabel.text = model.summary;
    NSDictionary *userinfo = model.user_info;
    NSString*avatar = userinfo[@"avatar"];
    [_userImage sd_setImageWithURL:[NSURL URLWithString:avatar]];
    _userImage.layer.masksToBounds = YES;
    _userImage.layer.cornerRadius = 20;
    NSString *username = userinfo[@"user_name"];
    _namelabel.text = username;
    NSDictionary *from = model.from;
    NSLog(@"%@",from);
    NSString *name = from[@"name"];
    NSLog(@"%@",name);
    _fromlabel.text = [NSString stringWithFormat:@"%@ 来自%@",model.time,name];
    NSLog(@"%ld",model.imgs.count);
    if(model.imgs.count>=1)
    {
        ImgsModel *imodel = model.imgs[0];
        [_iamgeLabel1 sd_setImageWithURL:[NSURL URLWithString:imodel.small]];

    }
    if(model.imgs.count>=2)
    {
        ImgsModel *imodel = model.imgs[1];
        [_iamgeLable2 sd_setImageWithURL:[NSURL URLWithString:imodel.small]];

    }
    if(model.imgs.count>=3)
    {
        ImgsModel *imodel = model.imgs[2];
        [_iamgeLabel3 sd_setImageWithURL:[NSURL URLWithString:imodel.small]];


    }
    if(model.imgs.count==4)
    {
        ImgsModel *imodel = model.imgs[3];
        [_imageLabel4 sd_setImageWithURL:[NSURL URLWithString:imodel.small]];

    }

    

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
