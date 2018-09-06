//
//  PGTaskCell.h
//  iOSProjectFramework
//
//  Created by 洪冬介 on 2018/9/6.
//  Copyright © 2018年 洪冬介. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PGTaskCell : UITableViewCell

@property (nonatomic, strong) UIView *contView;
@property (nonatomic, strong) UIImageView *bgImageView;

@property (nonatomic, strong) UILabel *qm_titleLabel;
@property (nonatomic, strong) UILabel *qm_detailLabel;

- (void)setLabelShadow:(UILabel*)lab content:(NSString*)cont;

@end
