//
//  PGCheckinView.m
//  iOSProjectFramework
//
//  Created by 洪冬介 on 2018/10/15.
//  Copyright © 2018 洪冬介. All rights reserved.
//

#import "PGCheckinView.h"
#import "PGCheckinCell.h"

#define increaseNum 6

@interface PGCheckinView()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSDate *date;

@property (nonatomic, strong) NSArray *checkinRecordArr;

@end

@implementation PGCheckinView{
    NSInteger _num;
    CGFloat _lastOffsetY;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [self addSubview:_tableView];
        _tableView.backgroundColor = WHITE_COLOR;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0.01, adaptHeight(10))];
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0.01, adaptHeight(20))];
        if ([[[UIDevice currentDevice] systemVersion] doubleValue] > 11.0) {
            _tableView.estimatedSectionHeaderHeight = 10;
            _tableView.estimatedSectionFooterHeight = 0.01;
        }
    }
    return _tableView;
}

- (NSDate *)date{
    if (!_date) {
        _date = [NSDate new];
    }
    return _date;
}

- (void)dealloc{
    NSLog(@"%@--dealloc", [self class]);
    [NOTI_CENTER removeObserver:self name:PGCheckinCompleteNotification object:nil];
}

- (instancetype)initWithTaskID:(NSInteger)task_id
{
    self = [super init];
    if (self) {
        _num = 1;
        _joinDaysLab = [UILabel new];
        _completedDaysLab = [UILabel new];
        _continuousDaysLab = [UILabel new];
        _highestDaysLab = [UILabel new];
        _task_id = task_id;
        _checkinRecordArr = [PGUserModelInstance getCheckinRecordWithTaskID:_task_id];
        self.backgroundColor = WHITE_COLOR;
        [self setupView];
        [NOTI_CENTER addObserver:self selector:@selector(assignment) name:PGCheckinCompleteNotification object:nil];
    }
    return self;
}

