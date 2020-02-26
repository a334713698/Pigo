//
//  PGFocusingViewModel.h
//  pigoWatchOS Extension
//
//  Created by 洪冬介 on 2018/9/20.
//  Copyright © 2018年 洪冬介. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WatchKit/WatchKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PGFocusingViewModel : NSObject

@property (nonatomic, assign) PGFocusState currentFocusState;

@property (unsafe_unretained, nonatomic) WKInterfaceLabel *timeLab;

@property (unsafe_unretained, nonatomic) WKInterfaceButton *topBtn;
@property (unsafe_unretained, nonatomic) WKInterfaceButton *bottomBtn;

@property (nonatomic, assign) PGFocusButtonState topBtnState;
@property (nonatomic, assign) PGFocusButtonState bottomBtnState;

@property (nonatomic, assign) NSTimeInterval endTimeStamp;

- (void)topBtnClick;
- (void)bottomBtnClick;
- (void)hanlderButtonClick:(PGFocusButtonState)state;

@end

NS_ASSUME_NONNULL_END
