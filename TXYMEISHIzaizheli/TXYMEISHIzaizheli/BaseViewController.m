//
//  BaseViewController.m
//  TXYMEISHIzaizheli
//
//  Created by qianfeng1 on 16/2/24.
//  Copyright © 2016年 陶星宇. All rights reserved.
//

#import "BaseViewController.h"
@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.edgesForExtendedLayout = UIRectEdgeNone;
//    self.view.backgroundColor = [UIColor colorWithRed:arc4random()%265/255.0 green:arc4random()%265/255.0 blue:arc4random()%265/255.0 alpha:1.0];
//    self.navigationController.navigationBar.translucent = NO;
//    改变分栏的颜色
    self.tabBarController.tabBar.barTintColor = [UIColor orangeColor];
    
    
//    改变导航的颜色
     self.navigationController.navigationBar.barTintColor = [UIColor orangeColor];
    
    //添加一个通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeColor:) name:@"changeColor" object:nil];
    
}
-(void)changeColor:(NSNotification*)sender {
    NSLog(@"我接受到通知了");
        UIColor *color = sender.object;
     self.navigationController.navigationBar.barTintColor = color;
    
}

-(NSString*)iniURL {
    
    
    return nil;
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
