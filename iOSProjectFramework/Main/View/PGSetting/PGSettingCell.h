//
//  PGSettingCell.h
//  iOSProjectFramework
//
//  Created by 洪冬介 on 2018/9/13.
//  Copyright © 2018年 洪冬介. All rights reserved.
//

#import "PGSettingDataModel.h"

@class PGSettingCell;
@protocol PGSettingCellDelegate<NSObject>

- (void)pg_cell:(PGSettingCell*)cell switchValueDidChange:(UISwitch*)switcher;

@end


@interface PGSettingCell : UITableViewCell

@property (nonatomic, strong) UIView *contView;
@property (nonatomic, strong) UIView *moreView;

@property (nonatomic, strong) NSArray *pickArr;

@property (nonatomic, strong) UIImageView *qm_accessoryImageview;

@property (nonatomic, strong) UILabel *qm_titleLabel;
@property (nonatomic, strong) UILabel *qm_detailLabel;
@property (nonatomic, strong) UISwitch *qm_switcher;

@property (nonatomic, assign) PGSettingContentType contentType;
@property (nonatomic, copy) NSString *paraName;

@property (nonatomic, strong) NSDictionary *cellDic;


@property (nonatomic, weak) id<PGSettingCellDelegate> delegate;

- (void)setupSwitchEvent;

- (void)showMoreView;
- (void)dismissMoreView;

@end
