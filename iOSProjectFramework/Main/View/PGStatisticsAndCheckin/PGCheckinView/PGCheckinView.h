//
//  PGCheckinView.h
//  iOSProjectFramework
//
//  Created by 洪冬介 on 2018/10/15.
//  Copyright © 2018 洪冬介. All rights reserved.
//

#import "BaseView.h"



NS_ASSUME_NONNULL_BEGIN

@interface PGCheckinView : BaseView

@property (nonatomic, strong) UILabel *joinDaysLab;//加入天数
@property (nonatomic, strong) UILabel *completedDaysLab;//完成天数
@property (nonatomic, strong) UILabel *continuousDaysLab;//连续天数
@property (nonatomic, strong) UILabel *highestDaysLab;//历史最高

@property (nonatomic, strong) UIButton *checkinButton;

@end

NS_ASSUME_NONNULL_END
