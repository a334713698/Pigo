//
//  PGRecycleBinTaskCell.h
//  iOSProjectFramework
//
//  Created by quanmai on 2018/11/15.
//  Copyright © 2018年 洪冬介. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class PGRecycleBinTaskCell;
@protocol PGRecycleBinTaskCellDelegate<NSObject>

- (void)taskCell:(PGRecycleBinTaskCell*)cell restoreButtonDidClick:(UIButton*)btn;

@end


@interface PGRecycleBinTaskCell : UITableViewCell

@property (nonatomic, strong) UIView *contView;
@property (nonatomic, strong) UIImageView *bgImageView;


@property (nonatomic, strong) UILabel *qm_titleLabel;
@property (nonatomic, strong) UILabel *qm_detailLabel;

@property (nonatomic, strong) PGTaskListModel *taskModel;

@property (nonatomic, weak) id<PGRecycleBinTaskCellDelegate> delegate;


- (void)setLabelShadow:(UILabel*)lab content:(NSString*)cont;

@end


NS_ASSUME_NONNULL_END
