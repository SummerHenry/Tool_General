//
//  YQLocationManager.m
//  Logistics
//
//  Created by fangyq on 2017/3/20.
//  Copyright © 2017年 方义强. All rights reserved.
//

#import "YQLocationManager.h"

#import <BaiduMapAPI_Location/BMKLocationService.h>
#import <BaiduMapAPI_Search/BMKGeocodeSearch.h>
#import "YQBackgroundTaskManager.h"


// 是否大于等于IOS8
#define isIOS8                  ([[[UIDevice currentDevice]systemVersion]floatValue] >=8.0)
// 是否大于IOS9
#define isIOS9                  ([[[UIDevice currentDevice]systemVersion]floatValue] >=9.0)

#define kApplication        [UIApplication sharedApplication]

@interface YQLocationManager ()<BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate>
@property (nonatomic, strong) BMKLocationService *locationService;
@property (nonatomic, assign) NSTimeInterval nowLocationTime;
@property (nonatomic, assign) NSTimeInterval lastLocationTime;
@property (nonatomic) NSTimer *backGroundLocationTime;
@property (nonatomic) NSTimer *restartTime;

@property (nonatomic) YQBackgroundTaskManager *bgTask;
@property (nonatomic, readwrite) CLLocationCoordinate2D lastCoordinate;
@property (nonatomic, copy, readwrite) NSString *lastGeocoderAddress;
@property (nonatomic, copy, readwrite) NSString *lastGeocoderCity;
@property (nonatomic, copy, readwrite) NSString *lastGeocoderProvince;

@end

//为iOS8定位
static CLLocationManager *clLocationManager;

@implementation YQLocationManager

#pragma mark - 初始化

+ (YQLocationManager *)sharedLocationManager{
    static YQLocationManager *LocationManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        LocationManager = [[self alloc] init];
    });
    return LocationManager;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        
        self.locationService = [[BMKLocationService alloc]init];
        
        clLocationManager = [[CLLocationManager alloc]init];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationEnterBackground) name:UIApplicationDidEnterBackgroundNotification object:nil];
    }
    return self;
}

#pragma mark - Custom Accessors (自定义控制器)
- (void)setIsBackGroundLocation:(BOOL)isBackGroundLocation{
    _isBackGroundLocation = isBackGroundLocation;
    if (isBackGroundLocation) {
        self.locationInterval = 60;
        self.locationService.pausesLocationUpdatesAutomatically = NO;
        if (isIOS9) {
            self.locationService.allowsBackgroundLocationUpdates = YES;
        }
    }
    else{
        self.locationInterval = 0;
        self.locationService.pausesLocationUpdatesAutomatically = YES;
        if (isIOS9) {
            self.locationService.allowsBackgroundLocationUpdates = NO;
        }
    }
}
- (void)setLocationInterval:(NSTimeInterval)locationInterval{
    if (locationInterval!=0) {
        NSAssert(self.isBackGroundLocation, @"isBackGroundLocation为NO");
    }
    _locationInterval = locationInterval;
    
    if (self.backGroundLocationTime) {
        [self.backGroundLocationTime invalidate];
        self.backGroundLocationTime = nil;
    }
}

- (void)setYQBackGroundLocationHander:(void (^)(CLLocationCoordinate2D))YQBackGroundLocationHander{
    if (!self.isBackGroundLocation) { //如果 isBackGroundLocation为NO 后台定位将无效
        return;
    }
    _YQBackGroundLocationHander = [YQBackGroundLocationHander copy];
}

#pragma mark - Public (公有方法)

// 获取位置
- (void)receiveCoorinate:(void (^)(CLLocationCoordinate2D, NSError *))coordinateHander geocderAddress:(void (^)(NSString *, NSUInteger))addressHander{
    self.YQLocationCoordinate = [coordinateHander copy];
    self.YQLocationGeocderAddress = [addressHander copy];
}

// 获取当前地址
- (void)geoCodeSearchWithCoorinate:(CLLocationCoordinate2D)coordinate address:(void (^)(NSString *, NSString *, NSString *, NSUInteger))address{
    self.YQLocationGeocderAddress = [address copy];
}

// 开启定位信息
- (void)startLocationService{
    
    self.nowLocationTime = [[NSDate date] timeIntervalSince1970];
    
    //当前时间和最后一次时间相差大于8秒 将重新开启定位 否则返回最近一次定位坐标
    if (self.nowLocationTime - self.lastLocationTime > 8) {
        if (![self _checkCLAuthorizationStatus]) {
            return;
        }
        self.locationService.delegate = self;
        [self.locationService startUserLocationService];
    }
    else{
        if (self.YQLocationCoordinate) {
            self.YQLocationCoordinate(self.lastCoordinate, nil);
            //如果需要反地理编码
            if (self.YQLocationGeocderAddress) {
                [self reverseGeoCodeCoordinate:self.lastCoordinate];
            }
        }
    }
}

// 停止定位服务
- (void)stopLocationService{
    if (self.backGroundLocationTime) {
        [self.backGroundLocationTime invalidate];
        self.backGroundLocationTime = nil;
    }
    if (self.restartTime) {
        [self.restartTime invalidate];
        self.restartTime = nil;
    }
    self.locationService.delegate = nil;
    [self.locationService stopUserLocationService];
}

#pragma mark - Private (私有方法)
- (void)restartLocationUpdates{
    NSLog(@"重启定位服务");
    if (self.restartTime) {
        [self.restartTime invalidate];
        self.restartTime = nil;
    }
    [self startLocationService];
}

