//
//  PGSettingViewController.m
//  iOSProjectFramework
//
//  Created by 洪冬介 on 2018/9/11.
//  Copyright © 2018年 洪冬介. All rights reserved.
//

#import "PGSettingViewController.h"
#import "PGSettingTableViewModel.h"
#import "PGTotalStatisticsViewController.h"
#import "PGRecycleBinViewController.h"

@interface PGSettingViewController ()

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) PGSettingTableViewModel *tableViewModel;
@property (nonatomic, strong) PGSettingViewModel *viewModel;

@end

@implementation PGSettingViewController


#pragma mark - lazy load
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (PGSettingTableViewModel *)tableViewModel{
    if (!_tableViewModel) {
        _tableViewModel = [PGSettingTableViewModel new];
    }
    return _tableViewModel;
}

- (PGSettingViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [PGSettingViewModel new];
    }
    return _viewModel;
}

#pragma mark - view func

- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self initNav];
    [self setupTableView];
    
    self.view.backgroundColor = BACKGROUND_COLOR;
}


#pragma mark - SEL


#pragma mark - Method
- (void)initNav{
    self.navTitle = NSLocalizedString(@"Settings", nil);
}

/**
 *  tableView的一些初始化工作
 */
- (void)setupTableView{
    WS(weakSelf)
    [self.tableViewModel handleWithTable:self.tableView];
    self.tableViewModel.didSelectItemBlock = ^(NSIndexPath *indexPath, NSDictionary* cellDic) {
        PGSettingContentType contentType = [cellDic[@"contentType"] integerValue];
        [weakSelf jumpPageWithContType:contentType];
    };
}

- (void)jumpPageWithContType:(PGSettingContentType)contentType{
    if (contentType == PGSettingContentTypeStatistics) {
        PGTotalStatisticsViewController* next = [PGTotalStatisticsViewController new];
        [self.navigationController pushViewController:next animated:YES];
    }else if (contentType == PGSettingContentTypeRecycleBin){
        PGRecycleBinViewController* next = [PGRecycleBinViewController new];
        [self.navigationController pushViewController:next animated:YES];
    }
}

@end
