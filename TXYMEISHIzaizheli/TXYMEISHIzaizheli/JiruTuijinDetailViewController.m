//
//  JiruTuijinDetailViewController.m
//  TXYMEISHIzaizheli
//
//  Created by qianfeng1 on 16/2/25.
//  Copyright © 2016年 陶星宇. All rights reserved.
//

#import "JiruTuijinDetailViewController.h"
#import "UIWebView+AFNetworking.h"
#import "MMProgressHUD.h"
#import "MMLinearProgressView.h"
#import <WebKit/WebKit.h>
#import "MyfavourViewController.h"
#import "DataBaseManger.h"
@interface JiruTuijinDetailViewController ()<WKNavigationDelegate>
{
    WKWebView *_webView;
}
@property (nonatomic,strong) NSTimer *timer;

@end

@implementation JiruTuijinDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
self.navigationController.navigationBarHidden = NO;
//    self.tabBarController.tabBar.hidden =YES;
//    self.tabBarController.tabBar.alpha = 0;
    _webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    //加载网页 html格式的网页 也可以加载html 格式的字符串 显示成网页
    
    [self.view addSubview:_webView];
    //设置代理
    _webView.navigationDelegate = self;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_url]];
    [_webView loadRequest:request];
    
    UIBarButtonItem *favourbtn = [[UIBarButtonItem alloc]initWithTitle:@"收藏" style:(UIBarButtonItemStylePlain) target:self action:@selector(favourbtnPressed:)];
    
    self.navigationItem.rightBarButtonItem = favourbtn;

}
-(void)favourbtnPressed:(UIBarButtonItem*)item {
    BOOL isExist = [[DataBaseManger shareManager] isExistInfoForid:_model.id];
    
    if (isExist == YES) {
        [[DataBaseManger shareManager] deleteStudent:_model];
        [item setTitle:@"收藏"];
        NSLog(@"111111111");
        isExist = NO;
    }else {
        [[DataBaseManger shareManager]insertStudent:_model ];
        [item setTitle:@"取消收藏"];
        NSLog(@"222222222");

        isExist = YES;
    }
    NSLog(@"1.........11%@",_model);
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"webView 开始加载");
    if (!self.timer) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(updateTimer:) userInfo:nil repeats:YES];
    }
    //设置下载进度
    [MMProgressHUD setProgressViewClass:[MMLinearProgressView class]];
    [MMProgressHUD showDeterminateProgressWithTitle:@"下载" status:@"loading...."];
}
- (void)updateTimer:(NSTimer *)timer {
    //UIWebView
    //修改进度--->获取webView的下载进度_webView.estimatedProgress
    [MMProgressHUD updateProgress:_webView.estimatedProgress];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
//    NSLog(@"webView 完成加载");
    if (self.timer) {
        [self.timer invalidate];//终止
        self.timer = nil;
    }
    [MMProgressHUD dismissWithSuccess:@"下载完成"];
}
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"webView 加载失败");
    if (self.timer) {
        [self.timer invalidate];//终止
        self.timer = nil;
    }
    [MMProgressHUD dismissWithError:@"下载失败"];
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
