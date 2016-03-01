//
//  CaidanfenleiViewController.m
//  TXYMEISHIzaizheli
//
//  Created by qianfeng1 on 16/2/26.
//  Copyright © 2016年 陶星宇. All rights reserved.
//

#import "CaidanfenleiViewController.h"
#import "CaipuidaquanModel.h"
#import "AFNetworking.h"
#import "CaipufenleiTableViewCell.h"
#import "XifenleiCollectionViewCell.h"
#import "CaidanDetailViewController.h"
@interface CaidanfenleiViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *dataSource;
@property (nonatomic, strong)UICollectionView *collectionview;
@property (nonatomic, strong)NSMutableArray *CollectionDataSource;
@property (nonatomic )NSInteger im;
@end

@implementation CaidanfenleiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1.0];
    [self createTableview];
    [self createcollectionView];
    [self loadDataSource];
    
}
/**
 *  添加数据源
 */
-(void)loadDataSource {
    
  
    
    
//    NSMutableArray *resultArray = [NSMutableArray new];
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"Property List.plist" ofType:nil];
    NSArray *caipufenlei = [NSArray arrayWithContentsOfFile:filePath];
   
//    NSLog(@"%@",caipufenlei);
    NSError *error =nil;
//    for (NSDictionary *dict in caipufenlei) {
//        [self.dataSource addObject: dict[@"t"]];
//        XifenleiModel *model = dict[@"d"];
//        
//    }
    self.dataSource = [CaipuidaquanModel arrayOfModelsFromDictionaries:caipufenlei error:&error ];
     CaipuidaquanModel *model = _dataSource[0];
    _im = 2;
    _CollectionDataSource =(NSMutableArray*) model.d;
    
    NSLog(@"%@",self.dataSource);

}


/**
 *  创建tableView
 */
-(void)createTableview {

    _tableView  = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 100, self.view.frame.size.height)];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [_tableView registerNib:[UINib nibWithNibName:@"CaipufenleiTableViewCell" bundle:nil] forCellReuseIdentifier:@"cellID"];

}
/**
 *  创建collectionView
 */
-(void)createcollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(self.view.frame.size.width-150, self.view.frame.size.height);
//    行间距
    layout.minimumInteritemSpacing = 0;
//    滚动方向 垂直方向
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    _collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(120, 64, self.view.frame.size.width-140, self.view.frame.size.height-113) collectionViewLayout:layout];
    _collectionview.showsVerticalScrollIndicator = NO;

    _collectionview.backgroundColor = [UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1.0];
    [self.view addSubview:_collectionview];
    _collectionview.delegate = self;
    _collectionview.dataSource = self;
//    [_collectionview registerNib:[UINib nibWithNibName:@"XifenleiCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cellID2"];
    [_collectionview registerClass:[XifenleiCollectionViewCell class] forCellWithReuseIdentifier:@"cellID2"];
    
 }

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {


    return self.dataSource.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    CaipufenleiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    
    CaipuidaquanModel *model = self.dataSource[indexPath.row];
    cell.titleLabel.text = model.t;
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"ms_fenlei_%ld",indexPath.row]];
    return cell;

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 86;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    CaipuidaquanModel *model = self.dataSource[indexPath.row];
    _im = model.im;
    _CollectionDataSource =(NSMutableArray*) model.d;
    
//    NSLog(@"%@",_CollectionDataSource);
    [self createcollectionView];
    
    [self.collectionview reloadData];

}

#pragma make - UICollectionViewDataSource,UICollectionViewDelegate

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;

}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.CollectionDataSource.count;
    
}
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    XifenleiCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellID2" forIndexPath:indexPath];
    
    XifenleiModel *model = self.CollectionDataSource[indexPath.row];
    
    NSLog(@"%@",model);
    [cell config:model];
    
    return cell;

}
/**
 *  设置Item的大小
 */
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

    return CGSizeMake(80, 110);

}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    XifenleiModel *model = self.CollectionDataSource[indexPath.row];
//    NSString *URL = @"";
//    if (_im ==2) {
//        URL = [NSString stringWithFormat:@"http://api.meishi.cc/v5/search_category.php?format=json&page=%d&q=%@",1,model.t];
//      URL = [self con:model.t andnum:1];
//    }
    NSLog(@"%@",model.t);
   
    CaidanDetailViewController *vc = [[CaidanDetailViewController alloc]init];
    
