//
//  ItemModel.m
//  yqDemo
//
//  Created by Olmysoft on 2017/3/13.
//  Copyright © 2017年 方义强. All rights reserved.
//

#import "ItemModel.h"

@implementation ItemModel


+ (instancetype)itemWithName:(NSString *)name object:(id)object {
    
    ItemModel *item  = [[[self class] alloc] init];
    item.name   = name;
    item.object = object;
    
    return item;
}


@end
