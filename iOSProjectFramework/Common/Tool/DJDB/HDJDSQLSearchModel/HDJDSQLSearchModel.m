//
//  HDJDSQLSearchModel.m
//  Accounting
//
//  Created by 洪冬介 on 2018/1/5.
//  Copyright © 2018年 hongdongjie. All rights reserved.
//

#import "HDJDSQLSearchModel.h"

@implementation HDJDSQLSearchModel

+ (instancetype)createSQLSearchModelWithAttriName:(NSString*)attriName andSymbol:(NSString*)symbol andSpecificValue:(NSString*)specificValue{
    HDJDSQLSearchModel* model = [HDJDSQLSearchModel new];
    model.attriName = attriName;
    model.symbol = symbol;
    model.specificValue = [NSString stringWithFormat:@"%@",specificValue];
    return model;
}
@end
