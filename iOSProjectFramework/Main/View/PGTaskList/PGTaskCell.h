//
//  PGTaskCell.h
//  iOSProjectFramework
//
//  Created by 洪冬介 on 2018/9/6.
//  Copyright © 2018年 洪冬介. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PGTaskCell;
@protocol PGTaskCellDelegate<NSObject>

- (void)taskCell:(PGTaskCell*)cell playButtonDidClick:(UIButton*)btn;

@end


@interface PGTaskCell : UITableViewCell

@property (nonatomic, strong) UIView *contView;
@property (nonatomic, strong) UIImageView *bgImageView;

@property (nonatomic, strong) UILabel *qm_titleLabel;
@property (nonatomic, strong) UILabel *qm_detailLabel;

@property (nonatomic, strong) PGTaskListModel *taskModel;

@property (nonatomic, weak) id<PGTaskCellDelegate> delegate;


- (void)setLabelShadow:(UILabel*)lab content:(NSString*)cont;

@end
