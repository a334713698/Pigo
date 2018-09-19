//
//  InterfaceController.m
//  pigoWatchOS Extension
//
//  Created by 洪冬介 on 2018/9/14.
//  Copyright © 2018年 洪冬介. All rights reserved.
//

#import "InterfaceController.h"
#import "PGTaskListCell.h"
#import <WatchConnectivity/WatchConnectivity.h>

@interface InterfaceController ()

@property (nonatomic, strong) NSMutableArray *dataArr;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceTable *table;


@end


@implementation InterfaceController

- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = @[
                @{@"image": @"item_type_0", @"title": @"Menu Action And Controller Life Cycle"},
                @{@"image": @"item_type_1", @"title": @"Media Player"},
                ].mutableCopy;
    }
    return _dataArr;
}

- (void)awakeWithContext:(id)context {
    // Configure interface objects here.
    [super awakeWithContext:context];
    NSLog(@"awakeWithContext");
    [self addMenuItemWithItemIcon:WKMenuItemIconAdd title:@"添加新番茄" action:@selector(addTask)];
    [self reloadData];
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    NSLog(@"willActivate");
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
    NSLog(@"didDeactivate");
}


- (void)addTask{
    NSLog(@"添加新任务");
    [self.dataArr addObject:@{@"image": @"item_type_1", @"title": @"Media Player"}];
    [self reloadData];
    
    [self sendMsgToiPhone];
}

- (void)reloadData{
    [self.table setNumberOfRows:self.dataArr.count withRowType:@"taskCell"];
    for (NSInteger i = 0; i < self.dataArr.count; i++) {
        NSDictionary* dic = self.dataArr[i];
        PGTaskListCell* cell = [self.table rowControllerAtIndex:i];
        [cell.itemLabel setText:dic[@"title"]];
        [cell.countLabel setText:@"0"];
    }
}

#pragma send msg to iphone
- (void)sendMsgToiPhone{
    
    if (self.sessionDefault.isReachable) {
        //发送前台字典数据
        [self sendFrontMsgDic];
    }
}

//发送前台字典数据
- (void)sendFrontMsgDic{
    
    [self.sessionDefault sendMessageData:[PGTool dicToData:self.messageDic] replyHandler:^(NSData * _Nonnull replyMessageData) {
        NSLog(@"发送成功");
    } errorHandler:^(NSError * _Nonnull error) {
        NSLog(@"发送失败");
    }];
}

- (void)session:(WCSession *)session didReceiveMessage:(nonnull NSDictionary<NSString *,id> *)message replyHandler:(nonnull void (^)(NSDictionary<NSString *,id> * _Nonnull))replyHandler{
    NSLog(@"%@",message);
    replyHandler(@{@"reply":@"来自watch的收到消息后的回复"});
}


@end



