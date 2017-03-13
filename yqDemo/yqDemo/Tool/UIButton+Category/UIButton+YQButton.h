//
//  UIButton+YQButton.h
//  huosuda
//
//  Created by Olmysoft on 2016/08/26.
//  Copyright © 2016年 方义强. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^targetBlcok)(UIButton *btn);

@interface UIButton (YQButton)


- (void)setDisableWithColor:(UIColor *)color;
- (void)setAbleWithColor:(UIColor *)color;

- (void)addTargetAction:(targetBlcok)blcok;


@end
