//
//  RecommendViewController.m
//  TXYMEISHIzaizheli
//
//  Created by qianfeng1 on 16/2/24.
//  Copyright © 2016年 陶星宇. All rights reserved.
//

#import "RecommendViewController.h"
#import "AFNetworking.h"
#import "Define.h"
#import "RecommendModel.h"
#import "UIImageView+WebCache.h"
#import "ZTModel.h"
#import "ZTTableViewCell.h"
#import "CaidanfenleiViewController.h"
#import "VideoViewController.h"
#import "FujinViewController.h"
#import "ShiHuaViewController.h"
@interface RecommendViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)UIScrollView *scroller;
@property (nonatomic, strong)UIPageControl *pageControl;
@property (nonatomic, strong)UIView *BigView;
@property (nonatomic, strong)NSMutableArray *san_candataSource;
@property (nonatomic, strong)NSMutableArray *san_canTitledataSource;
@property (nonatomic, strong)NSMutableArray *fenleidataSource;
@property (nonatomic, strong)NSMutableArray *jinrituijiandataSource;
@end


@implementation RecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _page = 1;
    [self createDataSource];
//    [self createScrollView];
    
}


-(NSString*)iniURL {
    NSString *url = [NSString stringWithFormat:kRecomment,_page];
    NSLog(@"%@",url);
    
    return url;
}
/**
 *  创建数据源
 */
-(void)createDataSource {

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSSet *currentAcceptSet = manager.responseSerializer.acceptableContentTypes;
    NSMutableSet *mset = [NSMutableSet setWithSet:currentAcceptSet];
    [mset addObject:@"text/html"];
    [mset addObject:@"application/json"];
    
    manager.responseSerializer.acceptableContentTypes = mset;
    [manager GET:[self iniURL] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        NSDictionary *obj = responseObject[@"obj"];
                NSArray *san_can = obj[@"san_can"];
                NSArray *san_can_title = obj[@"san_can_titles"];
                NSError *error = nil;
                NSError *error1 = nil;
        NSArray *fenlei = obj[@"fenlei"];
        NSError *error2 = nil;
                self.san_candataSource = [SancanModel arrayOfModelsFromDictionaries:san_can error:&error];
        
        
        self.san_canTitledataSource = [SubTitleModel arrayOfModelsFromDictionaries:san_can_title error:&error1];
        
        self.fenleidataSource = [FenleiModel arrayOfModelsFromDictionaries:fenlei error:&error2];
        NSArray *ZT = obj[@"zt"];

        self.jinrituijiandataSource = [ZTModel arrayOfModelsFromDictionaries:ZT error:&error];
        
                [self createScrollView];
           [self.tableView reloadData];
//                NSLog(@"%@",self.san_candataSource);
        NSLog(@"%@",self.san_canTitledataSource);

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];

    

}

/**
 *  创建scrollView
 */
-(void)createScrollView {
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-113) style:(UITableViewStyleGrouped)];
    _tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    _BigView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 600 +self.view.frame.size.width/4 +30)];
    _scroller = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 550)];
    _scroller.delegate = self;
    _scroller.pagingEnabled = YES;
    _scroller.backgroundColor = [UIColor whiteColor];
    _scroller.contentSize = CGSizeMake(self.view.frame.size.width*5, 550);
    
    int w= 0;
    for (int i = 0 ; i<5; i++) {
        SubTitleModel *subModel = self.san_canTitledataSource[i];
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(i*self.view.frame.size.width, 0,self.view.frame.size.width, 600)];
        for (int j = 0 ; j<3; j++) {
            SancanModel *model = self.san_candataSource[w];
            
            UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(10, j*150+2, self.view.frame.size.width-20, 150)];
            imageview.userInteractionEnabled = YES;
            
            imageview.tag = 100+w;
            
            imageview.backgroundColor = [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1.0];
            
            NSString *image = model.titlepic;
            NSLog(@"%@",image);
            [imageview sd_setImageWithURL:[NSURL URLWithString:image]];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
            tap.numberOfTapsRequired = 1;
            tap.numberOfTouchesRequired = 1;

            [imageview addGestureRecognizer:tap];
            
            
            UILabel *iamgetitle =[[UILabel alloc]initWithFrame:CGRectMake(10, 80, view.frame.size.width-20, 30)];
            iamgetitle.text =model.title;
            iamgetitle.textColor = [UIColor blackColor];
            iamgetitle.font = [UIFont systemFontOfSize:20];
            
            UILabel *iamgedescr =[[UILabel alloc]initWithFrame:CGRectMake(10, 110, view.frame.size.width-20, 20)];
            
            iamgedescr.text =model.descr;
            iamgedescr.textColor = [UIColor blackColor];
            iamgedescr.font = [UIFont systemFontOfSize:12];

            [imageview addSubview:iamgetitle];
            [imageview addSubview:iamgedescr];
            [view addSubview:imageview];
            w++;
        }
        UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(i*self.view.frame.size.width, 450, self.view.frame.size.width, 50)];
        title.font = [UIFont systemFontOfSize:30];
        title.text =subModel.title;

        title.textAlignment = NSTextAlignmentCenter;
        
        UILabel *detail = [[UILabel alloc]initWithFrame:CGRectMake(i*self.view.frame.size.width, 500, self.view.frame.size.width, 50)];
        detail.font = [UIFont systemFontOfSize:17];
        detail.text = subModel.sub_title;
        detail.textAlignment = NSTextAlignmentCenter;
        detail.numberOfLines = 0;
        [_scroller addSubview:title];
        [_scroller addSubview:detail];

        
        [_scroller addSubview:view];
    }
    
    
    
    
    [_BigView addSubview:_scroller];
    
    self.tableView.tableHeaderView = _BigView;

