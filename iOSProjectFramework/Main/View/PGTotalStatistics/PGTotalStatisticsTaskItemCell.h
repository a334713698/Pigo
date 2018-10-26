//
//  PGTotalStatisticsTaskItemCell.h
//  iOSProjectFramework
//
//  Created by quanmai on 2018/10/26.
//  Copyright © 2018年 洪冬介. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PGTotalStatisticsTaskItemCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *countLab;
@property (nonatomic, strong) UILabel *lenLab;

@property (nonatomic, strong) UIView *perView;
@property (nonatomic, strong) UILabel *perLab;
@property (nonatomic, assign) CGFloat perNum;

@end

NS_ASSUME_NONNULL_END
