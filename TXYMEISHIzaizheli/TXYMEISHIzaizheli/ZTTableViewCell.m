//
//  ZTTableViewCell.m
//  TXYMEISHIzaizheli
//
//  Created by qianfeng1 on 16/2/25.
//  Copyright © 2016年 陶星宇. All rights reserved.
//

#import "ZTTableViewCell.h"
#import "UIImageView+WebCache.h"
@implementation ZTTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [self createiamge];
    
}

-(void)createiamge {
    _iamgeView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width,200)];
    _title = [[UILabel alloc]initWithFrame:CGRectMake(10, 150, _iamgeView.frame.size.width, 50)];
    
    
    [_iamgeView addSubview:_title];
    
    [self addSubview:_iamgeView];


}

-(void)config:(ZTModel*)model {
    [_iamgeView sd_setImageWithURL:[NSURL URLWithString:model.photo]];
    _title.text = model.title;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
