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

@interface PGTaskListViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) PGTaskTableView *tableView;

@property (nonatomic, strong) NSMutableArray *taskList;
@property (nonatomic, strong) NSDictionary *task;


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

- (NSDictionary *)task{
    if (!_task) {
        _task = @{@"title":@"Task",@"length":@"25分钟"};
    }
    return _task;
}

- (NSMutableArray *)taskList{
    if (!_taskList) {
        _taskList = [NSMutableArray array];
        [_taskList insertObject:self.task.copy atIndex:0];
    }
    return _taskList;
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
    NSDictionary* task = self.taskList[indexPath.section];
    
    PGTaskCell* cell = [tableView dequeueReusableCellWithIdentifier:@"PGTaskCell"];
    if (!cell) {
        cell = [[PGTaskCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PGTaskCell"];
    }
    NSString* imgName = [NSString stringWithFormat:@"pic_scene_%ld",(indexPath.section+1)%5];
    cell.bgImageView.image = IMAGE(imgName);
    [cell setLabelShadow:cell.qm_titleLabel content:task[@"title"]];
    [cell setLabelShadow:cell.qm_detailLabel content:task[@"length"]];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DLog(@"cell：%ld-%ld",indexPath.section,indexPath.row);
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
    
    WS(weakSelf)
    UITableViewRowAction *action = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除    " handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        [weakSelf.taskList removeObjectAtIndex:indexPath.section];
        [weakSelf.tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
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
            [weakSelf.taskList insertObject:weakSelf.task.copy atIndex:0];
        }else{
            [weakSelf.taskList insertObject:@{@"title":taskName,@"length":@"25分钟"} atIndex:0];
        }
        [weakSelf.tableView reloadData];
    }]];
    
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (void)navSetPressed{
    DLog(@"设置");
    PGSettingViewController* next  =[PGSettingViewController new];
    [self.navigationController pushViewController:next animated:YES];
}

#pragma mark - Method
- (void)initNav{
    self.navTitle = @"TODO";
    
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

#pragma mark - NetRequest



@end
