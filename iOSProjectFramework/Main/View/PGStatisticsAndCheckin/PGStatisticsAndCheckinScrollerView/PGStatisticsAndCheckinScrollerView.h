//
//  PGStatisticsAndCheckinScrollerView.h
//  iOSProjectFramework
//
//  Created by 洪冬介 on 2018/10/15.
//  Copyright © 2018 洪冬介. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class PGStatisticsAndCheckinScrollerView;

@protocol PGStatisticsAndCheckinScrollerViewDelegate <NSObject>

- (void)scrollerView:(PGStatisticsAndCheckinScrollerView*)scrollerView currentPage:(NSInteger)pageIndex;

@end

@interface PGStatisticsAndCheckinScrollerView : UIScrollView

@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, strong) NSArray *subviews;
@property (nonatomic, weak) id<PGStatisticsAndCheckinScrollerViewDelegate> scrollerViewPageDelegate;

- (void)setPageIndex:(NSInteger)pageIndex animated:(BOOL)animated;
- (instancetype)initWithFrame:(CGRect)frame andSubviews:(NSArray*)subviews;

@end
NS_ASSUME_NONNULL_END
