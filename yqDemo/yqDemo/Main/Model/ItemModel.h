//
//  ItemModel.h
//  yqDemo
//
//  Created by Olmysoft on 2017/3/13.
//  Copyright © 2017年 方义强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ItemModel : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) id        object;

+ (instancetype)itemWithName:(NSString *)name object:(id)object;

@end
