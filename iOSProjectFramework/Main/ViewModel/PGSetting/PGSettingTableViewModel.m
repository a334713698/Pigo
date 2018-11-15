//
//  PGSettingTableViewModel.m
//  iOSProjectFramework
//
//  Created by 洪冬介 on 2018/9/11.
//  Copyright © 2018年 洪冬介. All rights reserved.
//

#import "PGSettingTableViewModel.h"
#import "PGSettingCell.h"

@interface PGSettingTableViewModel()<PGSettingCellDelegate>

@property (nonatomic, strong) NSArray *cellData;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign, getter=isCellSelected) BOOL cellSelected;

@end

@implementation PGSettingTableViewModel{
    NSIndexPath* _selectIndexPath;
}

- (NSArray *)cellData{
    if (!_cellData) {
        _cellData = [PGSettingViewModel gettingCellData];
    }
    return _cellData;
}

- (void)handleWithTable:(UITableView *)table {
    self.cellSelected = NO;
    self.tableView = table;
    table.delegate = self;
    table.dataSource = self;
    table.showsVerticalScrollIndicator = NO;
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
    NSString *paraName = cellDic[@"paraName"];

    PGSettingCell* cell = [[PGSettingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.cellDic = cellDic;
    cell.contentType = contentType;
    cell.delegate = self;
    cell.paraName = paraName;
    cell.qm_titleLabel.text = cellDic[@"title"];

    if ((eventType & PGSettingEventTypeDetail) == PGSettingEventTypeDetail) {
        cell.qm_accessoryImageview.hidden = NO;
        NSString* unit = cellDic[@"unit"] ? :@"";
        cell.qm_detailLabel.text = [NSString stringWithFormat:@"%@%@",[PGConfigMgr valueForKey:paraName],unit];
        
        if (indexPath.section == _selectIndexPath.section && indexPath.row == _selectIndexPath.row) {
            NSArray* pickArr = cellDic[@"pickArr"];
            cell.pickArr = pickArr;
            [cell showMoreView];
        }else{
            [cell dismissMoreView];
        }
    }
    
    if ((eventType & PGSettingEventTypeClick) == PGSettingEventTypeClick) {
        [cell.qm_detailLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-(20 + PGSettingCellAccessoryWidth + 8));
        }];
        cell.qm_accessoryImageview.hidden = NO;
    }
    
    if ((eventType & PGSettingEventTypeSwicher) == PGSettingEventTypeSwicher){
        [cell setupSwitchEvent];
        cell.qm_switcher.on = [cellDic[@"detail"] boolValue];
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DLog(@"cell：%ld-%ld",indexPath.section,indexPath.row);
    NSDictionary* sectionDic = self.cellData[indexPath.section];
    NSArray* arr = sectionDic[@"data"];
    NSDictionary* cellDic = arr[indexPath.row];
    PGSettingEventType eventType = [cellDic[@"eventType"] integerValue];
    PGSettingContentType contentType = [cellDic[@"contentType"] integerValue];
    
    if (contentType == PGSettingContentTypeDataSync) {
        [self DataSync];
    }else if (contentType == PGSettingContentTypeStatistics || contentType == PGSettingContentTypeRecycleBin){
        if (self.didSelectItemBlock) {
            self.didSelectItemBlock(indexPath, cellDic);
        }
    }else if ((eventType & PGSettingEventTypeClick) == PGSettingEventTypeClick){
        NSMutableArray<NSIndexPath*>* indexArr = [NSMutableArray arrayWithCapacity:2];
        [indexArr addObject:indexPath];
        if (self.isCellSelected) {
            if (indexPath == _selectIndexPath) {
                self.cellSelected = NO;
                _selectIndexPath = nil;
            }else{
                self.cellSelected = YES;
                [indexArr addObject:_selectIndexPath];
                _selectIndexPath = indexPath;
            }
        }else{
            self.cellSelected = YES;
            _selectIndexPath = indexPath;
        }
        [self.tableView reloadRowsAtIndexPaths:indexArr withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_selectIndexPath && self.isCellSelected && indexPath.section == _selectIndexPath.section && indexPath.row == _selectIndexPath.row) {
        return adaptWidth(PGSettingCellMoreHeight) + adaptWidth(PGSettingCellContentHeight);
    }
    return adaptWidth(PGSettingCellContentHeight);
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

#pragma mark - PGSettingCellDelegate
- (void)pg_cell:(PGSettingCell*)cell switchValueDidChange:(UISwitch*)switcher{
    DLog(@"%@",switcher.on?@"开":@"关");
    [PGConfigMgr setValue:@(switcher.on) forKey:cell.paraName];
}


#pragma mark - Method
- (void)DataSync{
    [PGSettingViewModel watch_updateSettingConfig];
}
@end
