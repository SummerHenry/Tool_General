//
//
//  SFAnnularProgressbar
//
//  Created by cnlive-lsf on 2017/3/27.
//  Copyright © 2017年 lsf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface SFAnnuarMainTool : NSObject
+ (instancetype)defaultShared;

/**
 返回imageView的圆形

 @param frameImg IV的frame
 @param radius 半径
 @param begin 开始角度
 @param end 结束角度
 @param clockwrise 是否顺时针
 @param lineW 宽度
 @param color 颜色
 @return IV
 */
- (UIImageView *)sf_drawIVCircularFrame:(CGRect)frameImg radius:(CGFloat)radius beginDegrees:(double)begin endDegrees:(double)end isClockwrise:(BOOL)clockwrise borderWidth:(CGFloat)lineW borderColor:(UIColor *)color;

/**
 将UIView切割成圆形 CPU负担

 @param view UIView
 */
- (void)sf_cutImageView:(UIView *)view;

/**
 z轴转动

 @return <#return value description#>
 */
- (CABasicAnimation *)sf_returnZAnimantion;

/**
 贝塞尔曲线切圆

 @param center 中心点
 @param radius 半径
 @param start 开始角度
 @param end 结束角度
 @return UIBezierPath
 */
- (UIBezierPath *)sf_bezierPathWithCenter:(CGPoint)center radius:(CGFloat)radius startDegrees:(double)start endDegress:(double)end;

/**
 返回遮罩层

 @param lineWidth 圆环宽度
 @return CAShapeLayer
 */
- (CAShapeLayer *)sf_shapeLayerWithLineWidth:(CGFloat)lineWidth;

/**
 渐变色

 @param view <#view description#>
 */
- (void)sf_setDiffColorView:(UIView *)view;

/**
 将view转换成image

 @param view <#view description#>
 @return <#return value description#>
 */
- (UIImage*)sf_imageWithUIView:(UIView*)view;
@end
