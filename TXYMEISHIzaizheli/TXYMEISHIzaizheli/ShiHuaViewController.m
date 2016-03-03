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
@interface ShiHuaViewController ()<UITableViewDataSource,UITableViewDelegate,CycleScrollViewDelegate>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *activities2dataSource;
@property (nonatomic, strong)NSMutableArray *columndataSource;

@property (nonatomic, strong)UIScrollView *scrollView;
@end

@implementation ShiHuaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self createTableView];
    [self loadSource];

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
    NSLog(@"%@",responseObject);
    NSArray *activities2 = responseObject[@"activities2"];
    NSArray *Column = responseObject[@"column"];
    _activities2dataSource = [ActivtiesModel arrayOfModelsFromDictionaries:activities2];
    _columndataSource = [ColumnModel arrayOfModelsFromDictionaries:Column];
    
    NSLog(@"第一个行数据%@",_activities2dataSource);
    
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
    UIView *heardView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 400)];
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
        
        UIImageView *iamgeView = [[UIImageView alloc]initWithFrame:CGRectMake(25+i*self.view.frame.size.width/4, 250, self.view.frame.size.width/8, self.view.frame.size.width/8)];
        [iamgeView sd_setImageWithURL:[NSURL URLWithString:model.img]];
        
        UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(25+i*self.view.frame.size.width/4, 250+self.view.frame.size.width/8, self.view.frame.size.width/8,30)];
        name.text = model.name;
        name.font = [UIFont systemFontOfSize:12];
        [heardView addSubview:name];
        [heardView addSubview:iamgeView];
    }
    
    
    
}
-(void)clickImgAtIndex:(NSInteger)index {



}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {


    return 10;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
static NSString *cellID = @"cellID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellID];
    }
    cell.textLabel.text =@"asdfasf";
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
