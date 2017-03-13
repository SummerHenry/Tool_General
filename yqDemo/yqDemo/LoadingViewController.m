//
//  LoadingViewController.m
//  yqDemo
//
//  Created by Olmysoft on 2017/3/13.
//  Copyright © 2017年 方义强. All rights reserved.
//

#import "LoadingViewController.h"
#import "UITableView+Gzw.h"
#import "GCD.h"

@interface LoadingViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *data;


@end

@implementation LoadingViewController

-(NSMutableArray *)data
{
    if (!_data) {
        _data = [NSMutableArray array];
    }
    return _data;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configueLoad];
    [self setNavi];
}

- (void)configueLoad
{
    self.tableView.tableFooterView = [UIView new];
    self.tableView.loadedImageName = @"placeholder_fancy";
    // 其他配置参数
    //    self.tableView.buttonText = @"再次请求";
    //    self.tableView.buttonNormalColor = [UIColor redColor];
    //    self.tableView.buttonHighlightColor = [UIColor yellowColor];
    //    self.tableView.descriptionText = @"破网络，你还是再请求一次吧";
    //    self.tableView.dataVerticalOffset = 200;
    // 回调
    [self.tableView gzwLoading:^{
        NSLog(@"点击了再试按钮");
        [self loadingData:YES];
    }];
    
    // 网络请求，请求动画
    [self loadingData:YES];
    
}

- (void)setNavi
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"没有数据" style:UIBarButtonItemStyleDone target:self action:@selector(noData:)];
}

- (void)loadData:(id)sender {
    [self loadingData:YES];
}


- (void)noData:(id)sender {
    [self loadingData:NO];
}



-(void)loadingData:(BOOL)data
{
    if (self.data.count > 0) {
        [self.data removeAllObjects];
        [self.tableView reloadData];
    }
    
    self.tableView.loading = YES;
    
    // GCD延迟加载
    [GCDQueue executeInMainQueue:^{
        if (data) {
            for (int i = 0; i < 10; i++) {
                [self.data addObject:[NSString stringWithFormat:@"%d. it's data", i]];
            }
        }else {// 无数据时
            self.tableView.loading = NO;
        }
        [self.tableView reloadData];
    } afterDelaySecs:2];
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
    cell.textLabel.text = self.data[indexPath.row];
    return cell;
}



@end
