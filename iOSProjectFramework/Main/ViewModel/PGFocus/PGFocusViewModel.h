//
//  PGFocusViewModel.h
//  iOSProjectFramework
//
//  Created by 洪冬介 on 2018/9/12.
//  Copyright © 2018年 洪冬介. All rights reserved.
//

#import "BaseViewModel.h"
#import "PGFocusButton.h"
#import "PGCountdownLabel.h"

typedef enum : NSUInteger {
    PGFocusStateWillFocus,//准备专注
    PGFocusStateFocusing,//专注中
    PGFocusStateWillShortBreak,//准备短时休息
    PGFocusStateShortBreaking,//短时休息中
    PGFocusStateWillLongBreak,//准备长时休息
    PGFocusStateLongBreaking,//长时休息中
} PGFocusState;

@interface PGFocusViewModel : BaseViewModel

@property (nonatomic, assign) PGFocusState currentFocusState;

@property (nonatomic, strong) PGCountdownLabel *cdLabel;

@property (nonatomic, strong) PGFocusButton *leftButton;
@property (nonatomic, strong) PGFocusButton *centerButton;
@property (nonatomic, strong) PGFocusButton *rightButton;


//- (void)setCurrentFocusState:(PGFocusState)currentFocusState timeLabel:(UILabel*)timeLabel leftButton:(PGFocusButton*)leftButton centerButton:(PGFocusButton*)centerButton rightButton:(PGFocusButton*)rightButton;

@end
