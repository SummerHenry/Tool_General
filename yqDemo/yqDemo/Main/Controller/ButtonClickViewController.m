//
//  ButtonClickViewController.m
//  yqDemo
//
//  Created by Olmysoft on 2017/3/13.
//  Copyright © 2017年 方义强. All rights reserved.
//

#import "ButtonClickViewController.h"
#import "UIButton+YQButton.h"

@interface ButtonClickViewController ()


@property (weak, nonatomic) IBOutlet UIButton *clickBtn;


@end

@implementation ButtonClickViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.clickBtn addTargetAction:^(UIButton *btn) {
        NSLog(@"点击了clickBtn");
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
