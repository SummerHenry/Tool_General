//
//  locationModel.m
//  yqDemo
//
//  Created by fangyq on 2017/4/19.
//  Copyright © 2017年 方义强. All rights reserved.
//

#import "locationModel.h"

@implementation locationModel

+ (instancetype)LocationWithAddress:(NSString *)address coordinate:(CLLocationCoordinate2D)coordinate time:(NSString *)time
{
    locationModel *loc  = [[[self class] alloc] init];
    loc.address = address;
    loc.coordinate = coordinate;
    loc.time = time;
    
    return loc;
}

@end
