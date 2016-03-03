//
//  MEViewController.m
//  TXYMEISHIzaizheli
//
//  Created by qianfeng1 on 16/3/1.
//  Copyright © 2016年 陶星宇. All rights reserved.
//

#import "MEViewController.h"

@interface MEViewController ()
@property (weak, nonatomic) IBOutlet UIButton *fabuLabel;
@property (weak, nonatomic) IBOutlet UIButton *maicaiqingdanLabel;
@property (weak, nonatomic) IBOutlet UIButton *caogaoxiangLabel;
@property (weak, nonatomic) IBOutlet UIButton *dingdanLabel;
@property (weak, nonatomic) IBOutlet UIButton *downloadLabel;
@property (weak, nonatomic) IBOutlet UIButton *zhanneixinLabel;
@property (weak, nonatomic) IBOutlet UIButton *shoucangLabel;
@property (weak, nonatomic) IBOutlet UIButton *setLabel;

@end

@implementation MEViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _fabuLabel.imageEdgeInsets = UIEdgeInsetsMake(0, 20, 40, 20);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
