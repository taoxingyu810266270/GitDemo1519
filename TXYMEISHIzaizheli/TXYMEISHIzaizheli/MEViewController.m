//
//  MEViewController.m
//  TXYMEISHIzaizheli
//
//  Created by qianfeng1 on 16/3/1.
//  Copyright © 2016年 陶星宇. All rights reserved.
//

#import "MEViewController.h"
#import "RecommendViewController.h"
#import "SDImageCache.h"
#import "MyfavourViewController.h"
@interface MEViewController ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_dataArr;
}

@end

@implementation MEViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self dataInit];
    [self creatTableView];
}


- (void)creatTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64-49) style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
}

- (void)dataInit {
    _dataArr = [[NSMutableArray alloc] init];
    NSArray *arr1 = @[@"推送设置",@"开启夜间模式",@"开启关注通知",@"清除缓存"];
    [_dataArr addObject:arr1];
    NSArray *arr2 = @[@"推荐美食",@"官方推荐",@"官方微博"];
    [_dataArr addObject:arr2];
    
    [_tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_dataArr[section]count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    
    if (indexPath.section == 0) {
        
        if (indexPath.row == 1||indexPath.row == 2 ) {
            UISwitch *sw = [[UISwitch alloc] initWithFrame:CGRectMake(200, 0, 100, 30)];
            [sw addTarget:self action:@selector(swClick:) forControlEvents:UIControlEventValueChanged];
            sw.tag = indexPath.row+1001;
            //粘贴到cell 的contentView上
            [cell.contentView addSubview:sw];
        }
    }
    cell.textLabel.text = _dataArr[indexPath.section][indexPath.row];
    return cell;
}
//开关按钮
- (void)swClick:(UISwitch *)sw {
    if (sw.tag == 1002) {
        if (_tableView.backgroundColor == [UIColor whiteColor]) {
            _tableView.backgroundColor = [UIColor blackColor];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"changeColor" object:[UIColor blackColor]];
            self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
            self.tabBarController.tabBar.barTintColor = [UIColor blackColor];
            
            
        }else {
            [[NSNotificationCenter defaultCenter]postNotificationName:@"changeColor" object:[UIColor orangeColor]];
            self.navigationController.navigationBar.barTintColor = [UIColor orangeColor];
            self.tabBarController.tabBar.barTintColor = [UIColor orangeColor];
            _tableView.backgroundColor = [UIColor whiteColor];
            
        }

    }
    
}

//获取所有缓存大小
- (CGFloat)getCacheSize {
    //缓存 有两类 sdwebimage 还有 每个界面保存的缓存
    CGFloat sdSize = [[SDImageCache sharedImageCache] getSize];
    NSString *myPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches/MyCaches"];
    //获取文件夹中的所有的文件
    NSArray *arr = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:myPath error:nil];
    unsigned long long size = 0;
    for (NSString *fileName in arr) {
        NSString *filePath = [myPath stringByAppendingPathComponent:fileName];
        NSDictionary *dict = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
        size += dict.fileSize;
    }
    //1M = 1024 K = 1024*1024字节
    CGFloat totalSize = (sdSize+size)/1024.0/1024.0;
    return totalSize;
}


//cell 选中
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            MyfavourViewController *vc = [[MyfavourViewController alloc]init];
            
            [self.navigationController pushViewController:vc animated:YES];
        }
        //第0分区
        NSString *sizeStr = [NSString stringWithFormat:@"%fM",[self getCacheSize]];
        if (indexPath.row == 3) {
            UIAlertController *actionsheet = [UIAlertController alertControllerWithTitle:@"清除缓存" message:sizeStr preferredStyle:UIAlertControllerStyleActionSheet];
            [actionsheet addAction:[UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
                //删除按钮
                //1.删除sd
                [[SDImageCache sharedImageCache] clearMemory];//清除内存缓存
                [[SDImageCache sharedImageCache] clearDisk];//磁盘
                //2.界面下载的缓存
                NSString *myPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches/MyCaches"];
                //删除
                [[NSFileManager defaultManager] removeItemAtPath:myPath error:nil];
                
            }]];
            [actionsheet addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                NSLog(@"取消");
            }]];
            [self presentViewController:actionsheet animated:YES completion:nil];
            
        }
        
    }else if (indexPath.section == 1) {
        //1分区
        if (indexPath.row == 0) {
            //推荐
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/ai-xian-mian-re-men-ying-yong/id468587292?mt=8"]];
        }else if (indexPath.row == 1) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/ai-xian-mian-re-men-ying-yong/id468587292?mt=8"]];
        }else {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://weibo.com/candou"]];
        }
        
    }
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
