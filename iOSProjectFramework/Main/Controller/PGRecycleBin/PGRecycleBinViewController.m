//
//  PGRecycleBinViewController.m
//  iOSProjectFramework
//
//  Created by quanmai on 2018/11/15.
//  Copyright © 2018年 洪冬介. All rights reserved.
//

#import "PGRecycleBinViewController.h"
#import "PGRecycleBinTaskCell.h"

@interface PGRecycleBinViewController ()<UITableViewDelegate,UITableViewDataSource,PGRecycleBinTaskCellDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray<PGTaskListModel*> *taskList;

@end

@implementation PGRecycleBinViewController

#pragma mark - lazy load
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [self.view addSubview:_tableView];
        _tableView.backgroundColor = BACKGROUND_COLOR;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.allowsSelection = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.rowHeight = adaptWidth(PGRecycleBinTaskCellHeight);
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0.01, 0.01)];
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0.01, adaptHeight(10))];
        if ([[[UIDevice currentDevice] systemVersion] doubleValue] > 11.0) {
            _tableView.estimatedSectionHeaderHeight = 10;
            _tableView.estimatedSectionFooterHeight = 0.01;
        }
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
    }
    return _tableView;
}

- (NSMutableArray<PGTaskListModel*> *)taskList{
    if (!_taskList) {
        _taskList = [NSMutableArray array];
        [self.dbMgr.database open];
        NSArray* taskArr = [self.dbMgr getAllTuplesFromTabel:task_list_table andSearchModel:[HDJDSQLSearchModel createSQLSearchModelWithAttriName:@"is_delete" andSymbol:@"=" andSpecificValue:@"1"] withSortedMode:NSOrderedDescending andColumnName:@"delete_time"];
        if (taskArr.count) {
            [_taskList addObjectsFromArray:[PGTaskListModel mj_objectArrayWithKeyValuesArray:taskArr]];
        }
        [self.dbMgr.database close];
    }
    return _taskList;
}


#pragma mark - view func
- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.tableView.hidden = NO;
    [self initNav];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.taskList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PGTaskListModel* task = self.taskList[indexPath.section];
    
    PGRecycleBinTaskCell* cell = [tableView dequeueReusableCellWithIdentifier:@"PGRecycleBinTaskCell"];
    if (!cell) {
        cell = [[PGRecycleBinTaskCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PGRecycleBinTaskCell"];
        cell.delegate = self;
    }
    cell.contView.backgroundColor = [UIColor colorWithHexStr:task.bg_color];
    [cell setLabelShadow:cell.qm_titleLabel content:task.task_name];
    [cell setLabelShadow:cell.qm_detailLabel content:[NSString stringWithFormat:@"%@ %@",[NSDate dateToCustomFormateString:@"yyyy-MM-dd hh:mm:ss" andTimeStamp:@(task.delete_time)],NSLocalizedString(@"Delete on", nil)]];
    cell.taskModel = task;
    return cell;
}

#pragma mark - UITableViewDelegate
- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PGTaskListModel* task = self.taskList[indexPath.section];
    
    WS(weakSelf)
    
    UITableViewRowAction *abandonAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:NSLocalizedString(@"Destroy", nil) handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        UIAlertController* alertVC = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Tips", nil) message:[NSString stringWithFormat:@"%@？",NSLocalizedString(@"Destroy Tips", nil)] preferredStyle:UIAlertControllerStyleAlert];
        
        [alertVC addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Destroy Action", nil) style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [weakSelf removeAndReloadWithIndexPath:indexPath];
            [weakSelf abandonTask:task];
        }]];
        [alertVC addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Shaking hands", nil) style:UIAlertActionStyleDefault handler:nil]];
        [weakSelf presentViewController:alertVC animated:YES completion:nil];
    }];
    abandonAction.backgroundColor = [UIColor redColor];
    return @[abandonAction];
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

#pragma mark - PGRecycleBinTaskCellDelegate
- (void)taskCell:(PGRecycleBinTaskCell*)cell restoreButtonDidClick:(UIButton*)btn{
    NSIndexPath* indexPath = [self.tableView indexPathForCell:cell];
    [self removeAndReloadWithIndexPath:indexPath];
    [self restoreAction:cell.taskModel];
}

#pragma mark - SEL


#pragma mark - Method
- (void)initNav{
    self.navTitle = NSLocalizedString(@"Pigo Recycle Bin", nil);
}

- (void)removeAndReloadWithIndexPath:(NSIndexPath*)indexPath{
    [self.taskList removeObjectAtIndex:indexPath.section];
    [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
}


- (void)restoreAction:(PGTaskListModel*)task{
    [self delTask:task withDelTag:0];
    [NOTI_CENTER postNotificationName:PGListUpdatesNotification object:nil];
}

- (void)abandonTask:(PGTaskListModel*)task{
    [self delTask:task withDelTag:2];
}


//0：未被删除，1：已删除，2：彻底删除
- (void)delTask:(PGTaskListModel*)task withDelTag:(NSInteger)tag{
    [self.dbMgr.database open];
    [self.dbMgr updateDataIntoTableWithName:task_list_table andSearchModelsArr:@[[HDJDSQLSearchModel createSQLSearchModelWithAttriName:@"task_id" andSymbol:@"=" andSpecificValue:QMStringFromNSInteger(task.task_id)]] andNewModelsArr:@[[HDJDSQLSearchModel createSQLSearchModelWithAttriName:@"is_delete" andSymbol:@"=" andSpecificValue:QMStringFromNSInteger(tag)],[HDJDSQLSearchModel createSQLSearchModelWithAttriName:@"is_default" andSymbol:@"=" andSpecificValue:@"0"]]];
    [self.dbMgr.database close];
    
}


#pragma mark - NetRequest



@end
