//
//  CaidanDetailViewController.m
//  TXYMEISHIzaizheli
//
//  Created by qianfeng1 on 16/2/27.
//  Copyright © 2016年 陶星宇. All rights reserved.
//

#import "CaidanDetailViewController.h"
#import "AFNetworking.h"
#import "CaiDanDetailTableViewCell.h"
#import "JHRefresh.h"
@interface CaidanDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong)CaidanfenleiViewController *caidan;
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *dataSource;
@property (nonatomic) NSInteger page;
@property (nonatomic) BOOL isPullDown;
@property (nonatomic) BOOL isloadMore;

@end

@implementation CaidanDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _page = 1;
    _isPullDown = YES;
     _caidan = [[CaidanfenleiViewController alloc]init];
    self.navigationItem.title = _Title;
    [self createtableView];
    [self loadDataSource];
    [self createPullFootRefresh];
    [self createPullHeadRefresh];
    
}
/**
 *  上拉加载
 */
-(void)createPullFootRefresh {
    __weak CaidanDetailViewController *weakself = self;
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

    __weak CaidanDetailViewController *weakself = self;
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
-(void)loadDataSource {
   
        _url = [_caidan con:_Title andnum:_page addim:_im addd:_d];
    

    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    NSSet *currentAcceptSet = manger.responseSerializer.acceptableContentTypes;
    NSMutableSet *mset = [NSMutableSet setWithSet: currentAcceptSet];
    [mset addObject:@"text/html"];
    [mset addObject:@"application/json"];
    manger.responseSerializer.acceptableContentTypes = mset;
    [manger GET:_url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"%@",responseObject);
        NSDictionary *obj = responseObject[@"obj"];
        
        NSArray *data = obj[@"data"];
        NSError *error = nil;
        
        if (_isPullDown) {
            
            self.dataSource = [CaidanDetailModel arrayOfModelsFromDictionaries:data error:&error];
        }else if (_isloadMore)
        {
            [self.dataSource addObjectsFromArray:[CaidanDetailModel arrayOfModelsFromDictionaries:data error:&error]];
        }
        
        
        
        [self EndRefresh];
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        
    }];
}


-(void)createtableView {
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:(UITableViewStyleGrouped)];
    _tableView.delegate = self;
    _tableView.dataSource =self;
    [self.view addSubview: _tableView];

    [_tableView registerNib:[UINib nibWithNibName:@"CaiDanDetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"cellID"];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {



    return self.dataSource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {


    return 180;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CaiDanDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    CaidanDetailModel *model = self.dataSource[indexPath.row];
    [cell config:model];
    return cell;

}



-(void)didReceiveMemoryWarning {
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
