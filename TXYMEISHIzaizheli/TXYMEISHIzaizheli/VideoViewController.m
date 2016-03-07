//
//  VideoViewController.m
//  TXYMEISHIzaizheli
//
//  Created by qianfeng1 on 16/2/29.
//  Copyright © 2016年 陶星宇. All rights reserved.
//

#import "VideoViewController.h"
#import "AFNetworking.h"
#import "Define.h"
#import "VideoModel.h"
#import "JHRefresh.h"
#import "VideoTableViewCell.h"
#import "JiruTuijinDetailViewController.h"
#import "CacheManager.h"
@interface VideoViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *dataSource;
@property (nonatomic, strong)UIScrollView *scrollView;
@property (nonatomic) NSInteger page;
@property (nonatomic)BOOL isPullDown;
@property (nonatomic)BOOL isloadMore;

@end

@implementation VideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _page = 1;
    [self createtableView];
    [self loadDataSource];
    [self createPullFootRefresh];
    [self createPullHeadRefresh];

}

/**
 *  上拉加载
 */
-(void)createPullFootRefresh {
    __weak VideoViewController *weakself = self;
    [self.tableView addRefreshFooterViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        _isloadMore = YES;
        weakself.page++;
        [weakself loadDataSource];
    }];
    
    
}
/**
 *  下拉刷新
 */
-(void)createPullHeadRefresh {
    
    __weak VideoViewController *weakself = self;
    [self.tableView addRefreshHeaderViewWithAniViewClass:[JHRefreshAmazingAniView class] beginRefresh:^{
        _isPullDown = YES;
        weakself.page=1;
        [weakself loadDataSource];
        
    }];
    
    
}
-(void)EndRefresh {
    if (_isloadMore) {
        [self.tableView footerEndRefreshing];
        _isloadMore = NO;
    }else if (_isPullDown)
    {
        [self.tableView headerEndRefreshingWithResult:(JHRefreshResultSuccess)];
        _isPullDown = NO;
    }
    
    
    
}

/**
 *  创建tableView
 */
-(void)createtableView {

    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64) style:(UITableViewStylePlain)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];
    [_tableView registerNib:[UINib nibWithNibName:@"VideoTableViewCell" bundle:nil] forCellReuseIdentifier:@"cellID"];
    

}

-(NSString*)indata {

    NSString *str = [NSString stringWithFormat:kVideoDetail,_page];
    return str;

}

-(void)loadDataSource {

    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];


    NSSet *currentAcceptSet = manger.responseSerializer.acceptableContentTypes;
    NSMutableSet *mset = [NSMutableSet setWithSet:currentAcceptSet];
    [mset addObject:@"text/html"];
    [mset addObject:@"application/json"];
    manger.responseSerializer.acceptableContentTypes = mset;
    
    
[manger GET:[self indata] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//    将数据保存到沙盒中
    [CacheManager saveData:responseObject withUrl:[self indata]];
    NSLog(@"%@",responseObject);
    NSDictionary *obj = responseObject[@"obj"];
    NSString *title = obj[@"title"];
    self.title = title;
       NSArray *data = obj[@"data"];
    self.dataSource = [VideoModel arrayOfModelsFromDictionaries:data ];
    NSError *error= nil;
    
    if (_isPullDown) {
        
        self.dataSource = [VideoModel arrayOfModelsFromDictionaries:data error:&error ];
        NSLog(@"%@",error);
    }else if (_isloadMore)
    {
        [self.dataSource addObjectsFromArray:[VideoModel arrayOfModelsFromDictionaries:data error:&error]];
        NSLog(@"%@",error);
    }
    
    
//    [self EndRefresh];
    [self.tableView reloadData];
    
    
} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    NSLog(@"%@",error);
}];


}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {


    return self.dataSource.count;
    
}



-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    VideoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    
    
    VideoModel *model = self.dataSource[indexPath.row];
    
    [cell config:model];
    
    return cell;

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {


    return 145;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    JiruTuijinDetailViewController *vc = [[JiruTuijinDetailViewController alloc]init];
    VideoModel *model = self.dataSource[indexPath.row];
    vc.url = [NSString stringWithFormat:kWebDetail,model.id];
    
    
    [self.navigationController pushViewController:vc animated:YES];


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
