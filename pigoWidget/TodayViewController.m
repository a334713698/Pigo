//
//  TodayViewController.m
//  pigoWidget
//
//  Created by quanmai on 2018/12/26.
//  Copyright © 2018 洪冬介. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>
#import "PGTaskListCollectionViewCell.h"

#define NCWidgetDisplayModeCompactDefaultHeight 110
#define NCWidgetDisplayModeExpandedHeight (220-12+0)

@interface TodayViewController () <NCWidgetProviding,UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSArray<PGTaskListModel*> *taskList;

@end

@implementation TodayViewController

#pragma mark - lazy load
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout* flowLayout = [[UICollectionViewFlowLayout alloc] init];
        NSInteger column = 2;
        CGFloat hMargin = 12;
        CGFloat VMargin = 12;
        CGFloat itemWidth = (self.view.frame.size.width - hMargin * (column + 1))/column;
        CGFloat itemHeight = (NCWidgetDisplayModeCompactDefaultHeight - hMargin * 3)/2;
        flowLayout.itemSize = CGSizeMake(itemWidth, itemHeight);
        flowLayout.minimumInteritemSpacing = hMargin; //项间隔
        flowLayout.minimumLineSpacing = VMargin; //行间隔
        flowLayout.sectionInset = UIEdgeInsetsMake(hMargin, VMargin, hMargin, VMargin);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        [self.view addSubview:_collectionView];
        _collectionView.backgroundColor = CLEARCOLOR;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:[PGTaskListCollectionViewCell class] forCellWithReuseIdentifier:@"PGTaskListCollectionViewCell"];
    }
    return _collectionView;
}

#pragma mark - view life
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated {
    // 设置折叠还是展开
    // 设置展开才会展示，设置折叠无效，左上角不会出现按钮
    self.extensionContext.widgetLargestAvailableDisplayMode = NCWidgetDisplayModeExpanded;
}

#pragma mark - NCWidgetProviding
// 展开／折叠监听
- (void)widgetActiveDisplayModeDidChange:(NCWidgetDisplayMode)activeDisplayMode withMaximumSize:(CGSize)maxSize{
    CGSize preferredContentSize = CGSizeZero;
    if (activeDisplayMode == NCWidgetDisplayModeCompact) { //折叠
        // 折叠后的大小是固定的，目前测试的更改无效，默认高度应该是110
        preferredContentSize = CGSizeMake(self.view.frame.size.width, NCWidgetDisplayModeCompactDefaultHeight);
    }else {
        // 展开
        preferredContentSize = CGSizeMake(self.view.frame.size.width, NCWidgetDisplayModeExpandedHeight);
    }
    self.collectionView.frame = CGRectMake(0, 0, preferredContentSize.width, preferredContentSize.height);
    self.preferredContentSize = preferredContentSize;
    [self updateData];
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData
    
    completionHandler(NCUpdateResultNewData);
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.taskList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PGTaskListModel* task = self.taskList[indexPath.item];
    PGTaskListCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PGTaskListCollectionViewCell" forIndexPath:indexPath];
    cell.taskModel = task;
    return cell;
}

#pragma mark - UICollectionViewDelegate


#pragma mark - method
- (void)updateData {
    // 和主应用的数据共享，获取主应用里的数据
    NSUserDefaults *sharedUD = [[NSUserDefaults alloc] initWithSuiteName:@"group.hdj.pigo"];
    NSData* shareData = [sharedUD valueForKey:TaskListData];
    NSArray* dataList = [shareData mj_JSONObject];
    DLog(@"%@",dataList);
    self.taskList = [PGTaskListModel mj_objectArrayWithKeyValuesArray:dataList];
    [self.collectionView reloadData];
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
