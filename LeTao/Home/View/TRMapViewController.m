//
//  TRMapViewController.m
//  LeTao
//
//  Created by tarena on 16/5/7.
//  Copyright © 2016年 Fu_sion. All rights reserved.
//

#import "TRMapViewController.h"
#import <MapKit/MapKit.h>
#import "DPAPI.h"
#import "TRMataDataTool.h"
#import "TRDeal.h"
#import "TRAnnotation.h"
#import "TRCategory.h"
@interface TRMapViewController ()<CLLocationManagerDelegate,MKMapViewDelegate,DPRequestDelegate,MKAnnotation>
@property (nonatomic, strong) CLLocationManager *manager;
@property (nonatomic, strong) MKMapView *mapView;
/**
 *  地理编码
 */
@property (nonatomic, strong) CLGeocoder *geocder;
/**
 *  城市名字
 */
@property (nonatomic, copy) NSString *cityName;
@end

@implementation TRMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   //初始化并添加
    self.geocder = [CLGeocoder new];
    self.mapView = [[MKMapView alloc]initWithFrame:self.view.bounds];
    self.manager = [CLLocationManager new];
    self.mapView.delegate = self;
    //定位
    [self.manager requestWhenInUseAuthorization];
    self.mapView.userTrackingMode = MKUserTrackingModeFollow;
    [self.view addSubview:self.mapView];
    [self addBackButton];
    
}

#pragma mark 按钮相关
- (void)addBackButton{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(back)];
}
- (void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - mapViewDelegate
//时机一:设置参数发送请求
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    [self.geocder reverseGeocodeLocation:userLocation.location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (!error) {
            CLPlacemark *placemark = [placemarks lastObject];
            NSString *cityName = placemark.addressDictionary[@"City"];
            //北京市 --> 北京(前提:语言中文的)
            self.cityName = [cityName substringToIndex:cityName.length - 1];
        }
    }];
    //直接调用时机二方法
    [self mapView:mapView regionDidChangeAnimated:YES];
}
//时机二:设置参数 ,发送请求
- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
    //地图区域挪动停止之后
    //city latitude longittude radius
    
    //如果城市名字为空,直接返回
    if (!self.cityName) {
        return;
    }
    
    //设定参数(city/地图中心经纬度/半径);
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"city"] = self.cityName;
    params[@"latitude"] = @(mapView.region.center.latitude);
    params[@"longitude"] = @(mapView.region.center.longitude);
    params[@"radius"] = @3000;
    //发送请求
    DPAPI *api = [DPAPI new];
    [api requestWithURL:@"v1/deal/find_deals" params:params delegate:self];
    
}
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    if ([annotation isKindOfClass:[MKUserLocation class ]]) {
        return nil;
    }
    static NSString *identifer = @"annotation";
    MKAnnotationView *view = [mapView dequeueReusableAnnotationViewWithIdentifier:identifer];
    if (!view) {
        view   = [[MKAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:identifer];
        view.canShowCallout = YES;
        TRAnnotation *anno = (TRAnnotation *)annotation;
        view.image = anno.image;
    }else{
         view.annotation = annotation;
    }return view;
}
#pragma mark -- DPDIanPing Delegate 
- (void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result{
    /**
     *  返回成功
     *
     *  @return 解析businesses值(经纬度) :TRBusiness +TRMetaDataTool接口
     添加大头针对象 TRAnnotation
     */
    NSArray *allDealsArray = [TRMataDataTool parseDealsResult:result];
    for (TRDeal *deal in allDealsArray) {
        //给定订单对象,返回所有商家的数组(TRBusiness)
        NSArray *businessArray = [TRMataDataTool getAllBusiness:deal];
        
        //给定订单对象,返回该订单所属的分类
        //TRCategory(map_ico 本地图片名字)
        TRCategory *category = [TRMataDataTool getCategoryWIthDeal:deal];
        //每个店家对应一个大头针对象
        for (TRBusiness *business in businessArray) {
            //添加大头针对象到地图上
            TRAnnotation *annotion = [TRAnnotation new];
            annotion.coordinate = CLLocationCoordinate2DMake(business.latitude, business.longitude);
            annotion.title = business.name;
            annotion.subtitle = deal.desc;
            //给大头针 添加自定义图片
            //如果能找到所属分类 给图片
            if (category) {
                annotion.image = [UIImage imageNamed:category.map_icon];
            }else{
                annotion.image = [UIImage imageNamed:@"icon_map_location"];
            }
            
            
            [self.mapView addAnnotation:annotion];
        }
    }
}
- (void)request:(DPRequest *)request didFailWithError:(NSError *)error{
    
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
