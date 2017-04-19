//
//  YQLocationManager.h
//  Logistics
//
//  Created by fangyq on 2017/3/20.
//  Copyright © 2017年 方义强. All rights reserved.
//


/*
 
 
 ************ 因为使用单例持续获取定位位置，所有的block回调，在你最后一次调用的回调block中返回所需的值。***************
 
 */

#import <Foundation/Foundation.h>

@import CoreLocation;
@interface YQLocationManager : NSObject

//是否开启后台定位 默认为NO
@property (nonatomic, assign) BOOL isBackGroundLocation;

//isBackGroudLocation为YES时，设置LocationInterval默认为1分钟
@property (nonatomic, assign) NSTimeInterval locationInterval;

//后台定位开启时 返回定位经纬度
@property (nonatomic, copy) void (^YQBackGroundLocationHander) (CLLocationCoordinate2D coordinate);

//后台定位开启时 返回反编码地理位置
@property (nonatomic, copy) void (^YQBackGroundGeocderAddressHander) (NSString *address);

//获取经纬度
@property (nonatomic, copy) void (^YQLocationCoordinate) (CLLocationCoordinate2D coordinate, NSError *error);

//获取反编码地理位置
@property (nonatomic, copy) void (^YQLocationGeocderAddress) (NSString *address, NSString *city, NSString *province,  NSUInteger error);

//最近一次定位的经纬度
@property (nonatomic, readonly) CLLocationCoordinate2D lastCoordinate;

//最近一次反编码地理位置
@property (nonatomic, copy, readonly) NSString *lastGeocoderAddress;

//通过单例创建
+ (YQLocationManager *)sharedLocationManager;

//获取经纬度和反编码地理位置
- (void)receiveCoorinate:(void (^)(CLLocationCoordinate2D coordinate, NSError *error))coordinateHander geocderAddress:(void (^)(NSString *address, NSUInteger error))addressHander;


//传入经纬度获取反编码地理位置
- (void)geoCodeSearchWithCoorinate:(CLLocationCoordinate2D)coordinate address:(void (^)(NSString *address, NSString *city, NSString *province, NSUInteger error))address;

//开始定位
- (void)startLocationService;

//停止定位
- (void)stopLocationService;


@end
