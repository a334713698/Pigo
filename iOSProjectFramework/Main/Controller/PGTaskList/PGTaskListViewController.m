//
//  PGTaskListViewController.m
//  iOSProjectFramework
//
//  Created by 洪冬介 on 2018/9/6.
//  Copyright © 2018年 洪冬介. All rights reserved.
//

#import "PGTaskListViewController.h"
#import "PGTaskCell.h"
#import "PGTaskTableView.h"
#import "PGSettingViewController.h"
#import "PGTaskListModel.h"
#import "PGTaskListViewModel.h"
#import "PGTomatoRecordModel.h"
#import "PGStatisticsAndCheckinViewController.h"

@interface PGTaskListViewController ()<UITableViewDataSource,UITableViewDelegate,PGTaskCellDelegate>

@property (nonatomic, strong) PGTaskTableView *tableView;
@property (nonatomic, strong) PGTaskListViewModel *viewModel;

@property (nonatomic, strong) NSMutableArray<PGTaskListModel*> *taskList;


@end

@implementation PGTaskListViewController

#pragma mark - lazy load
- (PGTaskTableView *)tableView{
    if (!_tableView) {
        _tableView = [[PGTaskTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [self.view addSubview:_tableView];
        _tableView.backgroundColor = BACKGROUND_COLOR;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = adaptWidth(PGTaskCellHeight);
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
        NSArray* taskArr = [self.dbMgr getAllTuplesFromTabel:task_list_table withSortedMode:NSOrderedDescending andColumnName:@"task_id"];
        if (taskArr.count) {
            NSString* dateToday = [NSDate dateToCustomFormateString:@"yyyyMMdd" andDate:[NSDate new]];
            NSArray* recordDicArr = [self.dbMgr getAllTuplesFromTabel:tomato_record_table andSearchModel:[HDJDSQLSearchModel createSQLSearchModelWithAttriName:@"add_date" andSymbol:@"=" andSpecificValue:TextFromNSString(dateToday)]];
            NSMutableArray* recordModelArr = [PGTomatoRecordModel mj_objectArrayWithKeyValuesArray:recordDicArr];
            if (recordDicArr.count) {
                for (NSDictionary* taskDic in taskArr) {
                    PGTaskListModel *model = [[PGTaskListModel alloc] mj_setKeyValues:taskDic];
                    for (PGTomatoRecordModel* recordModel in recordModelArr) {
                        if (model.task_id == recordModel.task_id) {
                            model.count = recordModel.count;
                            [recordModelArr removeObject:recordModel];
                            break;
                        }
                    }
                    [_taskList addObject:model];
                }
            }else{
                [_taskList addObjectsFromArray:[PGTaskListModel mj_objectArrayWithKeyValuesArray:taskArr]];
            }
            
            [self.viewModel watch_updateTaskList:_taskList.copy];
        }
        [self.dbMgr.database close];
    }
    return _taskList;
}

- (PGTaskListViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [PGTaskListViewModel new];
    }
    return _viewModel;
}

#pragma mark - view func
- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = BACKGROUND_COLOR;
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
    
    PGTaskCell* cell = [tableView dequeueReusableCellWithIdentifier:@"PGTaskCell"];
    if (!cell) {
        cell = [[PGTaskCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PGTaskCell"];
        cell.delegate = self;
    }
    NSString* imgName = [NSString stringWithFormat:@"pic_scene_%ld",(indexPath.section+1)%5];
    cell.bgImageView.image = IMAGE(imgName);
//    cell.contView.backgroundColor = [UIColor redColor];
    [cell setLabelShadow:cell.qm_titleLabel content:task.task_name];
    [cell setLabelShadow:cell.qm_detailLabel content:QMStringFromNSInteger(task.count)];
    cell.taskModel = task;
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DLog(@"cell：%ld-%ld",indexPath.section,indexPath.row);
    
    PGStatisticsAndCheckinViewController* next = [PGStatisticsAndCheckinViewController new];
    BaseNavigationController* nav = [[BaseNavigationController alloc] initWithRootViewController:next];
    next.taskModel = self.taskList[indexPath.section];
    [self presentViewController:nav animated:YES completion:nil];
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

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PGTaskListModel* task = self.taskList[indexPath.section];

    WS(weakSelf)
    UITableViewRowAction *action = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除    " handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        [weakSelf.taskList removeObjectAtIndex:indexPath.section];
        [weakSelf.tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
        [self.dbMgr.database open];
        [self.dbMgr deleteDataFromTabel:task_list_table andSearchModel:[HDJDSQLSearchModel createSQLSearchModelWithAttriName:@"task_name" andSymbol:@"=" andSpecificValue:[NSString stringWithFormat:@"\'%@\'",task.task_name]]];
        [self.dbMgr.database close];
        [self watch_updateTaskList];
    }];
    action.backgroundColor = BACKGROUND_COLOR;
    return @[action];
}

#pragma mark - SEL
- (void)navAddPressed{
    DLog(@"新增任务");
    UIAlertController* alertVC = [UIAlertController alertControllerWithTitle:@"新任务" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    [alertVC addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"任务名称";
    }];
    
    WS(weakSelf)
    [alertVC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSString* taskName = alertVC.textFields.firstObject.text;
        if (NULLString(taskName)) {
            [MBProgressHUD showError:@"啥也没输入"];
        }else{
            PGTaskListModel* model = [PGTaskListModel new];
            model.task_name = taskName;
            [weakSelf.taskList insertObject:model atIndex:0];
            [weakSelf.tableView reloadData];
            [self.dbMgr.database open];
            NSString* now = [[NSDate date] dateToTimeStamp];
            [self.dbMgr insertDataIntoTableWithName:task_list_table andKeyValues:@{@"task_name":[NSString stringWithFormat:@"\'%@\'",taskName],@"add_time":now}];
            NSDictionary* tuples = [self.dbMgr getAllTuplesFromTabel:task_list_table andSearchModel:[HDJDSQLSearchModel createSQLSearchModelWithAttriName:@"add_time" andSymbol:@"=" andSpecificValue:now]].firstObject;
            model.task_id = [tuples[@"task_id"] integerValue];
            [self.dbMgr.database close];
            [self watch_updateTaskList];
        }
    }]];
    
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (void)navSetPressed{
    DLog(@"设置");
    PGSettingViewController* next  =[PGSettingViewController new];
    [self.navigationController pushViewController:next animated:YES];
}

