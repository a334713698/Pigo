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
#import "PGTaskListViewModel.h"
#import "PGTomatoRecordModel.h"
#import "PGStatisticsAndCheckinViewController.h"
#import "PGTaskListAddView.h"

@interface PGTaskListViewController ()<UITableViewDataSource,UITableViewDelegate,PGTaskCellDelegate,PGTaskListAddViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) PGTaskListViewModel *viewModel;

@property (nonatomic, strong) NSMutableArray<PGTaskListModel*> *taskList;

@property (nonatomic, strong) PGTaskListAddView *addView;
@property (nonatomic, assign) NSInteger editTaskIndex;

@end

@implementation PGTaskListViewController{
    BOOL _isEdit;
}

#pragma mark - lazy load
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
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
        
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGestureRecognized:)];
        [_tableView addGestureRecognizer:longPress];

    }
    return _tableView;
}

- (PGTaskListAddView *)addView{
    if (!_addView) {
        _addView = [[PGTaskListAddView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _addView.delegate = self;
    }
    return _addView;
}

- (NSMutableArray<PGTaskListModel*> *)taskList{
    if (!_taskList) {
        _taskList = [NSMutableArray array];
        [self.dbMgr.database open];
        NSArray* taskArr = [self.dbMgr getAllTuplesFromTabel:task_list_table andSearchModel:[HDJDSQLSearchModel createSQLSearchModelWithAttriName:@"is_delete" andSymbol:@"=" andSpecificValue:@"0"] withSortedMode:NSOrderedAscending andColumnName:@"priority"];
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
            [self saveListData];
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
- (void)dealloc {
    NSLog(@"%@--dealloc", [self class]);
    [self removeNotiObserver];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = BACKGROUND_COLOR;
    self.tableView.hidden = NO;
    [self initNav];
    [self addNotiObserver];
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
    cell.contView.backgroundColor = [UIColor colorWithHexStr:task.bg_color];
    [cell setLabelShadow:cell.qm_titleLabel content:task.task_name];
    [cell setLabelShadow:cell.qm_detailLabel content:QMStringFromNSInteger(task.count)];
    cell.taskModel = task;
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
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
    
    UITableViewRowAction *editAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"编辑" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        weakSelf.editTaskIndex = indexPath.section;
        [weakSelf editTask:task];
    }];
    editAction.backgroundColor = [UIColor grayColor];

    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        [weakSelf.taskList removeObjectAtIndex:indexPath.section];
        [weakSelf.tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
        [weakSelf deleteTask:task];
    }];
    deleteAction.backgroundColor = [UIColor redColor];
    return @[deleteAction,editAction];
}

#pragma mark - SEL
- (void)navAddPressed{
    DLog(@"新增任务");
    _isEdit = NO;
    [QMSlideUpAlertView showAlertWithContentView:self.addView withSlideType:QMAlertSlideUpTypeCenter canTouchDissmiss:NO];
//    [self.addView.textField becomeFirstResponder];
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

#pragma mark - PGTaskListAddViewDelegate
- (void)addView:(PGTaskListAddView *)addView sureButtonDidClick:(UIButton *)sender{
    if (NULLString(addView.titleCont)) {
        [MFHUDManager showError:@"啥也没输入"];
    }else if (_isEdit){
        [QMSlideUpAlertView dismissWithCompletion:^(BOOL finished) {
            [self updateTask];
        }];
    }else{
        [QMSlideUpAlertView dismissWithCompletion:^(BOOL finished) {
            [self addTask];
        }];
    }
}

-(void)addView:(PGTaskListAddView *)addView closeButtonDidClick:(UIButton *)sender{
    [QMSlideUpAlertView dismissWithCompletion:^(BOOL finished) {
        [addView clearTextField];
    }];
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

- (void)addNotiObserver{
    [NOTI_CENTER addObserver:self selector:@selector(recycleBinRestore) name:PGRecycleBinRestoreNotification object:nil];
}

- (void)removeNotiObserver{
    [NOTI_CENTER removeObserver:self name:PGRecycleBinRestoreNotification object:nil];
}

- (void)recycleBinRestore{
    _taskList = nil;
    [self.tableView reloadData];
}

- (void)saveListData{
    [self.viewModel saveListData:self.taskList];
}

- (BOOL)judgingState{
    if (PGUserModelInstance.currentFocusState != PGFocusStateFocusing && PGUserModelInstance.currentFocusState != PGFocusStateShortBreaking && PGUserModelInstance.currentFocusState != PGFocusStateLongBreaking) {
        return NO;
    }
    UIAlertController* alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"\n有任务正在进行，请先中止当前任务" preferredStyle:UIAlertControllerStyleAlert];
    
    [alertVC addAction:[UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil]];
    
    [self presentViewController:alertVC animated:YES completion:nil];

    return YES;
}

- (void)deleteTask:(PGTaskListModel*)task{
    [self.dbMgr.database open];
    
    [self.dbMgr updateDataIntoTableWithName:task_list_table andSearchModelsArr:@[[HDJDSQLSearchModel createSQLSearchModelWithAttriName:@"task_id" andSymbol:@"=" andSpecificValue:QMStringFromNSInteger(task.task_id)]] andNewModelsArr:@[[HDJDSQLSearchModel createSQLSearchModelWithAttriName:@"is_delete" andSymbol:@"=" andSpecificValue:@"1"],[HDJDSQLSearchModel createSQLSearchModelWithAttriName:@"delete_time" andSymbol:@"=" andSpecificValue:[[NSDate new] dateToTimeStamp]],[HDJDSQLSearchModel createSQLSearchModelWithAttriName:@"is_default" andSymbol:@"=" andSpecificValue:@"0"],]];
    
    [self.dbMgr.database close];
    [self watch_updateTaskList];
    [self saveListData];
    if (PGUserModelInstance.currentTask.task_id == task.task_id) {
        PGTaskListModel *currentTask;
        PGUserModelInstance.currentTask = currentTask;
    }
}

- (void)editTask:(PGTaskListModel*)task{
    _isEdit = YES;
    [QMSlideUpAlertView showAlertWithContentView:self.addView withSlideType:QMAlertSlideUpTypeCenter canTouchDissmiss:NO];
    self.addView.textField.text = task.task_name;
    self.addView.colorIndex = [self.addView.colorArr indexOfObject:task.bg_color];
    self.addView.hexStr = self.addView.colorArr[self.addView.colorIndex];
    [self.addView.collectionView reloadData];
    [self saveListData];
//    [self.addView.textField becomeFirstResponder];
}

- (void)addTask{
    NSString* taskName = self.addView.titleCont;
    PGTaskListModel* model = [PGTaskListModel new];
    model.task_name = taskName;
    model.bg_color = self.addView.hexStr;
    [self.taskList insertObject:model atIndex:0];
    [self.tableView insertSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
    [self.dbMgr.database open];
    NSString* now = [[NSDate date] dateToTimeStamp];
    [self.dbMgr insertDataIntoTableWithName:task_list_table andKeyValues:@{@"task_name":[NSString stringWithFormat:@"\'%@\'",taskName],@"add_time":now,@"is_delete":@"0",@"bg_color":TextFromNSString(self.addView.hexStr)}];
    
    NSDictionary* tuples = [self.dbMgr getAllTuplesFromTabel:task_list_table andSearchModel:[HDJDSQLSearchModel createSQLSearchModelWithAttriName:@"add_time" andSymbol:@"=" andSpecificValue:now]].firstObject;
    model.task_id = [tuples[@"task_id"] integerValue];
    [self.dbMgr.database close];

    [self priorityRedistribution];
    [self watch_updateTaskList];
    [self saveListData];
    [self.addView clearTextField];
}

- (void)updateTask{
    NSString* taskName = self.addView.titleCont;
    NSString* hexStr = self.addView.hexStr;
    PGTaskListModel* model = self.taskList[self.editTaskIndex];
    model.task_name = taskName;
    model.bg_color = hexStr;
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:self.editTaskIndex] withRowAnimation:UITableViewRowAnimationNone];
    [self.dbMgr.database open];
//    NSString* updateDateStamp = [[NSDate date] dateToTimeStamp];
    [self.dbMgr updateDataIntoTableWithName:task_list_table andSearchModelsArr:@[[HDJDSQLSearchModel createSQLSearchModelWithAttriName:@"task_id" andSymbol:@"=" andSpecificValue:QMStringFromNSInteger(model.task_id)]] andNewModelsArr:@[[HDJDSQLSearchModel createSQLSearchModelWithAttriName:@"task_name" andSymbol:@"=" andSpecificValue:TextFromNSString(taskName)],[HDJDSQLSearchModel createSQLSearchModelWithAttriName:@"bg_color" andSymbol:@"=" andSpecificValue:TextFromNSString(hexStr)]]];
    
    [self.dbMgr.database close];
    [self watch_updateTaskList];
    [self saveListData];
    [self.addView clearTextField];

    _isEdit = NO;
    self.editTaskIndex = -1;
}

- (void)priorityRedistribution{
    [self.dbMgr.database open];
    for (NSInteger i = 0; i < self.taskList.count; i++) {
        PGTaskListModel* model = self.taskList[i];
        [self.dbMgr updateDataIntoTableWithName:task_list_table andSearchModel:[HDJDSQLSearchModel createSQLSearchModelWithAttriName:@"task_id" andSymbol:@"=" andSpecificValue:QMStringFromNSInteger(model.task_id)] andNewModel:[HDJDSQLSearchModel createSQLSearchModelWithAttriName:@"priority" andSymbol:@"=" andSpecificValue:QMStringFromNSInteger(i)]];
    }
    [self.dbMgr.database close];
}

- (void)watch_updateTaskList{
    [self.viewModel watch_updateTaskList:self.taskList.copy];
}

#pragma mark - UITableView Drag methods
- (void)longPressGestureRecognized:(id)sender {
    
    UILongPressGestureRecognizer *longPress = (UILongPressGestureRecognizer *)sender;
    UIGestureRecognizerState state = longPress.state;
    
    CGPoint location = [longPress locationInView:_tableView];
    NSIndexPath *indexPath = [_tableView indexPathForRowAtPoint:location];
    
    static UIView       *snapshot = nil;        ///< A snapshot of the row user is moving.
    static NSIndexPath  *sourceIndexPath = nil; ///< Initial index path, where gesture begins.
    
    switch (state) {
        case UIGestureRecognizerStateBegan: {
            if (indexPath) {
                sourceIndexPath = indexPath;
                
                UITableViewCell *cell = [_tableView cellForRowAtIndexPath:indexPath];
                snapshot = [self customSnapshoFromView:cell];
                
                __block CGPoint center = cell.center;
                snapshot.center = center;
                snapshot.alpha = 0.0;
                [_tableView addSubview:snapshot];
                [UIView animateWithDuration:0.3 animations:^{
                    
                    // Offset for gesture location.
                    center.y = location.y;
                    snapshot.center = center;
                    snapshot.alpha = 0.98;
                    
                    cell.alpha = 0.0f;
                } completion:^(BOOL finished) {
                    cell.hidden = YES;
                }];
            }
            break;
        }
            
        case UIGestureRecognizerStateChanged: {
            CGPoint center = snapshot.center;
            center.y = location.y;
            snapshot.center = center;
            
            if (indexPath && ![indexPath isEqual:sourceIndexPath]) {
                
                [self.taskList exchangeObjectAtIndex:indexPath.section withObjectAtIndex:sourceIndexPath.section];
                [_tableView moveSection:sourceIndexPath.section toSection:indexPath.section];
                sourceIndexPath = indexPath;
            }
            break;
        }
            
        default: {
            // Clean up.
            WS(weakSelf)
            UITableViewCell *cell = [_tableView cellForRowAtIndexPath:sourceIndexPath];
            [UIView animateWithDuration:0.3 animations:^{
                
                snapshot.center = cell.center;
                snapshot.layer.shadowOpacity = 0.01;
                snapshot.layer.shadowRadius = 0.01;

                cell.alpha = 1.0f;
            } completion:^(BOOL finished) {
                cell.hidden = NO;
                [snapshot removeFromSuperview];
                snapshot = nil;
                [weakSelf priorityRedistribution];
            }];
            sourceIndexPath = nil;
            break;
        }
    }
}

#pragma mark - Helper methods
- (UIView *)customSnapshoFromView:(UIView *)inputView {
    //ios7.0+ 的快照方法
    UIView* snapshot = [inputView snapshotViewAfterScreenUpdates:YES];
    snapshot.layer.shadowOffset = CGSizeMake(-3, 3);
    snapshot.layer.shadowRadius = 3;
    snapshot.layer.shadowOpacity = 0.4;
    return snapshot;
}

@end