- (void)backGroundBackCoordinate{
    if ([self _checkCLAuthorizationStatus]) {
        if (self.YQBackGroundLocationHander) {
            CLLocationCoordinate2D LocationCoordinate = self.lastCoordinate;
            self.YQBackGroundLocationHander(LocationCoordinate);
            if (self.YQLocationGeocderAddress) {
                [self reverseGeoCodeCoordinate:LocationCoordinate];
            }
        }
        if (self.YQBackGroundGeocderAddressHander) {
            NSString *address = self.lastGeocoderAddress;
            self.YQBackGroundGeocderAddressHander(address);
        }
    }
}

//检测是否打开定位
- (BOOL)_checkCLAuthorizationStatus{
    if ([CLLocationManager locationServicesEnabled] == NO){
        [self YQShowAlertWithMessage:@"设备的所有位置服务已经被禁用"];
        return NO;
    }else{
        CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
        if (kCLAuthorizationStatusDenied == status || kCLAuthorizationStatusRestricted == status) {
            [self YQShowAlertWithMessage:@"定位服务未开启"];
            return NO;
        }
        return YES;
    }
}

- (void)applicationEnterBackground{
    if (self.isBackGroundLocation) {
        if (isIOS8) {
            [clLocationManager requestAlwaysAuthorization];
        }
        [self startLocationService];
        
        //如果是需要进行后台定位将设置后台任务
        self.bgTask = [YQBackgroundTaskManager sharedBackgroundTaskManager];
        [self.bgTask beginNewBackgroundTask];
    }
}


- (void)reverseGeoCodeCoordinate:(CLLocationCoordinate2D)coordinate{
    BMKGeoCodeSearch *geoCodeSearch = [[BMKGeoCodeSearch alloc]init];
    geoCodeSearch.delegate = self;
    BMKReverseGeoCodeOption *reversegeoCode = [[BMKReverseGeoCodeOption alloc]init];
    reversegeoCode.reverseGeoPoint = coordinate;
    BOOL flag = [geoCodeSearch reverseGeoCode:reversegeoCode];
    if (flag) {
        NSLog(@"反检索成功");
    }
    else
    {
        NSLog(@"反检索失败");
    }
}

#pragma mark - Protocol conformance (协议代理)
#pragma mark - BMKLocationServiceDelegate
// 位置更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation{
    
    self.lastLocationTime = [[NSDate date] timeIntervalSince1970];
    
    self.lastCoordinate = userLocation.location.coordinate;
    if (self.YQLocationCoordinate) {
        CLLocationCoordinate2D LocationCoordinate = userLocation.location.coordinate;
        self.YQLocationCoordinate(LocationCoordinate, nil);
    }
    
    if (self.isBackGroundLocation) {
        
        if (self.restartTime) {
            return;
        }
        
        self.bgTask = [YQBackgroundTaskManager sharedBackgroundTaskManager];
        [self.bgTask beginNewBackgroundTask];
        if (!self.backGroundLocationTime) {
            self.backGroundLocationTime = [NSTimer scheduledTimerWithTimeInterval:self.locationInterval target:self
                                                                         selector:@selector(backGroundBackCoordinate)
                                                                         userInfo:nil
                                                                          repeats:YES];
            [self backGroundBackCoordinate];
            [[NSRunLoop currentRunLoop] addTimer:self.backGroundLocationTime forMode:NSRunLoopCommonModes];
        }
        //如果1分钟没有调用代理将重启定位服务
        self.restartTime = [NSTimer scheduledTimerWithTimeInterval:60 target:self
                                                          selector:@selector(restartLocationUpdates)
                                                          userInfo:nil
                                                           repeats:NO];
        [[NSRunLoop currentRunLoop] addTimer:self.restartTime forMode:NSRunLoopCommonModes];
    }
    else{
        [self stopLocationService];
    }
}

-(void)didFailToLocateUserWithError:(NSError *)error{
    if (self.YQLocationCoordinate) {
        CLLocationCoordinate2D errorCoordinate;
        self.YQLocationCoordinate(errorCoordinate, error);
    }
}



#pragma mark - BMKGeoCodeSearchDelegate
// 地理编码
- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error{
    if (error == BMK_SEARCH_NO_ERROR) {
        self.lastGeocoderAddress = [NSString stringWithFormat:@"%@%@", result.address, [result.poiList.firstObject name]];
        self.lastGeocoderCity = result.addressDetail.city;
        self.lastGeocoderProvince = result.addressDetail.province;
    }
    else{
        self.lastGeocoderAddress = @"未知位置";
    }
    if (self.YQLocationGeocderAddress) {
        NSString *address = self.lastGeocoderAddress;
        NSString *city = self.lastGeocoderCity;
        NSString *province = self.lastGeocoderProvince;
        self.YQLocationGeocderAddress(address, city, province, error);
    }
}

// 提醒框
- (void)YQShowAlertWithMessage:(NSString *)message
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:message message:@"您可以通过设置->隐私->定位服务中设置本应用可以使用定位" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"去设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if ([[UIApplication sharedApplication] canOpenURL:url])
        {
            [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
        }
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alert addAction:cancelAction];
    [alert addAction:okAction];
    [kApplication.keyWindow.rootViewController presentViewController:alert animated:YES completion:^{
    }];
}


- (void)dealloc{
    [self.restartTime invalidate];
    self.restartTime = nil;
    [self.backGroundLocationTime invalidate];
    self.backGroundLocationTime = nil;
}


@end
