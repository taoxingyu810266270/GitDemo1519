//
//  ShiHuaViewController.m
//  TXYMEISHIzaizheli
//
//  Created by qianfeng1 on 16/3/2.
//  Copyright © 2016年 陶星宇. All rights reserved.
//

#import "ShiHuaViewController.h"
#import "Define.h"
#import "AFNetworking.h"
#import "ActivtiesModel.h"
#import "ColumnModel.h"
#import "HotTopicModel.h"
#import "UIImageView+WebCache.h"
#import "CycleScrollView.h"
#import "ShihuaTableViewCell.h"
#import "JHRefresh.h"
@interface ShiHuaViewController ()<UITableViewDataSource,UITableViewDelegate,CycleScrollViewDelegate>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *activities2dataSource;
@property (nonatomic, strong)NSMutableArray *columndataSource;
@property (nonatomic, strong)NSMutableArray *hotTopicdataSource;
@property (nonatomic, strong)UIScrollView *scrollView;

@property (nonatomic) NSInteger page;
@property (nonatomic) BOOL isPullDown;
@property (nonatomic) BOOL isloadMore;
@end

@implementation ShiHuaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _hotTopicdataSource = [NSMutableArray new];
    _page = 1;
    self.view.backgroundColor= [UIColor redColor];
    
    [self loadSource];
    
    [self createPullFootRefresh];
    [self createPullHeadRefresh];
}


/**
 *  上拉加载
 */
-(void)createPullFootRefresh {
    __weak ShiHuaViewController *weakself = self;
    [self.tableView addRefreshFooterViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        _isloadMore = YES;
        weakself.page++;
        [weakself loadSource];
    }];
}
/**
 *  下拉刷新
 */
-(void)createPullHeadRefresh {
    __weak ShiHuaViewController *weakself = self;
    [self.tableView addRefreshHeaderViewWithAniViewClass:[JHRefreshAmazingAniView class] beginRefresh:^{
        _isPullDown = YES;
        weakself.page=1;
        [weakself loadSource];
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
 *  添加数据源
 */
-(void)loadSource {

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSSet *currentAcceptSet = manager.responseSerializer.acceptableContentTypes;
    NSMutableSet *mset = [NSMutableSet setWithSet:currentAcceptSet];
    [mset addObject:@"text/html"];
    [mset addObject:@"application/json"];
    
    manager.responseSerializer.acceptableContentTypes = mset;
[manager GET:kShiHuaTop parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
    NSArray *activities2 = responseObject[@"activities2"];
    NSArray *Column = responseObject[@"column"];
    
    NSArray *hottopic = responseObject[@"hot_topic"];
      _activities2dataSource = [ActivtiesModel arrayOfModelsFromDictionaries:activities2];
    NSError *error = nil;
      _columndataSource = [ColumnModel  arrayOfModelsFromDictionaries:Column];
    _hotTopicdataSource = [HotTopicModel arrayOfModelsFromDictionaries:hottopic error:&error];
        if (_isPullDown) {
    _activities2dataSource = [ActivtiesModel arrayOfModelsFromDictionaries:activities2];
    
    _columndataSource = [ColumnModel arrayOfModelsFromDictionaries:Column];
    _hotTopicdataSource = [HotTopicModel arrayOfModelsFromDictionaries:hottopic];

    NSLog(@"%@",error);

        }else if(_isloadMore){
    NSString *str = [NSString stringWithFormat:KShiHuaBottom,_page];
    [manager GET:str parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
    NSArray *hottopic = responseObject[@"hot_topic"];
    NSError *error = nil;
    [_hotTopicdataSource addObjectsFromArray: [HotTopicModel arrayOfModelsFromDictionaries:hottopic error:&error]];
    NSLog(@"%@",error);
    [self createTableView];
                
     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
      {
        NSLog(@"%@",error);
     }];
     }
    
    [self EndRefresh];

    [self createTableView];

} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    NSLog(@"%@",error);
}];
}


/**
 *  创建tableview
 */
-(void)createTableView {
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-49) style:(UITableViewStyleGrouped)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    UIView *heardView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 350)];
    CycleScrollView *cycleScroll = [[CycleScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
    NSMutableArray *array = [NSMutableArray new];
    for (ActivtiesModel *model in _activities2dataSource) {
        [array addObject:model.img];
    }
    cycleScroll.urlArray = array;
    cycleScroll.delegate = self;
    cycleScroll.autoScroll = YES;
    cycleScroll.autoTime = 2.5f;
    [heardView addSubview:cycleScroll];
    _tableView.tableHeaderView = heardView;
    for (int i = 0; i<_columndataSource.count;i++) {
        ColumnModel *model = self.columndataSource[i];
        
        UIImageView *iamgeView = [[UIImageView alloc]initWithFrame:CGRectMake(25+i*self.view.frame.size.width/4, 220, self.view.frame.size.width/8, self.view.frame.size.width/8)];
        [iamgeView sd_setImageWithURL:[NSURL URLWithString:model.img]];
        
        UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(25+i*self.view.frame.size.width/4, 220+self.view.frame.size.width/8, self.view.frame.size.width/8+20,30)];
        name.text = model.name;
        name.font = [UIFont systemFontOfSize:12];
        [heardView addSubview:name];
        [heardView addSubview:iamgeView];
    }
    
    [_tableView registerNib:[UINib nibWithNibName:@"ShihuaTableViewCell" bundle:nil] forCellReuseIdentifier:@"cellID"];
    self.tableView.estimatedRowHeight = 50;

}
-(void)clickImgAtIndex:(NSInteger)index {



}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    UIView *View = [[UIView alloc]init];
    
    

    return View;

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {


    return self.hotTopicdataSource.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ShihuaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    HotTopicModel *model = self.hotTopicdataSource[indexPath.row];
    [cell config:model];
    
    return cell;

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
