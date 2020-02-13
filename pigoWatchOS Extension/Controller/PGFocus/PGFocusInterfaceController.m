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
#import "InterfaceController.h"

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

    [self addMenuItemWithItemIcon:WKMenuItemIconMore title:NSLocalizedString(@"Pigo List", nil) action:@selector(pigoList)];

    self.taskModel = context;
    if (self.taskModel.task_name) {
        [self.taskNameLab setText:self.taskModel.task_name];
    }else{
        [self.taskNameLab setText:NSLocalizedString(@"Unknown Tag", nil)];
    }
    [self.viewModel setCurrentFocusState:PGFocusStateWillFocus];

}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    NSLog(@"willActivate-%@",NSStringFromClass([self class]));
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
    NSLog(@"didDeactivate-%@",NSStringFromClass([self class]));
}

- (IBAction)pigoList{
    NSLog(@"番茄列表");
    [self presentControllerWithName:@"InterfaceController" context:nil];
}

- (IBAction)topBtnClick {
    [self.viewModel topBtnClick];
}

- (IBAction)bottomBtnClick {
    [self.viewModel bottomBtnClick];
}

@end



