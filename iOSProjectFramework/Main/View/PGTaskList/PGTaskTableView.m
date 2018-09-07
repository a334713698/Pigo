//
//  PGTaskTableView.m
//  iOSProjectFramework
//
//  Created by 洪冬介 on 2018/9/7.
//  Copyright © 2018年 洪冬介. All rights reserved.
//

#import "PGTaskTableView.h"

@implementation PGTaskTableView


//iOS11 系统开始，新增了UISwipeActionPullView，位于tableview的子空间，和cell在一个层级
- (void)layoutSubviews{
    [super layoutSubviews];
    
    //iOS11版本以上,自定义删除按钮高度方法:
    if ([CurrentSystemVersion doubleValue] >= 11.0) {
        for (UIView *subview in self.subviews)
        {
            if([subview isKindOfClass:NSClassFromString(@"UISwipeActionPullView")])
            {
                UIView *swipeActionPullView = subview;
                //1.0修改背景颜色
                swipeActionPullView.backgroundColor =  [UIColor clearColor];
                
                //2.0修改按钮-颜色
                UIButton *swipeActionStandardBtn = subview.subviews[0];
                if ([swipeActionStandardBtn isKindOfClass:NSClassFromString(@"UISwipeActionStandardButton")]) {
                    
                    [swipeActionStandardBtn mas_updateConstraints:^(MASConstraintMaker *make) {
                        make.width.mas_equalTo(adaptWidth(35));
                        make.height.mas_equalTo(adaptWidth(35));
                        make.left.mas_equalTo(0);
                        make.centerY.mas_equalTo(0);
                    }];
                    [swipeActionStandardBtn setTitle:nil forState:UIControlStateNormal];
                    [swipeActionStandardBtn setImage:[IMAGE(@"list_deleting") imageForThemeColor:[UIColor redColor]] forState:UIControlStateNormal];
                }
            }
        }
    }
}

@end
