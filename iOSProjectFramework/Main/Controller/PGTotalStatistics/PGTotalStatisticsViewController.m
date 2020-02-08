//
//  PGTotalStatisticsViewController.m
//  iOSProjectFramework
//
//  Created by quanmai on 2018/10/25.
//  Copyright © 2018年 洪冬介. All rights reserved.
//

#import "PGTotalStatisticsViewController.h"
#import "PGTotalStatisticsChartCell.h"
#import "PGStatisticsTodayDataCell.h"
#import "PGStatisticsTodayPeriodCell.h"
#import "PGTotalStatisticsViewModel.h"
#import "PGStatisticsChartCell.h"
#import "PGTotalStatisticsTaskItemCell.h"

@interface PGTotalStatisticsViewController ()<UITableViewDelegate,UITableViewDataSource,PGStatisticsTodayPeriodCellDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<NSArray*> *cellNames;
@property (nonatomic, strong) NSArray<PGTotalStatisticsItemModel*> *itemsArr;

@end

@implementation PGTotalStatisticsViewController{
    PGStatisticsPeriodType _periodType;
    NSInteger _chartCellSectionIndex;
    NSInteger _pieChartCellSectionIndex;
    BOOL _showHour;
}

#pragma mark - lazy load
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [self.view addSubview:_tableView];
        _tableView.backgroundColor = BACKGROUND_COLOR;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
//        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0.01, 0.01)];
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0.01, adaptHeight(10))];
        if ([[[UIDevice currentDevice] systemVersion] doubleValue] > 11.0) {
            _tableView.estimatedSectionHeaderHeight = 10;
            _tableView.estimatedSectionFooterHeight = 0.01;
        }
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        [_tableView registerClass:[PGTotalStatisticsChartCell class] forCellReuseIdentifier:@"PGTotalStatisticsChartCell"];
        [_tableView registerClass:[PGStatisticsTodayDataCell class] forCellReuseIdentifier:@"PGStatisticsTodayDataCell"];
        [_tableView registerClass:[PGStatisticsTodayPeriodCell class] forCellReuseIdentifier:@"PGStatisticsTodayPeriodCell"];
        [_tableView registerClass:[PGStatisticsChartCell class] forCellReuseIdentifier:@"PGStatisticsChartCell"];
        [_tableView registerClass:[PGTotalStatisticsTaskItemCell class] forCellReuseIdentifier:@"PGTotalStatisticsTaskItemCell"];
        
    }
    return _tableView;
}

- (NSArray<NSArray*> *)cellNames{
    if (!_cellNames) {
        _cellNames = [PGTotalStatisticsViewModel getCellNameArr];
    }
    return _cellNames;
}

- (NSArray<PGTotalStatisticsItemModel*>*)itemsArr{
    if (!_itemsArr) {
        _itemsArr = [PGTotalStatisticsViewModel getItemsArrWithType:PGStatisticsPeriodTypeWeek];
    }
    return _itemsArr;
}

