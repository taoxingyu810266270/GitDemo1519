//
//  XifenleiCollectionViewCell.m
//  TXYMEISHIzaizheli
//
//  Created by qianfeng1 on 16/2/27.
//  Copyright © 2016年 陶星宇. All rights reserved.
//

#import "XifenleiCollectionViewCell.h"
#import "UIImageView+WebCache.h"
@interface XifenleiCollectionViewCell ()

@property (nonatomic, strong)UIImageView *imageView;
@property (nonatomic, strong)UILabel *titleLabel;

@end

@implementation XifenleiCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    if (self) {
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 80, 80)];
        
        [self.contentView addSubview:_imageView];
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 80, 80, 30)];
        _titleLabel.font = [UIFont systemFontOfSize:17];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_titleLabel];
        
    }
    return self;
}
-(void)config:(XifenleiModel*)model {
    _titleLabel.text = model.t;

    [_imageView sd_setImageWithURL:[NSURL URLWithString:model.i]];

}

@end
