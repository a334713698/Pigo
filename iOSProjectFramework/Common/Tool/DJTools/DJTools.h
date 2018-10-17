//
//  DJTools.h
//  QMMedical
//
//  Created by quanmai on 2018/4/27.
//  Copyright © 2018年 Quanmai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DJTools : NSObject

+ (UIViewController*_Nullable)topViewController;

///快速显示alertVC
+ (void)showAlertWithController:(UIViewController*_Nullable)vc title:(NSString*_Nullable)title message:(NSString*_Nullable)msg cancelHandler:(void (^ __nullable)(UIAlertAction * _Nonnull action))cancelHandler doneHandler:(void (^ __nullable)(UIAlertAction * _Nonnull action))doneHandler;


@end
