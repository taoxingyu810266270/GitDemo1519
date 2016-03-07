//
//  MyfavourViewController.m
//  TXYMEISHIzaizheli
//
//  Created by qianfeng1 on 16/3/5.
//  Copyright © 2016年 陶星宇. All rights reserved.
//

#import "MyfavourViewController.h"
#import "FMDB.h"
#import "CaiDanDetailTableViewCell.h"
#import "DataBaseManger.h"
@interface MyfavourViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong)UITableView *tableview;
@end

@implementation MyfavourViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的收藏";
    [self creataTableView];
    [self laodDataSource];
}

-(void)laodDataSource {
    [self.dataSource addObjectsFromArray:[[DataBaseManger shareManager] readModelsWithRecordType:@"story"]];
    
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableview reloadData];
    
    NSLog(@".....55555.......%@",[[DataBaseManger shareManager] readModelsWithRecordType:@"story"]);


}
-(void)creataTableView {
    _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64) style:(UITableViewStylePlain)];
    _tableview.delegate = self;
    _tableview.dataSource =self;
    
    [self.view addSubview:_tableview];
    [_tableview registerNib:[UINib nibWithNibName:@"CaiDanDetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"cellID"];

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {



    return [[[DataBaseManger shareManager] readModelsWithRecordType:@"story"] count];

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {


    return 180;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    CaiDanDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    CaidanDetailModel *model = [[DataBaseManger shareManager] readModelsWithRecordType:@"story"][indexPath.row];
    
    [cell config:model];
    
    return cell;


}
//tableView 的编辑
//提交编辑
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"提交编辑");
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //        先删除数据源的某个元素
        [self.dataSource removeObjectAtIndex:indexPath.row];
        CaidanDetailModel *model = [[DataBaseManger shareManager] readModelsWithRecordType:@"story"][indexPath.row];
        
         [[DataBaseManger shareManager] deleteStudent:model];
        
        [self.tableview deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        [self.tableview reloadData];
        
    }else if (editingStyle ==UITableViewCellEditingStyleInsert)
    {
        
    }
    
}
//编辑的风格
//UITableViewCellEditingStyleNone, 没有风格
//UITableViewCellEditingStyleDelete,
//UITableViewCellEditingStyleInsert
//设置编辑类型
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return UITableViewCellEditingStyleDelete;
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
