//
//  PGConst.h
//  PGMedical
//
//  Created by 洪冬介 on 2018/3/26.
//  Copyright © 2018年 Quanmai. All rights reserved.
//

#ifndef PGConst_h
#define PGConst_h



//block
typedef void (^HDJCompletionHandler)(id resultObject, NSError *error);
typedef void (^DidSelectItemBlock)(NSIndexPath*,id);
typedef void (^PicChooseCallbackBlock)(NSArray<UIImage*>* imageArr,NSArray<NSString*>* urlArr);
typedef void (^DataCallbackBlock)(id result);

// 常量

//Common
UIKIT_EXTERN const CGFloat PGCornerRadius;
UIKIT_EXTERN const CGFloat PGTableViewRowHeight;


//PGFocusViewController
UIKIT_EXTERN const CGFloat PGFocusBtnWidth;
UIKIT_EXTERN const CGFloat PGFocusBtnHeight;

//PGTaskCell
UIKIT_EXTERN const CGFloat PGTaskCellHeight;



//UIKIT_EXTERN NSString *const PGShortcutTypeExam;

#endif /* PGConst_h */