#pragma mark - view func
- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self initNav];

    self.tableView.hidden = NO;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.cellNames.count + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == self.cellNames.count) {
        return self.itemsArr.count;
    }
    return self.cellNames[section].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == self.cellNames.count) {
        PGTotalStatisticsTaskItemCell* cell = [tableView dequeueReusableCellWithIdentifier:@"PGTotalStatisticsTaskItemCell"];
        cell.showHour = _showHour;
        cell.itemModel = self.itemsArr[indexPath.row];
        return cell;
    }
    NSString* cellName = self.cellNames[indexPath.section][indexPath.row];
    if (QMEqualToString(cellName, @"PGStatisticsTodayDataCell")) {
        PGStatisticsTodayDataCell* cell = [tableView dequeueReusableCellWithIdentifier:@"PGStatisticsTodayDataCell"];
        NSInteger ttCount = [self todayDataWithType:PGStatisticsChartDataTypeCount];
        NSInteger ttLength = [self todayDataWithType:PGStatisticsChartDataTypeLength];
        if (ttCount) {
            cell.countLab.text = QMStringFromNSInteger(ttCount);
            NSString* length;
            NSString* unit;
            if (ttLength>=60) {
                length = [NSString stringWithFormat:@"%.1lf",ttLength/60.0];
                unit = NSLocalizedString(@"hour", nil);
            }else{
                length = [NSString stringWithFormat:@"%ld",ttLength];
                unit = NSLocalizedString(@"minutes", nil);
            }
            NSString* text = [length stringByAppendingString:unit];
            [cell.durationLab setLabelText:text Font:[UIFont systemFontOfSize:adaptFont(12)] Range:NSMakeRange(length.length, unit.length)];
        }else{
            cell.countLab.text = @"0";
            cell.durationLab.text = @"0";
        }
        return cell;
    }else if (QMEqualToString(cellName, @"PGStatisticsTodayPeriodCell")) {
        PGStatisticsTodayPeriodCell* cell = [tableView dequeueReusableCellWithIdentifier:@"PGStatisticsTodayPeriodCell"];
        cell.delegate = self;
        return cell;
    }else if(QMEqualToString(cellName, @"PGTotalStatisticsChartCell")){
        _pieChartCellSectionIndex = indexPath.section;
        PGTotalStatisticsChartCell* cell = [tableView dequeueReusableCellWithIdentifier:@"PGTotalStatisticsChartCell"];
        if (self.itemsArr.count) {
            cell.nodataLab.hidden = YES;
            [cell updatePieCharWithPeriodType:_periodType dataType:PGStatisticsChartDataTypeCount];
        }else{
            cell.nodataLab.hidden = NO;
        }
        return cell;
    }else if (QMEqualToString(cellName, @"PGStatisticsChartCell")){
        _chartCellSectionIndex = indexPath.section;
        PGStatisticsChartCell* cell = [tableView dequeueReusableCellWithIdentifier:@"PGStatisticsChartCell"];
        PGStatisticsChartDataType chartDataType = (indexPath.row == 0) ? PGStatisticsChartDataTypeCount:PGStatisticsChartDataTypeLength;
        [cell updateTotalStatistcsCharWithPeriodType:_periodType dataType:chartDataType];
        return cell;
    }
    UITableViewCell* cell = [UITableViewCell new];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DLog(@"cell：%ld-%ld",indexPath.section,indexPath.row);
    if (indexPath.section == self.cellNames.count) {
        _showHour = !_showHour;
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == self.cellNames.count) {
        return adaptWidth(PGTotalStatisticsTaskItemCellHeight);
    }
    
    NSString* cellName = self.cellNames[indexPath.section][indexPath.row];
    if (QMEqualToString(cellName, @"PGStatisticsTodayDataCell")) {
        return adaptWidth(PGStatisticsTodayDataCellHeight);
    }else if (QMEqualToString(cellName, @"PGStatisticsTodayPeriodCell")) {
        return adaptWidth(PGStatisticsTodayPeriodCellHeight);
    }else if(QMEqualToString(cellName, @"PGTotalStatisticsChartCell")){
        return adaptWidth(PGTotalStatisticsChartCellHeight);
    }else if (QMEqualToString(cellName, @"PGStatisticsChartCell")){
        return adaptWidth(PGStatisticsChartCellHeight);
    }

    return adaptHeight(44);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return adaptHeight(12);
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

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == self.cellNames.count) {
        cell.separatorInset = UIEdgeInsetsZero;
        cell.layoutMargins = UIEdgeInsetsZero;
    }else{
        cell.separatorInset = UIEdgeInsetsMake(0, SCREEN_WIDTH/2.0, 0, SCREEN_WIDTH/2.0);
        cell.layoutMargins = UIEdgeInsetsMake(0, SCREEN_WIDTH/2.0, 0, SCREEN_WIDTH/2.0);
    }
    cell.preservesSuperviewLayoutMargins = NO;
}

#pragma mark - PGStatisticsTodayPeriodCellDelegate
- (void)periodCell:(PGStatisticsTodayPeriodCell*)cell andType:(PGStatisticsPeriodType)type{
    _periodType = type;
    PGStatisticsChartCell* countCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:_chartCellSectionIndex]];
    PGStatisticsChartCell* durationCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:_chartCellSectionIndex]];
    [countCell updateTotalStatistcsCharWithPeriodType:_periodType dataType:PGStatisticsChartDataTypeCount];
    [durationCell updateTotalStatistcsCharWithPeriodType:_periodType dataType:PGStatisticsChartDataTypeLength];
    
    PGTotalStatisticsChartCell* pieChartCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:_pieChartCellSectionIndex]];
    [pieChartCell updatePieCharWithPeriodType:_periodType dataType:PGStatisticsChartDataTypeLength];

    
    _itemsArr = [PGTotalStatisticsViewModel getItemsArrWithType:_periodType];
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:(_pieChartCellSectionIndex+1)] withRowAnimation:UITableViewRowAnimationFade];
}

#pragma mark - SEL


#pragma mark - Method
- (void)initNav{
    self.navTitle = NSLocalizedString(@"Statistics", nil);
    
}

- (NSInteger)todayDataWithType:(PGStatisticsChartDataType)type{
    [self.dbMgr.database open];
    
    NSInteger t = [self.dbMgr sumFromTabel:tomato_record_table andColumnName:((type==PGStatisticsChartDataTypeCount)?@"count":@"length") andSearchModel:[HDJDSQLSearchModel createSQLSearchModelWithAttriName:@"add_date" andSymbol:@"=" andSpecificValue:TextFromNSString([NSDate getTodayDateStr])]];
    
    [self.dbMgr.database close];
    return t;
}


#pragma mark - NetRequest



@end
