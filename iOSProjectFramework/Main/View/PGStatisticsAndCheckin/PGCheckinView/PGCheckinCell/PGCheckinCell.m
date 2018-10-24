//
//  PGCheckinCell.m
//  iOSProjectFramework
//
//  Created by 洪冬介 on 2018/10/16.
//  Copyright © 2018 洪冬介. All rights reserved.
//

#import "PGCheckinCell.h"
#import "CalendarItemView.h"

@interface PGCheckinCell()

@property (nonatomic, strong) NSMutableArray* itemsArr;

@end

@implementation PGCheckinCell

- (NSMutableArray *)itemsArr{
    if (!_itemsArr) {
        _itemsArr = [NSMutableArray array];
    }
    return _itemsArr;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setDate:(NSDate *)date{
    _date = date;
    [self initCalendarContentView];
}

- (void)initCalendarContentView{
    
    NSDate* date = _date;
    
    //1.本月第一天星期几
    NSInteger firstWeekdayInMonth = [PGCheckinCell firstWeekdayInThisMonth:date];
    
    //2.本月一共有几天
    NSInteger totaldaysInMonth = [PGCheckinCell totaldaysInThisMonth:date];
    
    NSInteger weekDayIndex = firstWeekdayInMonth;
    NSInteger colIndex = 0;
    NSInteger dateIndex = 1;
    
    NSString* todayDateYearMonthStr = [NSDate dateToCustomFormateString:@"yyyyMM" andDate:[NSDate new]];
    NSString* cellDateYearMonthStr = [NSDate dateToCustomFormateString:@"yyyyMM" andDate:date];
    NSInteger todayDayIndex = [[NSDate dateToCustomFormateString:@"dd" andDate:[NSDate new]] integerValue];
    for (NSInteger i = firstWeekdayInMonth; i < totaldaysInMonth + firstWeekdayInMonth; i++) {
        CGFloat w = (SCREEN_WIDTH - 2 * 20) / DayCountOfWeek;
        CGFloat h = CalendarView_Content_Item_Height;
        CGFloat x = w * weekDayIndex;
        CGFloat y = h * colIndex;
        
        NSString* dateYMDStr = [cellDateYearMonthStr stringByAppendingFormat:@"%02ld",dateIndex];
        CalendarItemView *calendarItem = [[CalendarItemView alloc] initWithFrame:CGRectMake(x, y, w, h)];
        calendarItem.itemButton.tag = dateIndex;
        [self addSubview:calendarItem];
        [self.itemsArr addObject:calendarItem];
        [calendarItem.itemButton setTitle:[NSString stringWithFormat:@"%ld",dateIndex] forState:UIControlStateNormal];
        [calendarItem.itemButton addTarget:self action:@selector(calendarItemClick:) forControlEvents:UIControlEventTouchUpInside];
        calendarItem.itemButton.selected = NO;

        if (QMEqualToString(todayDateYearMonthStr, cellDateYearMonthStr) && dateIndex > todayDayIndex) {
            calendarItem.itemButton.enabled = NO;
        }else if ([self.checkinRecordArr containsObject:dateYMDStr]){
            calendarItem.itemButton.selected = YES;
        }
        dateIndex++;
        weekDayIndex++;
        if (weekDayIndex == 7) {
            weekDayIndex = 0;
            colIndex++;
        }
    }
}

//1.本月第一天星期几
+ (NSInteger)firstWeekdayInThisMonth:(NSDate *)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setFirstWeekday:1];//1.Sun. 2.Mon. 3.Thes. 4.Wed. 5.Thur. 6.Fri. 7.Sat.
    NSDateComponents *comp = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    [comp setDay:1];
    NSDate *firstDayOfMonthDate = [calendar dateFromComponents:comp];
    
    NSUInteger firstWeekday = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:firstDayOfMonthDate];
    return firstWeekday - 1;
}

//2.本月一个有几天
+ (NSInteger)totaldaysInThisMonth:(NSDate *)date{
    NSRange totaldaysInMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return totaldaysInMonth.length;
}

//3.本月日期所需要占用的行数
+ (NSInteger)totalRowsInThisMonth:(NSDate *)date{
    NSInteger firstWeekdayInMonth = [self firstWeekdayInThisMonth:date];
    NSInteger totaldaysInMonth = [self totaldaysInThisMonth:date];
    NSInteger row = 1;
    NSInteger leftDays = totaldaysInMonth - (7 - firstWeekdayInMonth);
    row += (leftDays / 7);
    row += (leftDays % 7 ? 1:0);
    return row;
}

+ (NSInteger)getTotalRowsInThisMonth:(NSDate *)date{
    return [self totalRowsInThisMonth:date];
}

- (void)calendarItemClick:(UIButton*)sender{
    DLog(@"%ld",sender.tag);
    NSString* cellDateYearMonthStr = [NSDate dateToCustomFormateString:@"yyyyMM" andDate:_date];
    DLog(@"%@%02ld",cellDateYearMonthStr,sender.tag);
    if (sender.isSelected) {
        return;
    }
    UIAlertController* alertVC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alertVC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"打卡" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [PGUserModelInstance taskCheckinWithID:self.task_id andDateStr:[NSString stringWithFormat:@"%@%02ld",cellDateYearMonthStr,sender.tag] isAuto:NO];
        sender.selected = YES;
    }]];
    
    [TOPVC presentViewController:alertVC animated:YES completion:nil];
}


@end
