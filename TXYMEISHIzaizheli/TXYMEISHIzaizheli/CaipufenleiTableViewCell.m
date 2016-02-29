//
//  CaipufenleiTableViewCell.m
//  TXYMEISHIzaizheli
//
//  Created by qianfeng1 on 16/2/26.
//  Copyright © 2016年 陶星宇. All rights reserved.
//

#import "CaipufenleiTableViewCell.h"

@implementation CaipufenleiTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [self createview];
}

-(void)createview {
    _imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100, 50)];
    
    [self addSubview:_imageview];
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 50, 100, 36)];
    _titleLabel.font = [UIFont systemFontOfSize:14];
    _titleLabel.textAlignment = NSTextAlignmentCenter;

    [self addSubview:_titleLabel];

}
-(void)config:(CaipuidaquanModel*)model {
    _titleLabel.text = model.t;

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
