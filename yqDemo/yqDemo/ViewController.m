//
//  ViewController.m
//  yqDemo
//
//  Created by Olmysoft on 2017/3/13.
//  Copyright © 2017年 方义强. All rights reserved.
//

#import "ViewController.h"
#import "UITableView+Cell.h"
#import "ItemModel.h"

#import "ButtonClickViewController.h"
#import "LoadingViewController.h"
#import "ArcPercentViewController.h"

static NSString *kListItemCell = @"listItemCell";

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [tableView dequeueAndLoadContentReusableCellFromData:self.dataArray indexPath:indexPath controller:self identifier:kListItemCell];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [(WLCustomCell *)[tableView cellForRowAtIndexPath:indexPath] selectedEvent];
}


- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
        [_dataArray addObject:[ItemModel itemWithName:@"Button Block动态时实现" object:[ButtonClickViewController class]]];
        [_dataArray addObject:[ItemModel itemWithName:@"tableView 加载" object:[LoadingViewController class]]];
        [_dataArray addObject:[ItemModel itemWithName:@"动态圆环百分比" object:[ArcPercentViewController class]]];
    }
    return _dataArray;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
