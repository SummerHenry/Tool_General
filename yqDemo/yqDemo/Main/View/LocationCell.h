//
//  LocationCell.h
//  yqDemo
//
//  Created by fangyq on 2017/4/19.
//  Copyright © 2017年 方义强. All rights reserved.
//

#import "WLCustomCell.h"

@interface LocationCell : WLCustomCell

@property (weak, nonatomic) IBOutlet UILabel *addressLab;

@property (weak, nonatomic) IBOutlet UILabel *locLab;

@property (weak, nonatomic) IBOutlet UILabel *timeLab;

@end
