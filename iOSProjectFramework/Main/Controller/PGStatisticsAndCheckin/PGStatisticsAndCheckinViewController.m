//
//  PGStatisticsAndCheckinViewController.m
//  iOSProjectFramework
//
//  Created by 洪冬介 on 2018/10/15.
//  Copyright © 2018 洪冬介. All rights reserved.
//

#import "PGStatisticsAndCheckinViewController.h"
#import "PGStatisticsAndCheckinScrollerView.h"
#import "PGCheckinView.h"
#import "PGStatisticsView.h"

@interface PGStatisticsAndCheckinViewController ()<PGStatisticsAndCheckinScrollerViewDelegate>

@property (nonatomic, strong) UISegmentedControl *segmentedControl;
@property (nonatomic, strong) PGStatisticsAndCheckinScrollerView *scrollerView;

@property (nonatomic, strong) PGCheckinView *checkinView;
@property (nonatomic, strong) PGStatisticsView *statisticsView;

@end

@implementation PGStatisticsAndCheckinViewController

#pragma mark - lazy load
- (UISegmentedControl *)segmentedControl{
    if (!_segmentedControl) {
        _segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"  统计  ",@"  打卡  "]];
        _segmentedControl.tintColor = WHITE_COLOR;
        _segmentedControl.selectedSegmentIndex = 0;
        [_segmentedControl addTarget:self action:@selector(segmentedControlValueChange:) forControlEvents:UIControlEventValueChanged];
    }
    return _segmentedControl;
}

- (PGStatisticsAndCheckinScrollerView *)scrollerView{
    if (!_scrollerView) {
        _scrollerView = [[PGStatisticsAndCheckinScrollerView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - STATUSBAR_HEIGHT - NAVIGATIONBAR_HEIGHT) andSubviews:@[self.statisticsView,self.checkinView]];
        _scrollerView.scrollerViewPageDelegate = self;
        [self.view addSubview:_scrollerView];
    }
    return _scrollerView;
}

- (PGCheckinView *)checkinView{
    if (!_checkinView) {
        _checkinView = [[PGCheckinView alloc] initWithTaskID:self.taskModel.task_id];
    }
    return _checkinView;
}

- (PGStatisticsView *)statisticsView{
    if (!_statisticsView) {
        _statisticsView = [[PGStatisticsView alloc] initWithTaskID:self.taskModel.task_id];
    }
    return _statisticsView;
}

#pragma mark - life view
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initNav];
    
    self.scrollerView.hidden = NO;
    
}


#pragma mark - PGStatisticsAndCheckinScrollerViewDelegate
- (void)scrollerView:(PGStatisticsAndCheckinScrollerView*)scrollerView currentPage:(NSInteger)pageIndex{
    self.segmentedControl.selectedSegmentIndex = pageIndex;
}

#pragma mark - SEL
- (void)segmentedControlValueChange:(UISegmentedControl*)sender{
    [self.scrollerView setPageIndex:sender.selectedSegmentIndex animated:YES];
}

#pragma mark - method
- (void)initNav{
    
    self.navigationItem.titleView = self.segmentedControl;
    
    NSInteger lenght = ceil(adaptWidth(8));
    NSString* title = self.taskModel.task_name;
    DLog(@"lenght: %ld",lenght);
    [self.navButtonLeft setImage:nil forState:UIControlStateNormal];
    if (self.taskModel.task_name.length > lenght) {
        title = [NSString stringWithFormat:@"%@...",[self.taskModel.task_name substringToIndex:lenght]];
    }
    [self.navButtonLeft setTitle:title forState:UIControlStateNormal];

    self.navButtonRight.frame = CGRectMake(0, 0, 30, 30);
    [self.navButtonRight setImage:[UIImage imageNamed:@"icon_close"] forState:UIControlStateNormal];
}

- (void)navRightPressed:(id)sender{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

@end
