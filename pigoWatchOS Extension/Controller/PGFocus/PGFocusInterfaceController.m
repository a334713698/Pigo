//
//  PGFocusInterfaceController.m
//  pigoWatchOS Extension
//
//  Created by 洪冬介 on 2018/9/18.
//  Copyright © 2018年 洪冬介. All rights reserved.
//

#import "PGFocusInterfaceController.h"

@interface PGFocusInterfaceController ()

@end

@implementation PGFocusInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    // Configure interface objects here.
    [self addMenuItemWithItemIcon:WKMenuItemIconTrash title:@"删除这个番茄" action:@selector(deleteTask)];

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

@end



