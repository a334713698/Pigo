//
//  HDJDSQLSearchModel.h
//  Accounting
//
//  Created by 洪冬介 on 2018/1/5.
//  Copyright © 2018年 hongdongjie. All rights reserved.
//

#import "BaseModel.h"

@interface HDJDSQLSearchModel : BaseModel


///属性名
@property (nonatomic, copy) NSString *attriName;

///符号
@property (nonatomic, copy) NSString *symbol;

///值
@property (nonatomic, copy) NSString *specificValue;


+ (instancetype)createSQLSearchModelWithAttriName:(NSString*)attriName andSymbol:(NSString*)symbol andSpecificValue:(NSString*)specificValue;

@end