//    vc.url = URL;
    vc.Title = model.t;
    vc.im = _im;
    vc.d = model.d;
    vc.i = model.i;
    vc.hidesBottomBarWhenPushed = YES;

    [self.navigationController pushViewController:vc animated:YES];
    
    

}
/**
 *  实用分类
 *
 * 
**/
-(NSString*)con:(NSString*)title andnum:(NSInteger)page addim:(NSInteger)im addd:(NSString*)d{
    NSString *url = [NSString new];
    
    NSString *vk = [NSString new];

    
    NSString *ss = [title stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    if (im ==2 || im == 5 ||im == 4) {
        
        NSLog(@"%@",ss);
        url = [NSString stringWithFormat:@"http://api.meishi.cc/v5/search_category.php?format=json&page=%ld&q=%@",page,ss];
        

    }
    if (im ==7) {
        
        url = [NSString stringWithFormat:@"http://api.meishi.cc/v5/search_category.php?format=json&step=&kw=&page=%ld&q=%@&scene=%@&sort=default&gy=&sort_sc=desc&mt=",page,d,d];
        
        
    }
    if ( im == 17) {
        
        url = [NSString stringWithFormat:@"http://api.meishi.cc/v5/search_category.php?format=json&step=&kw=&page=%ld&q=%@&tools=%@&sort=default&gy=&sort_sc=desc&mt=",page,d,d];
        
        
    }
    if ( im == 8) {
        
        url = [NSString stringWithFormat:@"http://api.meishi.cc/v5/search_category.php?format=json&step=&kw=%@&page=%ld&q=%@&sort_sc=desc&sort=default&gy=&mt=",ss,page,ss];
        
        
    }
    if ( im == 16) {
        
        url = [NSString stringWithFormat:@"http://api.meishi.cc/v5/search_category.php?format=json&step=&kw=&page=%ld&q=%@&sort_sc=desc&sort=default&gy=&mt=%@",page,ss,ss];
        
        
    }
    if ( im == 15) {
        
        url = [NSString stringWithFormat:@"http://api.meishi.cc/v5/search_category.php?format=json&step=&kw=&page=%ld&q=%@&sort_sc=desc&sort=default&gy=%@&mt=",page,ss,ss];
        
        
    }
    if (im == 1) {
        
        if ([title  isEqualToString: @"早餐"]) {
            title = @"zao";
        }else if ([title  isEqualToString: @"午餐"]) {
            title = @"zhong";
        }else if ([title  isEqualToString: @"下午茶"]) {
            title = @"xiawucha";
        }else if ([title  isEqualToString: @"晚餐"]) {
            title = @"wan";
        }else if ([title  isEqualToString: @"夜宵"]) {
            title = @"yexiao";
        }
       url = [NSString stringWithFormat:@"http://api.meishi.cc/v5/tj_3can1.php?format=json&t=%@&page=%ld",title,page];
        NSLog(@"%@",url);
    }
    if (im == 0) {

         if ([title isEqualToString:@"热菜"])
        {
            vk = @"9edc9b0613beba0e42c200db1458480a";
        }else if ([title isEqualToString:@"凉菜"])
        {
            vk = @"0d8580742aa86fba04ddeddad16eed2e";
        }else if ([title isEqualToString:@"素菜"])
        {
            vk = @"95ab5dbe2f7ff28f1e9612ed4542f721";
        }else if ([title isEqualToString:@"靓汤"])
        {
            vk = @"310429177d617101d52d638e3cc276fd";
        }else if ([title isEqualToString:@"粥品"])
        {
            vk = @"aab983629af5e6afce7f823a62d1b441";
        }else if ([title isEqualToString:@"主食"])
        {
            vk = @"7aa8a1e6050377aa5e213a2109f335d3";
        }else if ([title isEqualToString:@"点心"])
        {
            vk = @"1c3f5a2ba47e2aabef55232c64084410";
        }else if ([title isEqualToString:@"卤味"])
        {
            vk = @"51f6f6bcb79007489cb3f500c5c47191";
        }else if ([title isEqualToString:@"微波炉"])
        {
            vk = @"b02950d67af38b826c532039961c3de2";
        }else if ([title isEqualToString:@"海鲜"])
        {
            vk = @"627a56bc1e612cf59010bdb949f5126b";
        }else if ([title isEqualToString:@"火锅"])
        {
            vk = @"5b11fc0be17cac47d78076e142c957cf";
        }else if ([title isEqualToString:@"酱料蘸料"])
        {
            vk = @"01c9665c6f86469546366f55f15bbf47";
        }else if ([title isEqualToString:@"干果零食"])
        {
            vk = @"90b8a1a31dde1b0cd207c672f0239e9f";
        }else if ([title isEqualToString:@"饮品"])
        {
            vk = @"09f24af52c773307e958c81aa3f2288e";
        }else if ([title isEqualToString:@"孕妇"])
        {
            vk = @"b381387116eba61df2dba99ddaf5cbc8";
        }else if ([title isEqualToString:@"产妇"])
        {
            vk = @"58b71443d8a2ab5bf3f35e8f960517a7";
        }else if ([title isEqualToString:@"宝宝"])
        {
            vk = @"cf39bc00ae5c45b8d5c853764e97da62";
        }else if ([title isEqualToString:@"老人"])
        {
            vk = @"114828f21a3ff8e52e0ee4b96cb74130";
        }else if ([title isEqualToString:@"美容"])
        {
            vk = @"6c55ad49eb744d2adc3060a58cc79cb9";
        }else if ([title isEqualToString:@"瘦身"]) {
            vk = @"c52c72b14c5e894fab0140a77b09555f";
        }
        url =[NSString stringWithFormat:@"http://api.meishi.cc/v5/class_list1.php?format=json&cid=%@&step=&kw=&page=%ld&sort_sc=desc&sort=default&bcid=13&gy=&mt=&vk=%@",ss,page,vk];
    }
    
    if (im == 3) {
        
        if ([title isEqualToString:@"蛋糕面包"])
        {
            vk = @"32eb0613a9aac4fae92760628bf2b171";
        }else if ([title isEqualToString:@"饼干配方"])
        {
            vk = @"c5e14d0b285828cd4b59a50e0b566870";
        }else if ([title isEqualToString:@"甜品点心"])
        {
            vk = @"fbf6f56ec592afe3313161737f461dfe";
        }else if ([title isEqualToString:@"烘焙工具"])
        {
            vk = @"32fc1673e673ca316026dc0f890c731c";
        }else if ([title isEqualToString:@"烘焙常识"])
        {
            vk = @"dd6ce318253ba59e0f6d09112121ca92";
        }else if ([title isEqualToString:@"烘焙原料"])
        {
            vk = @"6ff85aa8e3adc1a5f404a7f1e86a02ac";
        }
        
        
        url =[NSString stringWithFormat:@"http://api.meishi.cc/v5/class_list1.php?format=json&cid=%@&step=&kw=&page=%ld&sort_sc=desc&sort=default&bcid=13&gy=&mt=&vk=%@",ss,page,vk];
    }

    
//    人群
    if (im == 6) {
        
        if ([title isEqualToString:@"孕妇"])
        {
            vk = @"2b86c20f8c7fb9ba4704d9042d72b233";
        }else if ([title isEqualToString:@"产妇"])
        {
            vk = @"28ab229232600af0eb7c20abf6b9d0aa";
        }else if ([title isEqualToString:@"幼儿"])
        {
            vk = @"0b66d485afb7bdd57ebd182da1686762";
        }else if ([title isEqualToString:@"哺乳期"])
        {
            vk = @"1d51e60e90d51a2866bef9447b2ceb1b";
        }else if ([title isEqualToString:@"婴儿"])
        {
            vk = @"ce0871f53ae6af402e752bad0407f670";
        }else if ([title isEqualToString:@"老人"])
        {
            vk = @"4182ae84029ef0e6cd03c65d6cf125c3";
        }else if ([title isEqualToString:@"青少年"])
        {
            vk = @"cd57e5914b240f22a294bc9df8be5aef";
        }else if ([title isEqualToString:@"运动员"])
        {
            vk = @"a4e4ced9f9fd5c71baf1e41087b79212";
        }else if ([title isEqualToString:@"围孕期"])
        {
            vk = @"89ff35be80c954ef8608436fc942cee8";
        }else if ([title isEqualToString:@"学龄前儿童"])
        {
            vk = @"d6982c8978cbedc7054a4b8d900d8bac";
        }else if ([title isEqualToString:@"学龄期儿童"])
        {
            vk = @"b505f6dd9dd34a7270db9c98cf267cc9";
        }else if ([title isEqualToString:@"高温环境作业人群"])
        {
            vk = @"7a4bb6c785728ef4d781c66bb4ab2502";
        }else if ([title isEqualToString:@"低温环境作业人群"])
        {
            vk = @"1c0673b0ae11ca070f073f4c36fd8a79";
        }else if ([title isEqualToString:@"接触电离辐射人员"])
        {
            vk = @"b35adf48abc07e60b4f5b32dbc68c83e";
        }else if ([title isEqualToString:@"接触化学毒素人员"])
        {
            vk = @"067855b00dce8afc82268ea41e182cc1";
        }
        url =[NSString stringWithFormat:@"http://api.meishi.cc/v5/shiliao_list1.php?format=json&cid=%@&step=&kw=&page=%ld&sort_sc=desc&sort=default&gy=&mt=&st=3&vk=%@",d,page,vk];
    }

    if (im ==9) {
        if ([title isEqualToString:@"川菜"])
        {
            vk = @"af85a0e2d350f77c4ce7ea5f5bb59730";
        }else if ([title isEqualToString:@"鲁菜"])
        {
            vk = @"3511abf7bb7f4ddfb8ddc9d769783bbd";
        }else if ([title isEqualToString:@"粤菜"])
        {
            vk = @"b71ec985bdc11b19d2d9e2175bf6be77";
        }else if ([title isEqualToString:@"湘菜"])
        {
            vk = @"898bbae3f0c118c7f56730423dde7641";
        }else if ([title isEqualToString:@"闽菜"])
        {
            vk = @"ca3408992a0081dd6751e34a103a6597";
        }else if ([title isEqualToString:@"浙菜"])
        {
            vk = @"6f7ff0f2532618de64f78b1e3b034aa5";
        }else if ([title isEqualToString:@"苏菜"])
        {
            vk = @"14ee6a3974d95d51bdd55f339f9f4346";
        }else if ([title isEqualToString:@"徽菜"])
        {
            vk = @"b0cf079898bd213aeca12ac0bec5a6f4";
        }else if ([title isEqualToString:@"京菜"])
        {
            vk = @"435c75e042590cd33c3349da9cfcf424";
        }else if ([title isEqualToString:@"沪菜"])
        {
            vk = @"bd828651db86eb8c410efd2e7e623dd3";
        }else if ([title isEqualToString:@"豫菜"])
        {
            vk = @"d5c7497469a2d529345b303666b2dc9b";
        }else if ([title isEqualToString:@"湖北菜"])
        {
            vk = @"2e146cbf47796bb26e9a5a43b5b7fc73";
        }else if ([title isEqualToString:@"东北菜"])
        {
            vk = @"05c908279b48397ac33e55e0fabb3c5c";
        }else if ([title isEqualToString:@"西北菜"])
        {
            vk = @"5920e67a3beca267510c2f985d299867";
        }else if ([title isEqualToString:@"云贵菜"])
        {
            vk = @"84d225c8bd1291cac60e956534034cca";
        }else if ([title isEqualToString:@"清真菜"])
        {
            vk = @"9664562bf42b298eae5512a20005003f";
        }else if ([title isEqualToString:@"山西菜"])
        {
            vk = @"1ceea9e17a7efa85ba82b5a251a2ce2f";
        }else if ([title isEqualToString:@"江西菜"])
        {
            vk = @"df84cf4f2d91905409c88653bef743b3";
        }else if ([title isEqualToString:@"广西菜"])
        {
            vk = @"8aa7fd1120ee31ac98097985cce20ae9";
        }else if ([title isEqualToString:@"港台菜"])
        {
            vk = @"a09da36968291449929f0c909e99058c";
        }else if ([title isEqualToString:@"其他菜"])
        {
            vk = @"d29c480635eea823c0a2eff98db16e59";
        }
        url =[NSString stringWithFormat:@"http://api.meishi.cc/v5/class_list1.php?format=json&cid=%@&page=%ld&sort_sc=desc&sort=default&bcid=2&gy=&mt=&vk=%@",ss,page,vk];

    }
    if(im == 10)
    {
        
        if ([title isEqualToString:@"北京小吃"])
        {
            vk = @"e0a84be9d8293508de079300f926a9ff";
        }else if ([title isEqualToString:@"天津小吃"])
        {
            vk = @"51e05c8d8f0341a371d8c12f35197b0a";
        }else if ([title isEqualToString:@"河北小吃"])
        {
            vk = @"fb64fcc467588e757288772f97568cf2";
        }else if ([title isEqualToString:@"山西小吃"])
        {
            vk = @"9b9d70430a134d56092ae2e9641d1e1f";
        }else if ([title isEqualToString:@"蒙古小吃"])
        {
            vk = @"bb37a801b3e0cba4045a13c9c74c48f4";
        }else if ([title isEqualToString:@"上海小吃"])
        {
            vk = @"ed0954cca17dbf12898dc9a7d2117e7e";
        }else if ([title isEqualToString:@"山东小吃"])
        {
            vk = @"623077ff2822b611616c738471b1bf21";
        }else if ([title isEqualToString:@"江苏小吃"])
        {
            vk = @"9f5ce7840dea9bf2a172e52f86f9cfc9";
        }else if ([title isEqualToString:@"浙江小吃"])
        {
            vk = @"b2bd7c498c48ce90218d33628c8afb22";
        }else if ([title isEqualToString:@"安徽小吃"])
        {
            vk = @"14a11f5dcd2d5c4cbe55b95ee3911852";
        }else if ([title isEqualToString:@"吉林小吃"])
        {
            vk = @"aa13e19f579365587bd32142c27253ca";
        }else if ([title isEqualToString:@"辽宁小吃"])
        {
            vk = @"9f3baeb6ddd6ef8778d241cc483ea0b5";
        }else if ([title isEqualToString:@"陕西小吃"])
        {
            vk = @"a452e8e8f468e8f9bdb17e18abf0a4b0";
        }else if ([title isEqualToString:@"新疆小吃"])
        {
            vk = @"2d0601e1ac91da56f4b74e01f99c8c46";
        }else if ([title isEqualToString:@"宁夏小吃"])
        {
            vk = @"32a39ace157168f73d9d5de57872ef4e";
        }else if ([title isEqualToString:@"甘肃小吃"])
        {
            vk = @"51f6e945ac6055cd362e649792cc83ed";
        }else if ([title isEqualToString:@"青海小吃"])
        {
            vk = @"0e87a0803f9b5b5a98c26aac26bfb6ac";
        }else if ([title isEqualToString:@"湖北小吃"])
        {
            vk = @"dd2bda192b7aff718ba3433786b7cf1f";
        }else if ([title isEqualToString:@"湖南小吃"])
        {
            vk = @"69ef1b0ebb2c20cdc37b1777a88d0dd3";
        }else if ([title isEqualToString:@"河南小吃"]) {
            vk = @"0ee75e8efcbf30eb3d7882a2a256dca6";
        }else if ([title isEqualToString:@"江西小吃"]) {
            vk = @"53da6a4e3e34b77a3b5784f36729c9a9";
        }else if ([title isEqualToString:@"重庆小吃"]) {
            vk = @"b4cf055e9eb8002154bae0168d5e5b2b";
        }else if ([title isEqualToString:@"四川小吃"]) {
            vk = @"eb10f0df141a88c5548c1d4925ce2723";
        }else if ([title isEqualToString:@"云南小吃"]) {
            vk = @"7ddc589f47c423e65897efc140d3677e";
        }else if ([title isEqualToString:@"贵州小吃"]) {
            vk = @"5b665ac7a9332f5dafaf68a926ea98ec";
        }else if ([title isEqualToString:@"西藏小吃"]) {
            vk = @"730ffce30a1a310a685dfffe2836092e";
        }else if ([title isEqualToString:@"广东小吃"]) {
            vk = @"10528b3bba45ae1e6f96cc83c13c1f52";
        }else if ([title isEqualToString:@"福建小吃"]) {
            vk = @"edb0ed1521d3f06a8f1b124331124baa";
        }else if ([title isEqualToString:@"广西小吃"]) {
            vk = @"6d52cae7c15a7e45fecc1ef03531b5dc";
        }else if ([title isEqualToString:@"海南小吃"]) {
            vk = @"99e1084c1f4feba825ab0957f746b552";
        }else if ([title isEqualToString:@"香港小吃"]) {
            vk = @"03ec44b545d826f98cf69017470d3a7f";
        }else if ([title isEqualToString:@"台湾小吃"]) {
            vk = @"105b00cf552aa7c21cd2c01c92755d72";
        }else if ([title isEqualToString:@"成都小吃"]) {
            vk = @"01cd3827777851c73e6cf450141e2a79";
        }else if ([title isEqualToString:@"黑龙江小吃"]) {
            vk = @"a372983aad37dd92c8902f651be36559";
        }
        url =[NSString stringWithFormat:@"http://api.meishi.cc/v5/class_list1.php?format=json&cid=%@&step=&kw=&page=%ld&sort_sc=desc&sort=default&bcid=3&gy=&mt=&vk=%@",ss,page,vk];
    }
    if (im ==11) {
        if ([title isEqualToString:@"日本料理"])
        {
            vk = @"fba8d823d5902760cc92b0be4d835dc2";
        }else if ([title isEqualToString:@"韩国料理"])
        {
            vk = @"ac80285f07d4c93e60f5b37e5acbf1d1";
        }else if ([title isEqualToString:@"美国家常菜"])
        {
            vk = @"547b1841fa63567c29532b594da2fa74";
        }else if ([title isEqualToString:@"意大利餐"])
        {
            vk = @"b4ebed1409f6adbea53443d41ed813e6";
        }else if ([title isEqualToString:@"法国菜"])
        {
            vk = @"e7ed476716beea79ea424d18af1b00e6";
        }else if ([title isEqualToString:@"墨西哥菜"])
        {
            vk = @"152f63cb40a679d572afbf757fc19d78";
        }else if ([title isEqualToString:@"澳大利亚菜"])
        {
            vk = @"d79c0141ff96f7fa5b98e55bfdcd8d9c";
        }else if ([title isEqualToString:@"东南亚菜"])
        {
            vk = @"28b5935c7d9b9612a929ce5003ab4450";
        }else if ([title isEqualToString:@"西餐面点"])
        {
            vk = @"7ed2219e48639e0e85bc2468668770fe";
        }else if ([title isEqualToString:@"餐前小吃"])
        {
            vk = @"3c39debd85f50ab8ab9086a4f31a5a92";
        }else if ([title isEqualToString:@"汤品"])
        {
            vk = @"6ffe4dc9741cfd377b92cc26c4f2a607";
        }else if ([title isEqualToString:@"主菜"])
        {
            vk = @"a68d4186ad9352349d93c745c71caa09";
        }else if ([title isEqualToString:@"主食"])
        {
            vk = @"7aa8a1e6050377aa5e213a2109f335d3";
        }else if ([title isEqualToString:@"甜点"])
        {
            vk = @"89202768a2c7f9c6198996ce7a1ec200";
        }else if ([title isEqualToString:@"饮品"])
        {
            vk = @"09f24af52c773307e958c81aa3f2288e";
        }else if ([title isEqualToString:@"其他国家"])
        {
            vk = @"ca29b636bbf8fddbd4775a7ed6b3876a";
        }
        
        url =[NSString stringWithFormat:@"http://api.meishi.cc/v5/class_list1.php?format=json&cid=%@&step=&kw=&page=%ld&sort_sc=desc&sort=default&bcid=10&gy=&mt=&vk=%@",ss,page,vk];
        
    }
    if (im ==12)
    {
        if ([title isEqualToString:@"中风"])
        {
            vk = @"0aa894c7a72e8ffea5acffa3b5b6ebda";
        }else if ([title isEqualToString:@"肠炎"])
        {
            vk = @"fa2da4b944c9d991c4501284356265fe";
        }else if ([title isEqualToString:@"肾炎"])
        {
            vk = @"44a23a6fb2709bd379b4dea7954b8f1d";
        }else if ([title isEqualToString:@"痛风"])
        {
            vk = @"6de5b722fbeb4e453f5fa8a98cbc43f2";
        }else if ([title isEqualToString:@"麻疹"])
        {
            vk = @"825971c8dcee6ce288f884c9b81b6a80";
        }else if ([title isEqualToString:@"肝炎"])
        {
            vk = @"a688f7d1bdf44fa4546128cd3336d9c0";
        }else if ([title isEqualToString:@"胃炎"])
        {
            vk = @"11e1f86008737ec288c702bb53050e34";
        }else if ([title isEqualToString:@"贫血"])
        {
            vk = @"3650cfced45ed09d960c69a25f88f2e5";
        }else if ([title isEqualToString:@"痔疮"])
        {
            vk = @"c4377580f965e9043ce556b8583013da";
        }else if ([title isEqualToString:@"痛经"])
        {
            vk = @"5da6e9452d0138567d9a399e2e9f3b21";
        }else if ([title isEqualToString:@"咽炎"])
        {
            vk = @"9d385599a9deaf407cd21a5010cfa987";
        }else if ([title isEqualToString:@"耳鸣"])
        {
            vk = @"19daedeb024a6ccfab6852c535be48cd";
        }else if ([title isEqualToString:@"术后"])
        {
            vk = @"5b90bb6308ed4eec3221e92ad97f93de";
        }else if ([title isEqualToString:@"前列腺"])
        {
            vk = @"5275b02b76bd79c92fdf669c1498c743";
        }else if ([title isEqualToString:@"糖尿病"])
        {
            vk = @"76ccc2af8bbb8a124de2ef268ebaa656";
        }else if ([title isEqualToString:@"高血压"])
        {
            vk = @"260b031e371756b59a4c403685525138";
        }else if ([title isEqualToString:@"高血脂"])
        {
            vk = @"65c13611f18ae6e8b892fbf1d11c4223";
        }else if ([title isEqualToString:@"冠心病"])
        {
            vk = @"ff629ae4484f7ae07d026d6633ddee4d";
        }else if ([title isEqualToString:@"胆石症"])
        {
            vk = @"2789d1840c38bb65a7b8de3a3eb51d04";
        }else if ([title isEqualToString:@"肝硬化"])
        {
            vk = @"0363ebdc37deecd84987b4959b04bc53";
        }else if ([title isEqualToString:@"结核病"])
        {
            vk = @"c93e360a7c9dcd16ab1b33f34402e2a1";
        }else if ([title isEqualToString:@"甲状腺"])
        {
            vk = @"d6ef4bb0538853b3432182fc887f0ee5";
        }else if ([title isEqualToString:@"更年期"])
        {
            vk = @"2db2ff85b1b0fb70c3d1081dfc751d1d";
        }else if ([title isEqualToString:@"关节炎"])
        {
            vk = @"e18fd18b06a1a90f04d02fdcbecc98fa";
        }else if ([title isEqualToString:@"肺气肿"])
        {
            vk = @"6b5c485e69c8e5d78b08c8642251692b";
        }else if ([title isEqualToString:@"防癌抗癌"])
        {
            vk = @"865149933d2ce4e15f148b4607406272";
        }else if ([title isEqualToString:@"动脉硬化"])
        {
            vk = @"12e8353c44c8e14eb32a8bf016251aec";
        }else if ([title isEqualToString:@"月经不调"])
        {
            vk = @"74200d408aaaef0e7b2693c80ce13e0d";
        }else if ([title isEqualToString:@"子宫脱垂"])
        {
            vk = @"192df4642f3d73d86cbddf71041a2037";
        }else if ([title isEqualToString:@"小儿遗尿"])
        {
            vk = @"d844e7f31f7c09c2217e951f5bc6d20c";
        }else if ([title isEqualToString:@"营养不良"])
        {
            vk = @"73092efe6ec0627f692d0cd383e818ab";
        }else if ([title isEqualToString:@"骨质酥松"])
        {
            vk = @"7a751a67a69e73b4278b1b459692f6f6";
        }else if ([title isEqualToString:@"口腔溃疡"])
        {
            vk = @"764aeca70bfefad878f1700a538add9b";
        }
        else if ([title isEqualToString:@"尿路结石"])
        {
            vk = @"b3204b3a92771129c3f222a9091a135f";
        }
        else if ([title isEqualToString:@"支气管炎"])
        {
            vk = @"6edddcec1720411ece3e60e04a35dd25";
        }
        else if ([title isEqualToString:@"消化性溃疡"])
        {
            vk = @"7c2aa046f011b824f8a1b87ef31138b7";
        }
        else if ([title isEqualToString:@"跌打骨折损伤"])
        {
            vk = @"663bf886e865f198a30bce53ee1e3c7a";
        }
        url =[NSString stringWithFormat:@"http://api.meishi.cc/v5/shiliao_list1.php?format=json&cid=%@&step=&kw=&page=%ld&sort_sc=desc&sort=default&gy=&mt=&st=3&vk=%@",d,page,vk];
        
        
    }
    
    
    
    if (im ==13)
    {
        if ([title isEqualToString:@"补心"])
        {
            vk = @"fa1574e74181ead9e024412463a19c72";
        }else if ([title isEqualToString:@"养肝"])
        {
            vk = @"82253d5ac03ac679380e5ab5def187cc";
        }else if ([title isEqualToString:@"补脾"])
        {
            vk = @"100f099ef56e0cd4165c24acfc4360d3";
        }else if ([title isEqualToString:@"养肺"])
        {
            vk = @"c4a9fe16780bb1cafe2197cbf45f200b";
        }else if ([title isEqualToString:@"补肾"])
        {
            vk = @"ddc278e67abd286da3dea99a9316ea27";
        }else if ([title isEqualToString:@"补气"])
        {
            vk = @"bfd03a2603b1061c6164bef65e15abfe";
        }else if ([title isEqualToString:@"补血"])
        {
            vk = @"4d2e82dd447482f7348c283a92cd2b07";
        }else if ([title isEqualToString:@"哮喘"])
        {
            vk = @"97ecc105eab71be1955e09ad2a48bbfe";
        }else if ([title isEqualToString:@"感冒"])
        {
            vk = @"fcf21671f1c6b07fb96fa6ef0823cc78";
        }else if ([title isEqualToString:@"腹泻"])
        {
            vk = @"b1c671dc945148424b510f00a071055b";
        }else if ([title isEqualToString:@"癫痫"])
        {
            vk = @"1bb5f09094e6061269730a4cc9f7778a";
        }else if ([title isEqualToString:@"水肿"])
        {
            vk = @"8f814d5254e88e066f0d0989290828b4";
        }else if ([title isEqualToString:@"便秘"])
        {
            vk = @"86a35a8252f1f697654ab43f6820676f";
        }else if ([title isEqualToString:@"失眠"])
        {
            vk = @"bca688f559428c42124472e62791ac59";
        }else if ([title isEqualToString:@"健忘"])
        {
            vk = @"0bc5ef38769d082a7a5cd88b791fcbcf";
        }else if ([title isEqualToString:@"利尿"])
        {
            vk = @"ac150679565c17b9603e4b055e732af7";
        }else if ([title isEqualToString:@"心悸"])
        {
            vk = @"cf602560d4226edcf21822a4c5b22b80";
        }else if ([title isEqualToString:@"痢疾"])
        {
            vk = @"e474e87ac3b0370ffd26a0c4159c450b";
        }else if ([title isEqualToString:@"呕吐"])
        {
            vk = @"ba235f55469024a136be1c5398175679";
        }else if ([title isEqualToString:@"胃调养"])
        {
            vk = @"f7edf7543f867e43bfda7b12e890b05f";
        }else if ([title isEqualToString:@"咳喘"])
        {
            vk = @"caefab2b323f68aab7588da1c4426781";
        }else if ([title isEqualToString:@"气血双补"])
        {
            vk = @"c31beb72a97f0e7b22761854391868ed";
        }else if ([title isEqualToString:@"活血化瘀"])
        {
            vk = @"730e92c0e0a9f1f4bd13de8eb2d61c79";
        }else if ([title isEqualToString:@"止血调理"])
        {
            vk = @"5b92b10ff00c494144bca6d0cf332040";
        }else if ([title isEqualToString:@"疏肝理气"])
        {
            vk = @"872d6a509c93d18a440d5bf1688ae431";
        }else if ([title isEqualToString:@"阳痿早泄"])
        {
            vk = @"13cb47bf59c5d45ff852eb2f7e37b12b";
        }else if ([title isEqualToString:@"自汗盗汗"])
        {
            vk = @"5d5926611f51244696838360b749cdd7";
        }
        
        url =[NSString stringWithFormat:@"http://api.meishi.cc/v5/shiliao_list1.php?format=json&cid=%@&step=&kw=&page=%ld&sort_sc=desc&sort=default&gy=&mt=&st=3&vk=%@",d,page,vk];
       
    }
    if (im ==14)
    {
        if ([title isEqualToString:@"美容"])
        {
            vk = @"d7e3c4ba82d32ce9bfec2171e0104f24";
        }else if ([title isEqualToString:@"减肥"])
        {
            vk = @"8081e69de7b1bff1ab759d64a58a29f8";
        }else if ([title isEqualToString:@"乌发"])
        {
            vk = @"689421968be4f4a00006a04e8e10e8ae";
        }else if ([title isEqualToString:@"明目"])
        {
            vk = @"8bdf98337869fe42f2671cc600ab278b";
        }else if ([title isEqualToString:@"防暑"])
        {
            vk = @"a3e8fc03d0ea733ccc8d6a5338f714a3";
        }else if ([title isEqualToString:@"脚气"])
        {
            vk = @"e95aa39f0052c249702812ed16dae12f";
        }else if ([title isEqualToString:@"祛痰"])
        {
            vk = @"34af8f4ea46e9c53d712f00b42feedd0";
        }else if ([title isEqualToString:@"通乳"])
        {
            vk = @"28d92432ff969b5c401bc87c849fd569";
        }else if ([title isEqualToString:@"头疼"])
        {
            vk = @"3560c393443444600577fdf0869f70ca";
        }else if ([title isEqualToString:@"解酒"])
        {
            vk = @"3ab011dc43fb78889d9872b2389bbba5";
        }else if ([title isEqualToString:@"增肥"])
        {
            vk = @"6ff1c7be05613faec06e6be423120161";
        }else if ([title isEqualToString:@"夜尿多"])
        {
            vk = @"dac22405c43033029b987c0728494aff";
        }else if ([title isEqualToString:@"延缓衰老"])
        {
            vk = @"b080b808c15ec9be0e3446ccf6b91169";
        }else if ([title isEqualToString:@"消化不良"])
        {
            vk = @"2ee33525956e9833d22e2d689a11ce72";
        }else if ([title isEqualToString:@"神经衰弱"])
        {
            vk = @"4647f14de9502036653e897c9b56600d";
        }else if ([title isEqualToString:@"补虚养身"])
        {
            vk = @"eb392913f0872ed74e2d413c0d1f3a96";
        }else if ([title isEqualToString:@"补阳壮阳"])
        {
            vk = @"e491a73365757c52da6097942e962e25";
        }else if ([title isEqualToString:@"滋阴补肾"])
        {
            vk = @"e3cdfd815d7500f93d414d41033ede88";
        }else if ([title isEqualToString:@"壮腰健肾"])
        {
            vk = @"63811818a559b3c066301812faa78e98";
        }else if ([title isEqualToString:@"清热解毒"])
        {
            vk = @"51939bccff9fae3d09516e89939b50ce";
        }else if ([title isEqualToString:@"产后调理"])
        {
            vk = @"90bb0b95b9993a7c729044fb486c52fc";
        }else if ([title isEqualToString:@"不孕不育"])
        {
            vk = @"cd4aaf7d44f353705e621395762dbdd7";
        }else if ([title isEqualToString:@"健脾开胃"])
        {
            vk = @"cad5e5341259565f7f882b3459d375b7";
        }else if ([title isEqualToString:@"营养不良"])
        {
            vk = @"03e70259afa7d5e7134ef809d11cf888";
        }else if ([title isEqualToString:@"益智补脑"])
        {
            vk = @"7c19873bf2e6bc59a58a603e660197d9";
        }else if ([title isEqualToString:@"肢寒畏冷"])
        {
            vk = @"50f89745fa83f0b6dc43c27f340181bd";
        }else if ([title isEqualToString:@"清热去火"])
        {
            vk = @"dd247d049a170dd34e787482631f77c2";
        }
        
        
      url =[NSString stringWithFormat:@"http://api.meishi.cc/v5/shiliao_list1.php?format=json&cid=%@&step=&kw=&page=%ld&sort_sc=desc&sort=default&gy=&mt=&st=3&vk=%@",d,page,vk];
        
        
    }

    
    
    NSLog(@"%@",url);
       return url;
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
