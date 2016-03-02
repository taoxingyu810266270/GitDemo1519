//
//  VideoTableViewCell.h
//  TXYMEISHIzaizheli
//
//  Created by qianfeng1 on 16/3/1.
//  Copyright © 2016年 陶星宇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoModel.h"
@interface VideoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *pictureimageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *star1;
@property (weak, nonatomic) IBOutlet UIImageView *star2;
@property (weak, nonatomic) IBOutlet UIImageView *star3;
@property (weak, nonatomic) IBOutlet UIImageView *star4;
@property (weak, nonatomic) IBOutlet UIImageView *star5;
@property (weak, nonatomic) IBOutlet UILabel *buzoushijianLabel;
@property (weak, nonatomic) IBOutlet UILabel *weidaoleixingLabel;

-(void)config:(VideoModel*)model;

@end