//    [_tableView registerNib:[UINib nibWithNibName:@"" bundle:nil] forCellReuseIdentifier:@"cellID"];
    
    [self createpageControl];
    UIImageView *bigView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 600, self.view.frame.size.width, self.view.frame.size.width/4 + 30)];
    bigView.backgroundColor = [UIColor whiteColor];
    
    FenleiModel *fenleimodel1 = self.fenleidataSource[0];
    UIImageView *candanfenleiimage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width/4, self.view.frame.size.width/4)];
    candanfenleiimage.tag = 151;
    candanfenleiimage.userInteractionEnabled = YES;

    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    tap1.numberOfTapsRequired = 1;
    tap1.numberOfTouchesRequired = 1;
    
    [candanfenleiimage addGestureRecognizer:tap1];
    
    
    UILabel *caidanfenlei = [[UILabel alloc]initWithFrame:CGRectMake(0, self.view.frame.size.width/4, self.view.frame.size.width/4, 30)];
    caidanfenlei.text = fenleimodel1.title;
    caidanfenlei.textAlignment = NSTextAlignmentCenter;

    FenleiModel *fenleimodel2 = self.fenleidataSource[1];

     UIImageView *shipincaipuimage = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/4, 0, self.view.frame.size.width/4, self.view.frame.size.width/4)];
    shipincaipuimage.tag = 152;
    shipincaipuimage.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    tap2.numberOfTapsRequired = 1;
    tap2.numberOfTouchesRequired = 1;
    
    [shipincaipuimage addGestureRecognizer:tap2];
    
    
    shipincaipuimage.userInteractionEnabled = YES;
    UILabel *shipincaipu = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/4, self.view.frame.size.width/4, self.view.frame.size.width/4, 30)];
    shipincaipu.text = fenleimodel2.title;
    shipincaipu.textAlignment = NSTextAlignmentCenter;

    
    FenleiModel *fenleimodel3 = self.fenleidataSource[2];

     UIImageView *zaocanimage = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/4*2, 0, self.view.frame.size.width/4, self.view.frame.size.width/4)];
    zaocanimage.tag = 153;
    zaocanimage.userInteractionEnabled = YES;

    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    tap3.numberOfTapsRequired = 1;
    tap3.numberOfTouchesRequired = 1;
    
    [zaocanimage addGestureRecognizer:tap3];
    
    
    
    
    UILabel *zaocan = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/4*2, self.view.frame.size.width/4, self.view.frame.size.width/4, 30)];
    zaocan.text = @"食话";
    zaocan.textAlignment = NSTextAlignmentCenter;

    
    FenleiModel *fenleimodel4 = self.fenleidataSource[3];

     UIImageView *fujinimage = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/4*3, 0, self.view.frame.size.width/4, self.view.frame.size.width/4)];
    fujinimage.tag = 154;
    fujinimage.userInteractionEnabled = YES;

    UITapGestureRecognizer *tap4 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    tap4.numberOfTapsRequired = 1;
    tap4.numberOfTouchesRequired = 1;
    
    [fujinimage addGestureRecognizer:tap4];
    UILabel *fujin = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/4*3, self.view.frame.size.width/4, self.view.frame.size.width/4, 30)];
    fujin.text = fenleimodel4.title;
    fujin.textAlignment = NSTextAlignmentCenter;

    [candanfenleiimage sd_setImageWithURL:[NSURL URLWithString:fenleimodel1.image]];
    [shipincaipuimage sd_setImageWithURL:[NSURL URLWithString:fenleimodel2.image]];
    [zaocanimage sd_setImageWithURL:[NSURL URLWithString:fenleimodel3.image]];
    [fujinimage sd_setImageWithURL:[NSURL URLWithString:fenleimodel4.image]];
    
    
   
    [bigView addSubview:candanfenleiimage];
    [bigView addSubview:shipincaipuimage];
    [bigView addSubview:zaocanimage];
    [bigView addSubview:fujinimage];
    [bigView addSubview:caidanfenlei];
    [bigView addSubview:shipincaipu];
    [bigView addSubview:zaocan];
    [bigView addSubview:fujin];
    bigView.userInteractionEnabled = YES;

     [_BigView addSubview:bigView];
    
    [_tableView registerNib:[UINib nibWithNibName:@"ZTTableViewCell" bundle:nil] forCellReuseIdentifier:@"cellID"];
}

