//
//  PGTaskListCollectionViewCell.h
//  pigoWidget
//
//  Created by quanmai on 2019/1/4.
//  Copyright © 2019 洪冬介. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PGTaskListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PGTaskListCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *titleLab;

@property (nonatomic, strong) PGTaskListModel *taskModel;

@end

NS_ASSUME_NONNULL_END
