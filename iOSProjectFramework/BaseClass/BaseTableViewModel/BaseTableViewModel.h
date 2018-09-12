//
//  BaseTableViewModel.h
//  QMMedical
//
//  Created by 洪冬介 on 2018/3/26.
//  Copyright © 2018年 Quanmai. All rights reserved.
//

#import "BaseViewModel.h"
#import "QMTableViewCell.h"

typedef void (^TableViewDidScrollBlock)(CGFloat offsetY);

@interface BaseTableViewModel : BaseViewModel<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, copy) DidSelectItemBlock didSelectItemBlock;
@property (nonatomic, copy) TableViewDidScrollBlock tableViewDidScrollBlock;

@property (nonatomic, weak) BaseViewController *hostVC;


- (void)handleWithTable:(UITableView *)table;
- (void)refreshData;

@end
