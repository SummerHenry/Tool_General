//
//  LocationCell.m
//  yqDemo
//
//  Created by fangyq on 2017/4/19.
//  Copyright © 2017年 方义强. All rights reserved.
//

#import "LocationCell.h"
#import "locationModel.h"

@implementation LocationCell


- (void)loadContent
{
    locationModel *model = self.data[self.indexPath.row];
    
    self.addressLab.text = model.address;
    self.locLab.text = [NSString stringWithFormat:@"latitude:%.2f, longitude%.2f", model.coordinate.latitude, model.coordinate.longitude];
    self.timeLab.text = model.time;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
