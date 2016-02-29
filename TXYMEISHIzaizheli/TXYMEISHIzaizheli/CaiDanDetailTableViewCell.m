//
//  CaiDanDetailTableViewCell.m
//  TXYMEISHIzaizheli
//
//  Created by qianfeng1 on 16/2/28.
//  Copyright © 2016年 陶星宇. All rights reserved.
//

#import "CaiDanDetailTableViewCell.h"
#import "UIImageView+WebCache.h"
@implementation CaiDanDetailTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
-(void)config:(CaidanDetailModel *)model {
    _titleLabel.text = model.title;
    
    [_icon sd_setImageWithURL:[NSURL URLWithString:model.titlepic]];
    _buzoushijian.text = [NSString stringWithFormat:@"%@步/%@",model.step,model.mt];
    _weidaozuofa.text = [NSString stringWithFormat:@"%@ / %@",model.kouwei,model.gongyi];
    
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
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
