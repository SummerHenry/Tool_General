//
//  LocationTimingViewController.m
//  yqDemo
//
//  Created by fangyq on 2017/4/19.
//  Copyright © 2017年 方义强. All rights reserved.
//

#import "LocationTimingViewController.h"
#import "LocationCell.h"
#import "UITableView+Cell.h"
#import "locationModel.h"
#import "YQLocationManager.h"

@interface LocationTimingViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) YQLocationManager *manager;


@end

@implementation LocationTimingViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setup];
    [self setupLocation];
    
}

#pragma mark -Location

- (void)setupLocation
{
    self.manager.isBackGroundLocation = YES;
    _manager.locationInterval = 10;
    __block YQLocationManager *blockManager = _manager;
    __block LocationTimingViewController *weakSelf = self;
    [_manager setYQBackGroundLocationHander:^(CLLocationCoordinate2D coordinate) {
        [blockManager geoCodeSearchWithCoorinate:coordinate address:^(NSString *address, NSString *city, NSString *province, NSUInteger error) {
            if (error == 0) {
                NSLog(@"----%.2f---%.2f----%@", coordinate.latitude, coordinate.longitude, address);
                locationModel *loc = [locationModel LocationWithAddress:address coordinate:coordinate time:[weakSelf getNowDateTime]];
                [weakSelf.dataArray addObject:loc];
                [weakSelf.tableView reloadData];
            }
        }];
    }];
    
    [_manager startLocationService];
}



#pragma mark - TableView


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.tableView dequeueAndLoadContentReusableCellFromData:self.dataArray indexPath:indexPath controller:self identifier:@"locationCell"];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [(WLCustomCell *)[tableView cellForRowAtIndexPath:indexPath] selectedEvent];
}

#pragma mark - setup

- (void)setup
{
    self.tableView.estimatedRowHeight = 90.f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.tableFooterView = [UIView new];
}

- (NSString *)getNowDateTime

{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
    NSString *dateTime = [formatter stringFromDate:date];

    return dateTime;
}

#pragma mark - 懒加载

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (YQLocationManager *)manager
{
    if (!_manager) {
        _manager = [YQLocationManager sharedLocationManager];
    }
    return _manager;
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_manager stopLocationService];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
