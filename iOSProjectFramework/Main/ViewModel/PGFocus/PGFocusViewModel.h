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

typedef void(^UpdateTomatoCount)(void);

@interface PGFocusViewModel : BaseViewModel

@property (nonatomic, assign) PGFocusState currentFocusState;

@property (nonatomic, weak) PGCountdownLabel *cdLabel;

@property (nonatomic, weak) PGFocusButton *leftButton;
@property (nonatomic, weak) PGFocusButton *centerButton;
@property (nonatomic, weak) PGFocusButton *rightButton;

@property (nonatomic, copy) UpdateTomatoCount updateCount;

@property (nonatomic, assign) NSTimeInterval endTimeStamp;

//- (void)setCurrentFocusState:(PGFocusState)currentFocusState timeLabel:(UILabel*)timeLabel leftButton:(PGFocusButton*)leftButton centerButton:(PGFocusButton*)centerButton rightButton:(PGFocusButton*)rightButton;

@end