- (void)setupView{
    NSArray<NSString*>* titleArr = @[
        NSLocalizedString(@"Join days",nil),
        NSLocalizedString(@"Complete days", nil),
        NSLocalizedString(@"Consecutive days", nil),
        NSLocalizedString(@"History highest", nil)];
    NSArray<UILabel*>* labArr = @[self.joinDaysLab,self.completedDaysLab,self.continuousDaysLab,self.highestDaysLab];
    

    CGFloat leftMargin = 20;
    CGFloat titleItemWidth = (SCREEN_WIDTH - leftMargin * 2) / titleArr.count;
    for (NSInteger i = 0; i < titleArr.count; i++) {
        UIView* view = [[UIView alloc] initWithFrame:CGRectMake(leftMargin + i * titleItemWidth, 0, titleItemWidth, titleItemWidth)];
        [self addSubview:view];
        UILabel* titleLab = [UILabel createLabelWithFontSize:adaptFont(12) andTextColor:BLACK_COLOR andText:titleArr[i]];
        [view addSubview:titleLab];
        titleLab.numberOfLines = 2;
        titleLab.textAlignment = NSTextAlignmentCenter;
        [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(-adaptWidth(8));
            make.centerX.mas_equalTo(0);
        }];
        
        [view addSubview:labArr[i]];
        labArr[i].textColor = BLACK_COLOR;
        labArr[i].font = [UIFont boldSystemFontOfSize:adaptFont(17)];
        labArr[i].text = @"0";
        [labArr[i] mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(0);
        }];
    }
    
    CGFloat btnH = adaptWidth(40);
    _checkinButton = [UIButton createButtonWithFontSize:adaptFont(16) andTitleColor:MAIN_COLOR andTitle:NSLocalizedString(@"Punch", nil) andBackgroundColor:CLEARCOLOR];
    [self addSubview:_checkinButton];
    [_checkinButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(btnH);
        make.top.mas_equalTo(titleItemWidth + 12);
    }];
    [_checkinButton setTitle:NSLocalizedString(@"Punched", nil) forState:UIControlStateDisabled];
    [_checkinButton setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    [_checkinButton addRoundMaskWithRoundedRect:CGRectMake(0, 0, SCREEN_WIDTH - leftMargin * 2, btnH) CornerRadius:PGCornerRadius andBorderWidth:1 andBorderColor:MAIN_COLOR];
    NSString* todayDateStr = [NSDate dateToCustomFormateString:@"yyyyMMdd" andDate:[NSDate new]];
    if ([self.checkinRecordArr containsObject:todayDateStr]) {
        _checkinButton.enabled = NO;
        CAShapeLayer *borderLayer = _checkinButton.layer.sublayers.firstObject;
        borderLayer.strokeColor = [UIColor grayColor].CGColor;
    }
    [_checkinButton addTarget:self action:@selector(checkin) forControlEvents:UIControlEventTouchUpInside];
    
    CGFloat weekViewH = adaptWidth(35);
    UIView *weekView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, CalendarView_Week_TopView_Height)];
    [self addSubview:weekView];
    [weekView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.checkinButton.mas_bottom).offset(12);
        make.left.mas_equalTo(leftMargin);
        make.right.mas_equalTo(-leftMargin);
        make.height.mas_equalTo(weekViewH);
    }];

    NSArray* dayOfWeekArr = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
    if (!is_zh_Hans){
        dayOfWeekArr = @[@"Sun",@"Mon",@"Tues",@"Wed",@"Thurs",@"Fri",@"Sat"];
    }
    for (int i = 0; i < DayCountOfWeek; i++) {
        CGFloat w = (SCREEN_WIDTH - leftMargin * 2) / DayCountOfWeek;
        CGFloat h = weekViewH;
        CGFloat x = w * i;
        CGFloat y = 0;
        UILabel* weekdayLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
        [weekView addSubview:weekdayLabel];
        weekdayLabel.font = [UIFont systemFontOfSize:adaptFont(13)];
        weekdayLabel.textAlignment = NSTextAlignmentCenter;
        weekdayLabel.textColor = BLACK_COLOR;
        weekdayLabel.text = dayOfWeekArr[i];
    }
    
    UIView *line = [UIView new];
    [weekView addSubview:line];
    line.backgroundColor = LINE_COLOR_GRAY_DARK;
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];

    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weekView.mas_bottom);
        make.left.mas_equalTo(leftMargin);
        make.right.mas_equalTo(-leftMargin);
        make.bottom.mas_equalTo(0);
    }];
    
    [self assignment];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    DLog(@"停止拖拽");
    _lastOffsetY = scrollView.contentOffset.y;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    DLog(@"停止滚动");
    if (_lastOffsetY < 0) {
        _num += increaseNum;
        [self.tableView reloadData];
        [self.tableView layoutIfNeeded];
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:increaseNum] atScrollPosition:UITableViewScrollPositionTop animated:NO];
        _lastOffsetY = 0;
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _num;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PGCheckinCell* cell = [[PGCheckinCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.task_id = self.task_id;
    cell.checkinRecordArr = self.checkinRecordArr;
    cell.date = [NSDate getDateFrom:self.date offsetMonths:-(_num-indexPath.section-1)];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [PGCheckinCell getTotalRowsInThisMonth:[NSDate getDateFrom:self.date offsetMonths:-(_num-indexPath.section-1)]] * CalendarView_Content_Item_Height;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSDate* date = [NSDate getDateFrom:self.date offsetMonths:-(_num-section-1)];
    NSString *format = @"yyyy年MM月";
    if (!is_zh_Hans){
        format = @"yyyy-MM";
    }
    return [NSDate dateToCustomFormateString:format andDate:date];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return adaptHeight(24);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

- (void)checkin{
    DLog(@"今日打卡");
    _checkinButton.enabled = NO;
    CAShapeLayer *borderLayer = _checkinButton.layer.sublayers.firstObject;
    borderLayer.strokeColor = [UIColor grayColor].CGColor;
    NSString* dateStr = [NSDate dateToCustomFormateString:@"yyyyMMdd" andDate:[NSDate new]];
    [PGUserModelInstance taskCheckinWithID:self.task_id andDateStr:dateStr isAuto:YES];
    self.checkinRecordArr = [self.checkinRecordArr arrayByAddingObject:dateStr];
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:_num - 1] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)assignment{

    [PGUserModelInstance.dbMgr.database open];
    
    NSArray<NSDictionary*>* totalCheckinArr = [PGUserModelInstance.dbMgr getAllTuplesFromTabel:check_in_table andSearchModel:[HDJDSQLSearchModel createSQLSearchModelWithAttriName:@"task_id" andSymbol:@"=" andSpecificValue:QMStringFromNSInteger(self.task_id)] withSortedMode:NSOrderedAscending andColumnName:@"add_date"];
    
    if (totalCheckinArr.count < 1) {
        [PGUserModelInstance.dbMgr.database close];
        return;
    }
    //加入天数
    NSDictionary* firstDayDic = totalCheckinArr.firstObject;
    NSInteger days = ceil(([[[NSDate new] dateToTimeStamp] integerValue] - [firstDayDic[@"add_time"] integerValue]) / 86400.0);
    if (days < 1) {
        days = 1;
    }
    self.joinDaysLab.text = [NSString stringWithFormat:@"%ld",days];
    
    //完成天数
    self.completedDaysLab.text = QMStringFromNSInteger(totalCheckinArr.count);
    
    //连续天数
    //历史最高
    NSMutableArray* continuousArr = @[@1].mutableCopy;
    for (NSInteger i = totalCheckinArr.count - 1; i > 0; i--) {
        NSDate* nowDate = [NSDate timeStampToDateWithTimeStamp:totalCheckinArr[i][@"add_time"]];
        NSDate* nowLastDate = [NSDate getDateFrom:nowDate offsetDays:-1];
        NSDate* lastDate = [NSDate timeStampToDateWithTimeStamp:totalCheckinArr[i-1][@"add_time"]];
        
        NSString* nowLastStr = [NSDate dateToCustomFormateString:@"yyyyMMdd" andDate:nowLastDate];
        NSString* lastStr = [NSDate dateToCustomFormateString:@"yyyyMMdd" andDate:lastDate];
        if (!QMEqualToString(nowLastStr, lastStr)) {
            [continuousArr addObject:@1];
        }else{
            NSInteger t = [continuousArr.lastObject integerValue];
            t++;
            [continuousArr removeLastObject];
            [continuousArr addObject:@(t)];
        }
    }

    self.continuousDaysLab.text = QMStringFromNSValue(continuousArr.firstObject);
    
    [continuousArr sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        if ([obj1 integerValue] > [obj2 integerValue]) {
            return NSOrderedAscending;
        }else if ([obj1 integerValue] < [obj2 integerValue]){
            return NSOrderedDescending;
        }else{
            return NSOrderedSame;
        }
    }];
    
    self.highestDaysLab.text = QMStringFromNSValue(continuousArr.firstObject);
    [PGUserModelInstance.dbMgr.database close];
}

@end
