//
//  VideoTableViewCell.m
//  TXYMEISHIzaizheli
//
//  Created by qianfeng1 on 16/3/1.
//  Copyright © 2016年 陶星宇. All rights reserved.
//

#import "VideoTableViewCell.h"
#import "UIImageView+WebCache.h"
@implementation VideoTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)config:(VideoModel *)model {

    [_pictureimageView sd_setImageWithURL:[NSURL URLWithString:model.titlepic]];
    _titleLabel.text = model.title;
    
    if (model.rate >= 1) {
        _star1.image = [UIImage imageNamed:@"star_on_36_1"];
    }else {
        _star1.image = [UIImage imageNamed:@"star_off_36_1"];
    }
    if (model.rate >= 2) {
        _star2.image = [UIImage imageNamed:@"star_on_36_1"];
    }else {
        _star2.image = [UIImage imageNamed:@"star_off_36_1"];
    }
    if (model.rate >= 3) {
        _star3.image = [UIImage imageNamed:@"star_on_36_1"];
    }else {
        _star3.image = [UIImage imageNamed:@"star_off_36_1"];
    }
    if (model.rate >= 4) {
        _star4.image = [UIImage imageNamed:@"star_on_36_1"];
    }else {
        _star4.image = [UIImage imageNamed:@"star_off_36_1"];
    }
    
    if (model.rate >= 5) {
        _star5.image = [UIImage imageNamed:@"star_on_36_1"];
    }else {
        _star5.image = [UIImage imageNamed:@"star_off_36_1"];
    }
    _buzoushijianLabel.text = [NSString stringWithFormat:@"%@/%@",model.step,model.mt];
    _weidaoleixingLabel.text = [NSString stringWithFormat:@"%@/%@",model.gongyi,model.kouwei];


}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
