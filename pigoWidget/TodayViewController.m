//
//  TodayViewController.m
//  pigoWidget
//
//  Created by quanmai on 2018/12/26.
//  Copyright © 2018 洪冬介. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>

@interface TodayViewController () <NCWidgetProviding>

@property (nonatomic, strong) UILabel *label;

@end

@implementation TodayViewController

- (UILabel *)label{
    if (!_label) {
        _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width/2.0, 50)];
        _label.text = @"hello world";
        _label.textAlignment = NSTextAlignmentCenter;
        _label.textColor = [UIColor blackColor];
        [self.view addSubview:_label];
    }
    return _label;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initView];
}

- (void)viewWillAppear:(BOOL)animated {
    // 设置折叠还是展开
    // 设置展开才会展示，设置折叠无效，左上角不会出现按钮
    self.extensionContext.widgetLargestAvailableDisplayMode = NCWidgetDisplayModeExpanded;
}

// 展开／折叠监听
- (void)widgetActiveDisplayModeDidChange:(NCWidgetDisplayMode)activeDisplayMode withMaximumSize:(CGSize)maxSize{
    CGSize preferredContentSize = CGSizeZero;
    if (activeDisplayMode == NCWidgetDisplayModeCompact) { //折叠
        // 折叠后的大小是固定的，目前测试的更改无效，默认高度应该是110
        preferredContentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 100);
    }else {
        // 展开
        preferredContentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 300);
    }
    self.preferredContentSize = preferredContentSize;
    self.label.frame = CGRectMake(0, 0, preferredContentSize.width, preferredContentSize.height);
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData
    
    completionHandler(NCUpdateResultNewData);
}

- (void)initView {
    // 和主应用的数据共享，获取主应用里的数据
    NSUserDefaults *sharedData = [[NSUserDefaults alloc] initWithSuiteName:@"group.hdj.pigo"];

}

// NSFileManager 读取数据
- (NSString *)readByFileManager {
    NSError *error = nil;
    NSURL *containUrl = [[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:@"group.hdj.pigo"];
    containUrl = [containUrl URLByAppendingPathComponent:@"group.data"];
    NSString *text = [NSString stringWithContentsOfURL:containUrl encoding:NSUTF8StringEncoding error:&error];
    return text;
}

// 点击按钮打开主app
- (void)btnAction {
    [self.extensionContext openURL:[NSURL URLWithString:@"TodayWidget://"] completionHandler:^(BOOL success) {
        
    }];
}

@end
