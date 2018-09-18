//
//  PGTaskListCell.h
//  pigoWatchOS Extension
//
//  Created by 洪冬介 on 2018/9/17.
//  Copyright © 2018年 洪冬介. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WatchKit/WatchKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PGTaskListCell : NSObject

@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *itemLabel;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *countLabel;

@end

NS_ASSUME_NONNULL_END
