//
//  MyfavourViewController.m
//  TXYMEISHIzaizheli
//
//  Created by qianfeng1 on 16/3/5.
//  Copyright © 2016年 陶星宇. All rights reserved.
//

#import "MyfavourViewController.h"

@interface MyfavourViewController ()

@end

@implementation MyfavourViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的收藏";

    NSLog(@"%@",self.dataSource);
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
