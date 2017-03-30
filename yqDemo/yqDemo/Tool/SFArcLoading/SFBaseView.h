//
//  SFBaseView.h
//  SFAnnularProgressbar
//
//  Created by cnlive-lsf on 2017/3/28.
//  Copyright © 2017年 lsf. All rights reserved.
//

#import <UIKit/UIKit.h>

static const CGFloat wh = 120;
static const CGFloat radius = 50;
static const CGFloat circularW = 10;
#define HalfV(value) ((value) / 2.0)
#define DoubV(value) ((value) * 2.0)

#define BS(blockSelf) __block __typeof(&*self)blockSelf = self;
@interface SFBaseView : UIView

@end
