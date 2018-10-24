//
//  QMSlideUpAlertView.h
//  QMMedical
//
//  Created by quanmai on 2018/4/26.
//  Copyright © 2018年 Quanmai. All rights reserved.
//

#import "BaseView.h"

typedef enum {
    QMAlertSlideUpTypeCenter,//上升至中央
    QMAlertSlideUpTypeBottom,//上升至下方
}QMAlertSlideUpType;

@interface QMSlideUpAlertView : BaseView

@property (nonatomic, assign) BOOL canTouchDissmiss;

//传入需要显示的View,制定insideView大小
+ (void)showAlertWithContentView: (UIView *)insideView withSlideType: (QMAlertSlideUpType)slideType;
//无背景
+ (void)showClearBGColorAlertWithContentView: (UIView *)insideView withSlideType: (QMAlertSlideUpType)slideType;
+ (void)showAlertWithContentView: (UIView *)insideView withSlideType: (QMAlertSlideUpType)slideType canTouchDissmiss:(BOOL)canTouchDissmiss;
+ (void)showAlertWithContentView: (UIView *)insideView withSlideType: (QMAlertSlideUpType)slideType canTouchDissmiss:(BOOL)canTouchDissmiss superView:(UIView *)superView;

+ (void)dismiss;
+ (void)dismissWithCompletion:(void (^ __nullable)(BOOL finished))completion;

@end
