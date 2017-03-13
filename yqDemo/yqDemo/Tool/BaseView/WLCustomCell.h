//
//  WLCustomCell.h
//  Logistics
//
//  Created by Olmysoft on 2017/3/10.
//  Copyright © 2017年 方义强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WLCustomCell : UITableViewCell

/**
 *  CustomCell's data.
 */
@property (nonatomic, weak) id                       data;

/**
 *  CustomCell's indexPath.
 */
@property (nonatomic, weak) NSIndexPath             *indexPath;

/**
 *  TableView.
 */
@property (nonatomic, weak) UITableView             *tableView;

/**
 *  Controller.
 */
@property (nonatomic, weak) UIViewController        *controller;


#pragma mark - Method you should overwrite.

/**
 *  Setup cell, override by subclass.
 */
- (void)setupCell;
/**
 *  Load content, override by subclass.
 */
- (void)loadContent;

- (void)selectedEvent;

/**
 *  Convenient method to set some weak reference.
 *
 *  @param data        Data.
 *  @param indexPath   IndexPath.
 *  @param tableView   TableView.
 */
- (void)setWeakReferenceWithCellData:(id)data
                                  indexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView;

/**
 *  Register to tableView with the reuseIdentifier you specified.
 *
 *  @param tableView       TableView.
 *  @param reuseIdentifier The cell reuseIdentifier.
 */
+ (void)registerToTableView:(UITableView *)tableView reuseIdentifier:(NSString *)reuseIdentifier;

/**
 *  Register to tableView with the The class name.
 *
 *  @param tableView       TableView.
 */
+ (void)registerToTableView:(UITableView *)tableView;



@end
