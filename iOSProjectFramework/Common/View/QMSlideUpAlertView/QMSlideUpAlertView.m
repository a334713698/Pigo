//
//  QMSlideUpAlertView.m
//  QMMedical
//
//  Created by quanmai on 2018/4/26.
//  Copyright © 2018年 Quanmai. All rights reserved.
//

#import "QMSlideUpAlertView.h"

@interface QMSlideUpAlertView()

@end
static QMSlideUpAlertView *instance = nil;
static UIView *contentView = nil;
@implementation QMSlideUpAlertView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        self.backgroundColor = RGBA(0, 0, 0, 0);
    }
    return self;
}

+ (instancetype)instance {
    if (!instance) {
        instance = [[self alloc] init];
    }
    return instance;
}

+ (void)showAlertWithContentView:(UIView *)insideView withSlideType:(QMAlertSlideUpType)slideType canTouchDissmiss:(BOOL)canTouchDissmiss superView:(UIView *)superView {
    if (!insideView) {
        return;
    }
    QMSlideUpAlertView *alert = [self instance];
    alert.canTouchDissmiss = YES;
    contentView = insideView;
    alert.frame = superView.bounds;
    contentView.frame = CGRectMake((superView.width - insideView.frame.size.width) / 2, superView.bounds.size.height, insideView.frame.size.width, insideView.frame.size.height);
    [alert addSubview:contentView];
    
    if (![superView.subviews containsObject:alert]) {
        [superView addSubview:alert];
    }
    [UIView animateWithDuration:0.3 animations:^{
        alert.backgroundColor = RGBA(0, 0, 0, 0.5);
        CGFloat y = 0;
        if (slideType == QMAlertSlideUpTypeCenter) {
            y = contentView.frame.size.height + (superView.bounds.size.height - contentView.size.height) / 2;
        } else {
            y = contentView.frame.size.height + SAFEAREA_BOTTOM_HEIGHT;
        }
        contentView.transform = CGAffineTransformTranslate(contentView.transform, 0, -y);
    }];
    
    alert.canTouchDissmiss = canTouchDissmiss;
}

+ (void)showAlertWithContentView: (UIView *)insideView withSlideType: (QMAlertSlideUpType)slideType canTouchDissmiss:(BOOL)canTouchDissmiss{
    [self showAlertWithContentView:insideView withSlideType:slideType];
    QMSlideUpAlertView *alert = [self instance];
    alert.canTouchDissmiss = canTouchDissmiss;
}

+ (void)showAlertWithContentView: (UIView *)insideView withSlideType: (QMAlertSlideUpType)slideType {
    if (!insideView) {
        return;
    }
    QMSlideUpAlertView *alert = [self instance];
    alert.canTouchDissmiss = YES;
    contentView = insideView;
    contentView.frame = CGRectMake((SCREEN_WIDTH - insideView.frame.size.width) / 2, SCREEN_HEIGHT, insideView.frame.size.width, insideView.frame.size.height);
    [alert addSubview:contentView];
    
    [[[UIApplication sharedApplication] keyWindow] addSubview:alert];
    [UIView animateWithDuration:0.3 animations:^{
        alert.backgroundColor = RGBA(0, 0, 0, 0.5);
        CGFloat y = 0;
        if (slideType == QMAlertSlideUpTypeCenter) {
            y = contentView.frame.size.height + (SCREEN_HEIGHT - contentView.size.height) / 2 + 20;
        } else {
            y = contentView.frame.size.height + SAFEAREA_BOTTOM_HEIGHT;
        }
        contentView.transform = CGAffineTransformTranslate(contentView.transform, 0, -y);
    }];
}

//无背景
+ (void)showClearBGColorAlertWithContentView: (UIView *)insideView withSlideType: (QMAlertSlideUpType)slideType{
    if (!insideView) {
        return;
    }
    QMSlideUpAlertView *alert = [self instance];
    alert.canTouchDissmiss = YES;
    contentView = insideView;
    contentView.frame = CGRectMake((SCREEN_WIDTH - insideView.frame.size.width) / 2, SCREEN_HEIGHT, insideView.frame.size.width, insideView.frame.size.height);
    [alert addSubview:contentView];
    
    [[[UIApplication sharedApplication] keyWindow] addSubview:alert];
    [UIView animateWithDuration:0.3 animations:^{
        alert.backgroundColor = CLEARCOLOR;
        CGFloat y = 0;
        if (slideType == QMAlertSlideUpTypeCenter) {
            y = contentView.frame.size.height + (SCREEN_HEIGHT - contentView.size.height) / 2 + 20;
        } else {
            y = contentView.frame.size.height + SAFEAREA_BOTTOM_HEIGHT;
        }
        contentView.transform = CGAffineTransformTranslate(contentView.transform, 0, -y);
    }];
}

+ (void)dismiss {
    [UIView animateWithDuration:0.2 animations:^{
        contentView.transform = CGAffineTransformIdentity;
        instance.backgroundColor = RGBA(0, 0, 0, 0);
    } completion:^(BOOL finished) {
        [instance removeFromSuperview];
        instance = nil;
    }];
}

+ (void)dismissWithCompletion:(void (^ __nullable)(BOOL finished))completion{
    [UIView animateWithDuration:0.2 animations:^{
        contentView.transform = CGAffineTransformIdentity;
        instance.backgroundColor = RGBA(0, 0, 0, 0);
    } completion:^(BOOL finished) {
        [instance removeFromSuperview];
        instance = nil;
        completion(finished);
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (!_canTouchDissmiss) {
        return;
    }
    CGPoint point = [[touches anyObject] locationInView:self];
    point = [contentView.layer convertPoint:point fromLayer:instance.layer];
    if ([contentView.layer containsPoint:point]) {
        return;
    }
    [QMSlideUpAlertView dismiss];
}
@end
