//
//  PGStatisticsAnnualActivityCell.m
//  iOSProjectFramework
//
//  Created by quanmai on 2018/10/18.
//  Copyright © 2018年 洪冬介. All rights reserved.
//

#import "PGStatisticsAnnualActivityCell.h"
#import "PGStatisticsAnnualActivityViewController.h"

@interface PGStatisticsAnnualActivityCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UIPopoverPresentationControllerDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) PGStatisticsAnnualActivityViewController *popVc;

@end

@implementation PGStatisticsAnnualActivityCell

- (PGStatisticsAnnualActivityViewController *)popVc{
    if (!_popVc) {
        _popVc = [PGStatisticsAnnualActivityViewController new];
    }
    return _popVc;
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout* flowLayout = [[UICollectionViewFlowLayout alloc] init];
        CGFloat itemWidth = 12;
        CGFloat itemHeight = 12;
        flowLayout.itemSize = CGSizeMake(itemWidth, itemHeight);
        flowLayout.minimumInteritemSpacing = 2; //项间隔
        flowLayout.minimumLineSpacing = 2; //行间隔
        flowLayout.sectionInset = UIEdgeInsetsMake(8, 8, 8, 8);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        [self addSubview:_collectionView];
        _collectionView.backgroundColor = WHITE_COLOR;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
    }
    return _collectionView;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupView];
    }
    return self;
}

- (void)setupView{
    self.collectionView.hidden = NO;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return PGStatisticsAnnualActivityDuration;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell* cell =  [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    cell.layer.cornerRadius = 1.5;
    cell.backgroundColor = LINE_COLOR_GRAY_LIGHT;
    NSString* dateStr = [NSDate dateToCustomFormateString:@"yyyyMMdd" andDate:[self getDateFrom:[NSDate new] offsetDays:-(PGStatisticsAnnualActivityDuration - 1 - indexPath.item)]];
    PGTomatoRecordModel* model = self.recordMutableDic[dateStr];
    cell.backgroundColor = [self colorForTomatoCount:model.count];
//    if (model) {
//        DLog(@"%@ ———— %ld",dateStr,model.count);
//    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSDate* date = [self getDateFrom:[NSDate new] offsetDays:-(PGStatisticsAnnualActivityDuration - 1 - indexPath.item)];
    NSString* dateStr = [NSDate dateToCustomFormateString:@"yyyyMMdd" andDate:date];
    DLog(@"%@",dateStr);
    UICollectionViewCell* cell = [collectionView cellForItemAtIndexPath:indexPath];
    self.popVc.modalPresentationStyle = UIModalPresentationPopover;
    self.popVc.popoverPresentationController.sourceView = cell;
    self.popVc.popoverPresentationController.sourceRect = cell.bounds;
    self.popVc.popoverPresentationController.backgroundColor = MAIN_COLOR;
    self.popVc.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionDown;
    self.popVc.popoverPresentationController.delegate = self;

    PGTomatoRecordModel* model = self.recordMutableDic[dateStr];
    [self.popVc setContentWithTomatCount:model.count andDateStr:[NSDate dateToCustomFormateString:@"yyyy-MM-dd" andDate:date]];
    //3.显示弹出控制器
    [TOPVC presentViewController:self.popVc animated:YES completion:nil];
}

//根据date获取偏移指定天数的date
- (NSDate *)getDateFrom:(NSDate *)date offsetDays:(NSInteger)offsetDays {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *lastMonthComps = [[NSDateComponents alloc] init];
    [lastMonthComps setDay:offsetDays];
    NSDate *newdate = [calendar dateByAddingComponents:lastMonthComps toDate:date options:0];
    return newdate;
}

- (void)setRecordMutableDic:(NSMutableDictionary<NSString *,PGTomatoRecordModel *> *)recordMutableDic{
    _recordMutableDic = recordMutableDic;
    [self layoutIfNeeded];
    [self performSelector:@selector(scrollToRight) withObject:nil afterDelay:1];
}

- (void)scrollToRight{
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:(PGStatisticsAnnualActivityDuration-1) inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}

//根据番茄个数，给颜色（应该根据时长）
- (UIColor*)colorForTomatoCount:(NSInteger)count{
    if (count >=15) {
        return RGB(29, 96, 42);
    }else if (count >=10 && count < 15){
        return RGB(42, 153, 64);
    }else if (count >=5 && count < 10){
        return RGB(125, 200, 115);
    }else if (count >=1 && count < 5){
        return RGB(199, 227, 143);
    }else{
        return LINE_COLOR_GRAY_LIGHT;
    }
}

#pragma mark - PopoverDelegate
//使得popoverController在iphone可以使用，不然弹出控制器会全屏显示
-(UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller
{
    // Return no adaptive presentation style, use default presentation behaviour
    return  UIModalPresentationNone;
}

@end
