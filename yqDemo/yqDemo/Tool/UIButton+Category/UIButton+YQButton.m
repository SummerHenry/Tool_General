//
//  UIButton+YQButton.m
//  huosuda
//
//  Created by Olmysoft on 2016/08/26.
//  Copyright © 2016年 方义强. All rights reserved.
//

#import "UIButton+YQButton.h"
#import <objc/runtime.h>
#import <objc/message.h>

@interface UIButton ()

@property (nonatomic, copy) targetBlcok block;

@end


@implementation UIButton (YQButton)


- (void)addTargetAction:(targetBlcok)blcok
{
    self.block = blcok;
    if (self.block) {
        [self addTarget:self action:@selector(didBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    } else {
        [self removeTarget:self action:@selector(didBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)didBtnClick:(UIButton *)btn
{
    if (self.block) {
        self.block(btn);
    }
}


- (void)setDisableWithColor:(UIColor *)color
{
    self.backgroundColor = color;
    self.enabled = NO;
}


- (void)setAbleWithColor:(UIColor *)color
{
    self.backgroundColor = color;
    self.enabled = YES;
}


#pragma mark - 动态时Setter & Getter.

- (void)setBlock:(targetBlcok)block
{
    objc_setAssociatedObject(self, @selector(block), block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}


- (targetBlcok)block
{
    return objc_getAssociatedObject(self, _cmd);
}


@end
