//
//  PGSettingTableViewModel.m
//  iOSProjectFramework
//
//  Created by 洪冬介 on 2018/9/11.
//  Copyright © 2018年 洪冬介. All rights reserved.
//

#import "PGSettingTableViewModel.h"

@interface PGSettingTableViewModel()

@property (nonatomic, strong) NSArray *cellData;


@end

@implementation PGSettingTableViewModel

- (NSArray *)cellData{
    if (!_cellData) {
        _cellData = [PGSettingViewModel gettingCellData];
    }
    return _cellData;
}

- (void)handleWithTable:(UITableView *)table {
    table.delegate = self;
    table.dataSource = self;
    table.showsVerticalScrollIndicator = NO;
    table.rowHeight = adaptWidth(40);
    table.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0.01, adaptHeight(10))];
    if ([CurrentSystemVersion doubleValue] > 11.0) {
        table.estimatedSectionHeaderHeight = 10;
        table.estimatedSectionFooterHeight = 0.01;
    }
    [table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.cellData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSDictionary* sectionDic = self.cellData[section];
    NSArray* arr = sectionDic[@"data"];
    return arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary* sectionDic = self.cellData[indexPath.section];
    NSArray* arr = sectionDic[@"data"];
    NSDictionary* cellDic = arr[indexPath.row];
    
    PGSettingEventType eventType = [cellDic[@"eventType"] integerValue];
    PGSettingContentType contentType = [cellDic[@"contentType"] integerValue];

    QMTableViewCell* cell = [[QMTableViewCell alloc] initWithQMStyle:QMTableViewCellStyleDefault reuseIdentifier:nil];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if ((eventType & PGSettingEventTypeDetail) == PGSettingEventTypeDetail) {
        [cell.qm_detailLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(0);
            make.centerY.mas_equalTo(0);
            make.width.mas_lessThanOrEqualTo(SCREEN_WIDTH / 2);
        }];
        cell.qm_detailLabel.text = @"detail";
    }
    if ((eventType & PGSettingEventTypeSwicher) == PGSettingEventTypeSwicher){
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.accessoryView = cell.qm_switcher;
    }
    cell.qm_titleLabel.text = cellDic[@"title"];

    
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DLog(@"cell：%ld-%ld",indexPath.section,indexPath.row);
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    NSDictionary* sectionDic = self.cellData[section];
    NSString* sectionTitle = sectionDic[@"sectionTitle"];
    if (NULLString(sectionTitle)) {
        return PGTableViewHeaderSectionHeight;
    }else{
        return PGTableViewHeaderSectionHeight * 3;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSDictionary* sectionDic = self.cellData[section];
    NSString* sectionTitle = sectionDic[@"sectionTitle"];

    return sectionTitle;
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

@end