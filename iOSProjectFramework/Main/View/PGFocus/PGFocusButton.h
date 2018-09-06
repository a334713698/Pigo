//
//  PGFocusButton.h
//  iOSProjectFramework
//
//  Created by 洪冬介 on 2018/9/6.
//  Copyright © 2018年 洪冬介. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PGFocusButton : UIButton

@property (nonatomic, copy) NSString *pg_title;

@property (nonatomic, assign) PGFocusState pg_state;


@end
