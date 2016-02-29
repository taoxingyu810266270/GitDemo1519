//
//  JiruTuijinDetailViewController.m
//  TXYMEISHIzaizheli
//
//  Created by qianfeng1 on 16/2/25.
//  Copyright © 2016年 陶星宇. All rights reserved.
//

#import "JiruTuijinDetailViewController.h"
#import "UIWebView+AFNetworking.h"
@interface JiruTuijinDetailViewController ()<UIWebViewDelegate>
@property (nonatomic)UIWebView *myWebView;
@end

@implementation JiruTuijinDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
self.navigationController.navigationBarHidden = NO;
//    self.tabBarController.tabBar.hidden =YES;
//    self.tabBarController.tabBar.alpha = 0;
    _myWebView = [[UIWebView alloc]initWithFrame:self.view.frame];
    
    _myWebView.delegate = self;
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_url]];
    
    [_myWebView loadRequest:request];
    [self.view addSubview:_myWebView];

}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"%@",error);


}
-(void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"hello");
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
