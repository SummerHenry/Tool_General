//
//  locationModel.h
//  yqDemo
//
//  Created by fangyq on 2017/4/19.
//  Copyright © 2017年 方义强. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface locationModel : NSObject

@property (nonatomic, strong) NSString *address;
@property (nonatomic, assign) CLLocationCoordinate2D     coordinate;
@property (nonatomic, strong) NSString *time;

+ (instancetype)LocationWithAddress:(NSString *)address coordinate:(CLLocationCoordinate2D)coordinate time:(NSString *)time;

@end
