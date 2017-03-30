//
//  ArcPercentViewController.m
//  yqDemo
//
//  Created by cnlive-lsf on 2017/3/30.
//  Copyright © 2017年 方义强. All rights reserved.
//

#import "ArcPercentViewController.h"
#import "SFAnnularBaseView.h"
@interface ArcPercentViewController ()
@property (nonatomic, strong) SFAnnularBaseView *arcView;
@end

@implementation ArcPercentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.arcView];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - init
- (SFAnnularBaseView *)arcView{
    if (!_arcView) {
        _arcView = [[SFAnnularBaseView alloc] init];
        _arcView.frame = self.view.bounds;
    }
    return _arcView;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
