//
//  SFAnnuarMainTool.m
//  SFAnnularProgressbar
//
//  Created by cnlive-lsf on 2017/3/27.
//  Copyright © 2017年 lsf. All rights reserved.
//

#import "SFAnnuarMainTool.h"

@interface SFAnnuarMainTool()

@end

SFAnnuarMainTool *tool = nil;

@implementation SFAnnuarMainTool
+ (instancetype)defaultShared{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!tool) {
            tool = [[SFAnnuarMainTool alloc] init];
        }
    });
    return tool;
}

#pragma mark - public method
- (UIImageView *)sf_drawIVCircularFrame:(CGRect)frameImg radius:(CGFloat)radius beginDegrees:(double)begin endDegrees:(double)end isClockwrise:(BOOL)clockwrise borderWidth:(CGFloat)lineW borderColor:(UIColor *)color{
    UIImageView *img = [[UIImageView alloc] initWithFrame:frameImg];
    UIGraphicsBeginImageContext(img.bounds.size); // 开始绘画 返回图形的大小
    CGContextRef ctr = UIGraphicsGetCurrentContext(); // 获取当前画布
    CGContextSetStrokeColorWithColor(ctr, color.CGColor); // 设置边框的颜色
    CGContextSetLineWidth(ctr, lineW);
    CGFloat radiu = MIN(MIN(frameImg.size.height, frameImg.size.width) / 2.0, radius);
    CGContextAddArc(ctr, img.frame.size.width / 2.0, img.frame.size.height / 2.0, radiu, begin, end, clockwrise);
    CGContextDrawPath(ctr, kCGPathStroke);
    img.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

- (void)sf_cutImageView:(UIView *)view{
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:view.frame.size];
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    layer.frame = view.bounds;
    layer.path = path.CGPath;
    view.layer.mask = layer;
}

- (CABasicAnimation *)sf_returnZAnimantion{
    CABasicAnimation *zAnim = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    zAnim.repeatCount = HUGE_VAL;
    zAnim.removedOnCompletion = YES;
    zAnim.duration = 5;
    zAnim.fromValue = @0;
    zAnim.toValue = @(2 * M_PI);
    return zAnim;
}

- (UIBezierPath *)sf_bezierPathWithCenter:(CGPoint)center radius:(CGFloat)radius startDegrees:(double)start endDegress:(double)end{
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:start endAngle:end clockwise:NO];
    return circlePath;
}

- (CAShapeLayer *)sf_shapeLayerWithLineWidth:(CGFloat)lineWidth{
    CAShapeLayer *waveline = [CAShapeLayer layer];
    waveline.lineCap = kCALineCapButt;
    waveline.lineJoin = kCALineJoinRound;
    waveline.strokeColor = [UIColor redColor].CGColor;
    waveline.fillColor = [[UIColor clearColor] CGColor];
    waveline.lineWidth = lineWidth;
    waveline.backgroundColor = [UIColor clearColor].CGColor;
    return waveline;
}

- (void)sf_setDiffColorView:(UIView *)view{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)[UIColor redColor].CGColor, (__bridge id)[UIColor yellowColor].CGColor, (__bridge id)[UIColor blueColor].CGColor];
    gradientLayer.locations = @[@0.3, @0.5, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 0);
    gradientLayer.frame = CGRectMake(0, 100, 300, 100);
    [view.layer addSublayer:gradientLayer];
}

- (UIImage *)sf_imageWithUIView:(UIView *)view{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, YES, view.layer.contentsScale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end
