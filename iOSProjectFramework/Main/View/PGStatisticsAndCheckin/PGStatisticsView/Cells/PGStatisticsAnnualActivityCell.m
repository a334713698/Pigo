//
//  PGStatisticsAnnualActivityCell.m
//  iOSProjectFramework
//
//  Created by quanmai on 2018/10/18.
//  Copyright © 2018年 洪冬介. All rights reserved.
//

#import "PGStatisticsAnnualActivityCell.h"

@interface PGStatisticsAnnualActivityCell ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;


@end

@implementation PGStatisticsAnnualActivityCell


- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout* flowLayout = [[UICollectionViewFlowLayout alloc] init];
        CGFloat itemWidth = 15;
        CGFloat itemHeight = 15;
        flowLayout.itemSize = CGSizeMake(itemWidth, itemHeight);
        flowLayout.minimumInteritemSpacing = 5; //项间隔
        flowLayout.minimumLineSpacing = 5; //行间隔
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
    cell.layer.cornerRadius = 2;
    cell.backgroundColor = LINE_COLOR_GRAY_LIGHT;
    NSString* dateStr = [NSDate dateToCustomFormateString:@"yyyyMMdd" andDate:[self getDateFrom:[NSDate new] offsetDays:-(PGStatisticsAnnualActivityDuration - 1 - indexPath.item)]];
    PGTomatoRecordModel* model = self.recordMutableDic[dateStr];
    cell.backgroundColor = [self colorForTomatoCount:model.count];
    if (model) {
        DLog(@"%@ ———— %ld",dateStr,model.count);
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString* dateStr = [NSDate dateToCustomFormateString:@"yyyyMMdd" andDate:[self getDateFrom:[NSDate new] offsetDays:-(PGStatisticsAnnualActivityDuration - 1 - indexPath.item)]];
    DLog(@"%@",dateStr);
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
    [self performSelector:@selector(scroll) withObject:nil afterDelay:1];
}

- (void)scroll{
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

@end
