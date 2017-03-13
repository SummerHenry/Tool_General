//
//  UITableView+Cell.m
//  Logistics
//
//  Created by Olmysoft on 2017/3/10.
//  Copyright © 2017年 方义强. All rights reserved.
//

#import "UITableView+Cell.h"

@implementation UITableView (Cell)


- (WLCustomCell *)dequeueAndLoadContentReusableCellFromData:(id)data indexPath:(NSIndexPath *)indexPath identifier:(NSString *)identifier{
    WLCustomCell *cell = [self dequeueReusableCellWithIdentifier:identifier];
    [cell setWeakReferenceWithCellData:data indexPath:indexPath tableView:self];
    [cell loadContent];
    return cell;
}

- (WLCustomCell *)dequeueAndLoadContentReusableCellFromData:(id)data indexPath:(NSIndexPath *)indexPath
                                                  controller:(UIViewController *)controller identifier:(NSString *)identifier{
    WLCustomCell *cell = [self dequeueReusableCellWithIdentifier:identifier];
    cell.controller  = controller;
    [cell setWeakReferenceWithCellData:data indexPath:indexPath tableView:self];
    [cell loadContent];
    return cell;
}


@end
