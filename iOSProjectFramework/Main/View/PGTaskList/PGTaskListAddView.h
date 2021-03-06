//
//  PGTaskListAddView.h
//  iOSProjectFramework
//
//  Created by quanmai on 2018/10/24.
//  Copyright © 2018年 洪冬介. All rights reserved.
//

#import "BaseView.h"

@class PGTaskListAddView;
@protocol PGTaskListAddViewDelegate<NSObject>

- (void)addView:(PGTaskListAddView *)addView closeButtonDidClick:(UIButton*)sender;
- (void)addView:(PGTaskListAddView *)addView sureButtonDidClick:(UIButton*)sender;

@end


NS_ASSUME_NONNULL_BEGIN

@interface PGTaskListAddView : BaseView

@property (nonatomic, copy) NSString *hexStr;
@property (nonatomic, copy) NSString *titleCont;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, assign) NSInteger colorIndex;
@property (nonatomic, strong) NSArray *colorArr;
@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, weak) id<PGTaskListAddViewDelegate> delegate;

- (void)clearTextField;

@end

NS_ASSUME_NONNULL_END
