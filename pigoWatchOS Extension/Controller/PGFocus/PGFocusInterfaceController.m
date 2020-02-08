//
//  PGFocusInterfaceController.m
//  pigoWatchOS Extension
//
//  Created by 洪冬介 on 2018/9/18.
//  Copyright © 2018年 洪冬介. All rights reserved.
//

#import "PGFocusInterfaceController.h"
#import "PGFocusingViewModel.h"
#import "PGTaskListModel.h"

@interface PGFocusInterfaceController ()
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceButton *topBtn;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceButton *bottomBtn;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *timeLab;

@property (nonatomic, strong) PGFocusingViewModel *viewModel;
@property (nonatomic, strong) PGTaskListModel *taskModel;

@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *taskNameLab;

@end

@implementation PGFocusInterfaceController

- (PGFocusingViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [PGFocusingViewModel new];
        _viewModel.timeLab = self.timeLab;
        _viewModel.topBtn = self.topBtn;
        _viewModel.bottomBtn = self.bottomBtn;
    }
    return _viewModel;
}

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    // Configure interface objects here.
    [self addMenuItemWithItemIcon:WKMenuItemIconTrash title:NSLocalizedString(@"Delete Pigo", nil) action:@selector(deleteTask)];

    self.taskModel = context;
    [self.taskNameLab setText:self.taskModel.task_name];
    [self.viewModel setCurrentFocusState:PGFocusStateWillFocus];

}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

- (void)deleteTask{
    NSLog(@"删除这个番茄");
    [self dismissController];
}
- (IBAction)topBtnClick {
    [self.viewModel topBtnClick];
}

- (IBAction)bottomBtnClick {
    [self.viewModel bottomBtnClick];
}

@end



