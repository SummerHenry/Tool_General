//
//  SFAnnularBaseView.h
//  SFAnnularProgressbar
//
//  Created by cnlive-lsf on 2017/3/27.
//  Copyright © 2017年 lsf. All rights reserved.
//

#import "SFBaseView.h"

@interface SFAnnularBaseView : SFBaseView

@property (nonatomic, assign) CGFloat percent;
@property (nonatomic, strong) UILabel *perLabel;

@property (nonatomic, strong) UIButton *actionBtn;
@end
