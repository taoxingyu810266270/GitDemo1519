//
//  TabBarViewController.m
//  TXYMEISHIzaizheli
//
//  Created by qianfeng1 on 16/2/24.
//  Copyright © 2016年 陶星宇. All rights reserved.
//

#import "TabBarViewController.h"
#import "BaseViewController.h"
#import "RecommendViewController.h"
#import "MEViewController.h"
@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createViewControllers];
}

-(void)createViewControllers {
    UIImage *iamge = [[UIImage imageNamed:@"home_recipe.png"]imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    UIImage *imageHL = [[UIImage imageNamed:@"home_reciped.png"]imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    UITabBarItem *Item = [[UITabBarItem alloc]initWithTitle:@"推荐" image:iamge selectedImage:imageHL];
    RecommendViewController *vc = [[RecommendViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
    vc.tabBarItem = Item;
    vc.title = @"推荐";
    
    UIImage *iamge1 = [[UIImage imageNamed:@"home_user"]imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    UIImage *imageHL1 = [[UIImage imageNamed:@"home_usered"]imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    UITabBarItem *Item1 = [[UITabBarItem alloc]initWithTitle:@"我的" image:iamge1 selectedImage:imageHL1];
    MEViewController *vc1 = [[MEViewController alloc]init];
    UINavigationController *nav1 = [[UINavigationController alloc]initWithRootViewController:vc1];
//    nav.navigationBar.alpha = 0.0;
    
    vc1.tabBarItem = Item1;
    vc1.title = @"我的";
    self.viewControllers = @[nav,nav1];
    

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
