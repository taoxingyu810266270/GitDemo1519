//
//  FujinViewController.m
//  TXYMEISHIzaizheli
//
//  Created by qianfeng1 on 16/3/2.
//  Copyright © 2016年 陶星宇. All rights reserved.
//

#import "FujinViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Myannotation.h"
@interface FujinViewController ()<CLLocationManagerDelegate,MKMapViewDelegate>
//地图视图
@property (nonatomic, strong)MKMapView *mapView;
//定位管理器
@property (nonatomic, strong)CLLocationManager *locationmanager;
@end

@implementation FujinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self createMapView];
    [self createManager];
//    [self search];
    [self createBtn];
}
/**
 *  创建一个定期为管理器
 */
-(void)createManager {
    _locationmanager = [[CLLocationManager alloc]init];
    _locationmanager.delegate = self;
//    定位过滤器  用户子类一千米定位一次
    _locationmanager.distanceFilter = 1000;

//    精度 ，精度越高越耗电
    _locationmanager.desiredAccuracy  =kCLLocationAccuracyBest;
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >8.0) {
//        在启动的时候才允许定位
        [_locationmanager requestWhenInUseAuthorization];
    }
    
    [_locationmanager startUpdatingLocation];
    
}
-(void)createMapView {
    //    创建一张地图视图  添加到View上
    _mapView = [[MKMapView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:_mapView];
    _mapView.mapType = MKMapTypeStandard;
    //    显示用户的位置
    _mapView.showsUserLocation = YES;
    
    _mapView.delegate = self;
    _mapView.userTrackingMode = MKUserTrackingModeFollowWithHeading;
    
    
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {

//获取用户的位置
    CLLocation *location = [locations lastObject];
    
    CLLocationCoordinate2D coordinate = location.coordinate;

    //    根据经度和纬度算出来地址
    CLLocation *loc = [[CLLocation alloc]initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    [geocoder reverseGeocodeLocation:loc completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        CLPlacemark *pm = [placemarks lastObject];
        
        
        NSLog(@"%@",pm.addressDictionary[@"Name"]);
        
        
    }];
    
    
}
-(void)createBtn {
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeSystem)];
    button.frame = CGRectMake(10, 80, 100, 50);
    [button setTitle:@"搜索附近美食" forState:(UIControlStateNormal)];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(btnPressed:) forControlEvents:(UIControlEventTouchUpInside)];
    
    
}
-(void)btnPressed:(UIButton*)btn {
   
        [self search];
    
}

//在这个方法里面搜索附近的商店  POI， 热点搜索
-(void)search {
    
    [_mapView removeAnnotations:_mapView.annotations];
    //搜索
    //    MKLocalSearchRequest 创建搜索的请求
    //    MKLocalSearch创建搜索
    
    MKLocalSearchRequest *request = [[MKLocalSearchRequest alloc]init];
    //    设置搜索的关键字
    request.naturalLanguageQuery = @"餐馆";
    //搜索的范围 用户附近
    //    1当前用户的位置 2设置跨度
    request.region = MKCoordinateRegionMake(_mapView.userLocation.coordinate, MKCoordinateSpanMake(0.02, 0.02));
    //    发起搜索
    MKLocalSearch *search = [[MKLocalSearch alloc]initWithRequest:request];
    //    一个异步的请求
    [search startWithCompletionHandler:^(MKLocalSearchResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"111%@",response.mapItems);
        //        循环
        [response.mapItems enumerateObjectsUsingBlock:^(MKMapItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            Myannotation *ant = [[Myannotation alloc]init];
            //            经纬度必须要设置
            ant.coordinate = obj.placemark.location.coordinate;
            ant.title = obj.name;
            ant.subtitle = obj.phoneNumber;
            
            //            添加到地图里面
            [_mapView addAnnotation:ant];
        }];
    }];
    
    
    
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
