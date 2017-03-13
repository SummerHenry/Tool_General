//
//  WLCustomCell.m
//  Logistics
//
//  Created by Olmysoft on 2017/3/10.
//  Copyright © 2017年 方义强. All rights reserved.
//

#import "WLCustomCell.h"

@implementation WLCustomCell


- (void)setupCell {
    
}

- (void)loadContent {
    
}

- (void)selectedEvent {
    
}


- (void)setWeakReferenceWithCellData:(id)data indexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView {
    _data        = data;
    _indexPath   = indexPath;
    _tableView   = tableView;
}


+ (void)registerToTableView:(UITableView *)tableView reuseIdentifier:(NSString *)reuseIdentifier {
    
    [tableView registerClass:[self class] forCellReuseIdentifier:reuseIdentifier];
}

+ (void)registerToTableView:(UITableView *)tableView {
    
    [tableView registerClass:[self class] forCellReuseIdentifier:NSStringFromClass([self class])];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupCell];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
