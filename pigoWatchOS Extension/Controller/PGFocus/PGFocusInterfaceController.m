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
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceSeparator *line;

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
    [self settingTaskLab:self.taskModel];
    [self.viewModel setCurrentFocusState:PGFocusStateWillFocus];
    
    [NOTI_CENTER addObserver:self selector:@selector(taskUpdate:) name:TaskUpdateNotification object:nil];
    [NOTI_CENTER addObserver:self selector:@selector(ConfigUpdate) name:ConfigUpdateNotification object:nil];

}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    NSLog(@"willActivate-%@",NSStringFromClass([self class]));
    
    [self updateTask];

}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
    NSLog(@"didDeactivate-%@",NSStringFromClass([self class]));
}

- (void)settingTaskLab:(PGTaskListModel*)model{
    NSString* name;
    if (NULLString(self.taskModel.task_name)) {
        name = NSLocalizedString(@"Unknown Tag", nil);
    }else{
        name = self.taskModel.task_name;
    }
    [self.taskNameLab setText:name];
    CGFloat width = [name boundingRectWithSize:CGSizeMake(MAXFLOAT, 30*0.75) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]} context:NULL].size.width + 5;
    [self.line setWidth:width];
//    [self.line setColor:HexColor(self.taskModel.bg_color)];

}

- (void)ConfigUpdate{
    PGFocusState state = self.viewModel.currentFocusState;
    self.viewModel.currentFocusState = state;
}

- (void)taskUpdate:(NSNotification*)noti{
    PGTaskListModel* model = noti.object;
    WKUserModelInstance.currentTask = model;
    [self updateTask];
}

- (void)updateTask{
    if (self.taskModel.task_id != WKUserModelInstance.currentTask.task_id) {
        self.taskModel = WKUserModelInstance.currentTask;
        [self settingTaskLab:self.taskModel];
        [self.viewModel setCurrentFocusState:PGFocusStateWillFocus];
    }
    
    NSInteger stamp = [USER_DEFAULT integerForKey:Focuse_EndTimeStamp];
    if (stamp > 0 && [WKUserModelInstance checkeMissingTomato]) {
        self.viewModel.endTimeStamp = stamp;
        [self.viewModel setCurrentFocusState:PGFocusStateFocusing];
    }
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



