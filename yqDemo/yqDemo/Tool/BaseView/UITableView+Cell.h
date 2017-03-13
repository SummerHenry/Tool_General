//
//  UITableView+Cell.h
//  Logistics
//
//  Created by Olmysoft on 2017/3/10.
//  Copyright © 2017年 方义强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLCustomCell.h"

@interface UITableView (Cell)


- (WLCustomCell *)dequeueAndLoadContentReusableCellFromData:(id)adapter indexPath:(NSIndexPath *)indexPath identifier:(NSString *)identifier;

- (WLCustomCell *)dequeueAndLoadContentReusableCellFromData:(id)adapter indexPath:(NSIndexPath *)indexPath
                                                  controller:(UIViewController *)controller identifier:(NSString *)identifier;

@end