-(void)tap:(UITapGestureRecognizer*)tap {
    if(tap.view.tag<120) {
    
        NSInteger tag =   tap.view.tag;
        NSLog(@"%ld",tag);
        SancanModel *model = self.san_candataSource[tag-100];
        
        NSString *DertailId = model.id;
        JiruTuijinDetailViewController *vc = [[JiruTuijinDetailViewController alloc]init];
        vc.url = [NSString stringWithFormat:kDetailView,DertailId];
        vc.hidesBottomBarWhenPushed = YES;

        [self.navigationController pushViewController:vc animated:YES];
    
    }else if(tap.view.tag>150) {
        if (tap.view.tag == 151) {
            CaidanfenleiViewController *vc = [[CaidanfenleiViewController alloc]init];
            vc.hidesBottomBarWhenPushed = YES;

            [self.navigationController pushViewController:vc animated:YES];
        }
        if (tap.view.tag == 152) {
            VideoViewController *vc = [[VideoViewController alloc]init];
//            隐藏界面分栏
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
        if (tap.view.tag == 153) {
            ShiHuaViewController *vc = [[ShiHuaViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
        if (tap.view.tag == 154) {
            FujinViewController *vc = [[FujinViewController alloc]init];
            vc.hidesBottomBarWhenPushed = YES;

            [self.navigationController pushViewController:vc animated:YES];
        }


    
    
    }
    
    
    
    
    

}

/**
 *  创建pageControl
 *
 *
 */
-(void)createpageControl {
    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake((self.view.frame.size.width-300)/2, 550, 300, 50)];
    _pageControl.numberOfPages = 5;
    _pageControl.pageIndicatorTintColor = [UIColor redColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor yellowColor];
    [_pageControl addTarget:self action:@selector(pageControlPressed:) forControlEvents:(UIControlEventEditingChanged)];
    [_BigView addSubview:_pageControl];


}
-(void)pageControlPressed:(UIPageControl*)sender {
    CGFloat offsetX = sender.currentPage *_scroller.frame.size.width;
    [_scroller setContentOffset:CGPointMake(offsetX, 0) animated:YES];
  
}
#pragma make - UITableViewDataSource && UITableViewDelegate

//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//
//
//    return 2;
//
//}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.jinrituijiandataSource.count;
    

}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {


    ZTTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    
    cell.textLabel.text = @"cell";
    ZTModel *model = self.jinrituijiandataSource[indexPath.row];
    [cell config:model];
    
    return cell;

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 200;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    JiruTuijinDetailViewController *vc = [[JiruTuijinDetailViewController alloc]init];
    ZTModel *model = self.jinrituijiandataSource[indexPath.row];
    vc.url = model.f_s_type;
    
    vc.hidesBottomBarWhenPushed = YES;

    [self.navigationController pushViewController:vc animated:YES];

}
#pragma make -- UIScrollViewDelegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger currentpage = scrollView.contentOffset.x / scrollView.frame.size.width;
    
    self.pageControl.currentPage = currentpage;

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