#pragma mark - PGTaskCellDelegate
- (void)taskCell:(PGTaskCell*)cell playButtonDidClick:(UIButton*)btn{
    if (cell.taskModel.task_id == PGUserModelInstance.currentTask.task_id) {
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    if ([self judgingState]) {
        return;
    }
    [self.dbMgr.database open];
    [self.dbMgr updateDataIntoTableWithName:task_list_table andSearchModel:[HDJDSQLSearchModel createSQLSearchModelWithAttriName:@"is_default" andSymbol:@"=" andSpecificValue:@"1"] andNewModel:[HDJDSQLSearchModel createSQLSearchModelWithAttriName:@"is_default" andSymbol:@"=" andSpecificValue:@"0"]];
    [self.dbMgr updateDataIntoTableWithName:task_list_table andSearchModel:[HDJDSQLSearchModel createSQLSearchModelWithAttriName:@"task_id" andSymbol:@"=" andSpecificValue:QMStringFromNSInteger(cell.taskModel.task_id)] andNewModel:[HDJDSQLSearchModel createSQLSearchModelWithAttriName:@"is_default" andSymbol:@"=" andSpecificValue:@"1"]];
    [self.dbMgr.database close];
    
    PGUserModelInstance.currentTask = cell.taskModel;
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Method
- (void)initNav{
    self.navTitle = @"番茄列表";
    
    // 导航栏右侧按钮
    UIButton* settingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    settingButton.frame = CGRectMake(0, 0, 30, NAVIGATIONBAR_HEIGHT + 14);
    settingButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    settingButton.centerY = 22;
    settingButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [settingButton setImage:IMAGE(@"icon_nav_set") forState:UIControlStateNormal];
    [settingButton addTarget:self action:@selector(navSetPressed) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton* addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    addButton.frame = CGRectMake(0, 0, 30, NAVIGATIONBAR_HEIGHT + 14);
    addButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    addButton.centerY = 22;
    addButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [addButton setImage:IMAGE(@"icon_nav_add") forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(navAddPressed) forControlEvents:UIControlEventTouchUpInside];

    self.navigationItem.rightBarButtonItems = @[[[UIBarButtonItem alloc] initWithCustomView:settingButton],[[UIBarButtonItem alloc] initWithCustomView:addButton]];
}

- (BOOL)judgingState{
    if (PGUserModelInstance.currentFocusState != PGFocusStateFocusing && PGUserModelInstance.currentFocusState != PGFocusStateShortBreaking && PGUserModelInstance.currentFocusState != PGFocusStateLongBreaking) {
        return NO;
    }
    UIAlertController* alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"\n有任务正在进行，请先作废当前任务" preferredStyle:UIAlertControllerStyleAlert];
    
    [alertVC addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    
    [self presentViewController:alertVC animated:YES completion:nil];

    return YES;
}

- (void)watch_updateTaskList{
    [self.viewModel watch_updateTaskList:self.taskList.copy];
}


@end
