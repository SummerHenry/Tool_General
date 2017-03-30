//
//  SFAnnularBaseView.m
//  SFAnnularProgressbar
//
//  Created by cnlive-lsf on 2017/3/27.
//  Copyright © 2017年 lsf. All rights reserved.
//

#import "SFAnnularBaseView.h"
#import "SFAnnuarMainTool.h"
#import "UIView+SFExtension.h"
#import "SFAnnularAnimView.h"
#import "UIButton+YQButton.h"
#define height(view) view.bounds.size.height
#define weight(view) view.bounds.size.width

@interface SFAnnularBaseView(){
    UIImageView *_circularIV;
    CGFloat _p;
    SFAnnularAnimView *_animView;
    dispatch_source_t _timer;
    dispatch_time_t _start;
    NSInteger _curPer;
}

@end

@implementation SFAnnularBaseView
#pragma mark - system method
- (instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        _circularIV = [[SFAnnuarMainTool defaultShared] sf_drawIVCircularFrame:CGRectMake(0, 0, wh, wh) radius:radius beginDegrees:0 endDegrees:2 * M_PI isClockwrise:YES borderWidth:5 borderColor:[UIColor colorWithRed:182/255.0 green:214/255.0 blue:247/255.0 alpha:1]];
        [self addSubview: _circularIV];
        _p = 0.3;
        _curPer = 0;
        _animView = [[SFAnnularAnimView alloc] init];
        [_circularIV addSubview:_animView];
        _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(0, 0));
        uint64_t interval = 1.0 * NSEC_PER_SEC;
        _start = dispatch_time(DISPATCH_TIME_NOW, 0);
        dispatch_source_set_timer(_timer, _start, interval, 0);
        dispatch_async(dispatch_queue_create("com.timer", DISPATCH_QUEUE_CONCURRENT), ^{
            dispatch_source_set_event_handler(_timer, ^{
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.perLabel.text = [NSString stringWithFormat:@"%ld%%", _curPer++];
                });
                _animView.percent = _curPer / 100.0;
            });
        });
//        dispatch_resume(_timer);
    }
    return self;
}

- (void)drawRect:(CGRect)rect{
    _circularIV.frame = CGRectMake(HalfV(self.bounds.size.width - wh), HalfV(self.bounds.size.height - wh), wh, wh);
    _animView.frame = _circularIV.bounds;
    self.perLabel.frame = CGRectMake( 0, HalfV(_circularIV.height) - 13, _circularIV.width, 25);
    self.actionBtn.frame = CGRectMake(self.centerX - 25, self.centerY + radius + 20, 50, 30);
    [super drawRect:rect];
}

#pragma mark - set 
- (void)setPercent:(CGFloat)percent{
    _p = percent;
}

#pragma mark - get 
- (UILabel *)perLabel{
    if (!_perLabel) {
        _perLabel = [[UILabel alloc] init];
        _perLabel.textColor = [UIColor lightGrayColor];
        _perLabel.font = [UIFont systemFontOfSize:15];
        _perLabel.textAlignment = NSTextAlignmentCenter;
        _perLabel.text = @"100%";
        [_circularIV addSubview:_perLabel];
    }
    return _perLabel;
}

- (UIButton *)actionBtn{
    if (!_actionBtn) {
        _actionBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_actionBtn setTitleColor:[UIColor blueColor] forState:(UIControlStateNormal & UIControlStateSelected)];
        [_actionBtn setTitle:@"开始" forState:(UIControlStateNormal)];
        [_actionBtn setTitle:@"暂停" forState:(UIControlStateSelected)];
        _actionBtn.selected = NO;
        BS(bs);
        [_actionBtn addTargetAction:^(UIButton *sender) {
            if (sender.isSelected) {
                dispatch_suspend(bs->_timer);
            }else{
                dispatch_resume(bs->_timer);
            }
            sender.selected = !sender.isSelected;
        }];
        [self addSubview:_actionBtn];
    }
    return _actionBtn;
}
@end
