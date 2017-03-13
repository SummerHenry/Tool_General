//
//  ListItemCell.m
//  yqDemo
//
//  Created by Olmysoft on 2017/3/13.
//  Copyright © 2017年 方义强. All rights reserved.
//

#import "ListItemCell.h"
#import "ItemModel.h"
#import "POP.h"

@implementation ListItemCell

- (void)setupCell {
    
    self.accessoryType  = UITableViewCellAccessoryDisclosureIndicator;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)loadContent
{
    if (self.data) {
        ItemModel *item                = self.data[self.indexPath.row];
        self.titleLabel.text = item.name;
        self.subTitleLabel.text   = [NSString stringWithFormat:@"%@", [item.object class]];
    }
    
    if (self.indexPath.row % 2) {
        self.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.05f];
    } else {
        
        self.backgroundColor = [UIColor whiteColor];
    }
    
}


- (void)selectedEvent
{
    ItemModel             *item        = self.data[self.indexPath.row];
//    UIViewController *controller  = [item.object new];
    UIViewController *controller = [self.controller.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass(item.object)];
    controller.title             = item.name;
    [self.controller.navigationController pushViewController:controller animated:YES];
}


- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setupCell];
}


- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    
    [super setHighlighted:highlighted animated:animated];
    
    if (self.highlighted) {
        POPBasicAnimation *scaleAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewScaleXY];
        scaleAnimation.duration           = 0.1f;
        scaleAnimation.toValue            = [NSValue valueWithCGPoint:CGPointMake(0.95, 0.95)];
        [self.titleLabel pop_addAnimation:scaleAnimation forKey:@"scaleAnimation"];
        
    } else {
        
        POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
        scaleAnimation.toValue             = [NSValue valueWithCGPoint:CGPointMake(1, 1)];
        scaleAnimation.velocity            = [NSValue valueWithCGPoint:CGPointMake(2, 2)];
        scaleAnimation.springBounciness    = 20.f;
        [self.titleLabel pop_addAnimation:scaleAnimation forKey:@"scaleAnimation"];
    }
}


@end
