//
//  PGTaskListAddView.m
//  iOSProjectFramework
//
//  Created by quanmai on 2018/10/24.
//  Copyright © 2018年 洪冬介. All rights reserved.
//

#import "PGTaskListAddView.h"
#import "PGTaskListAddCollectionViewCell.h"

@interface PGTaskListAddView ()<UICollectionViewDelegate,UICollectionViewDataSource,UITextFieldDelegate>

@end

@implementation PGTaskListAddView

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout* flowLayout = [[UICollectionViewFlowLayout alloc] init];
        CGFloat itemWidth = adaptWidth(PGTaskListAddCollectionViewCellSize);
        CGFloat itemHeight = adaptWidth(PGTaskListAddCollectionViewCellSize);
        flowLayout.itemSize = CGSizeMake(itemWidth, itemHeight);
        flowLayout.minimumInteritemSpacing = adaptWidth(PGTaskListAddCollectionViewCellItemSpacing); //项间隔
        flowLayout.minimumLineSpacing = adaptWidth(PGTaskListAddCollectionViewCellLineSpacing); //行间隔
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = WHITE_COLOR;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:[PGTaskListAddCollectionViewCell class] forCellWithReuseIdentifier:@"PGTaskListAddCollectionViewCell"];
    }
    return _collectionView;
}

- (NSArray *)colorArr{
    return @[
             @"1F1F1F",@"606D80",@"2B4C7E",@"567EBB",@"4E7DA6",@"52B5F3",@"599A96",
             @"00927C",@"D25529",@"F35A4A",@"E4736D",@"EAAF13",@"BB780D",@"5B4847"
             ];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView{
    _colorIndex = 0;
    self.hexStr = self.colorArr[_colorIndex];
    
    CGFloat bgW = adaptWidth(300);
    CGFloat bgH = adaptWidth(220);
    UIView *bgView = [UIView new];
    [self addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(0);
        make.width.mas_equalTo(bgW);
        make.height.mas_equalTo(bgH);
    }];
    bgView.backgroundColor = WHITE_COLOR;
    [bgView addRoundMaskWithRoundedRect:CGRectMake(0, 0, bgW, bgH) cornerRadius:PGCornerRadius];
    
    UILabel* titleLab = [UILabel createLabelWithFontSize:adaptFont(15) andTextColor:MAIN_COLOR andText:NSLocalizedString(@"Add Pigo", nil)];
    titleLab.textAlignment = NSTextAlignmentCenter;
    [bgView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(adaptHeight(PGTaskListAddCollectionViewTitleHeight));
    }];
    _titleLab = titleLab;
    
    UIButton* closeBtn = [UIButton new];
    [bgView addSubview:closeBtn];
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.centerY.mas_equalTo(titleLab.mas_centerY);
        make.width.height.mas_equalTo(adaptWidth(PGTaskListAddCollectionViewTitleHeight));
    }];
    [closeBtn setImage:IMAGEForThemeColor(@"icon_close", MAIN_COLOR) forState:UIControlStateNormal];
    
    UIButton* sureBtn = [UIButton new];
    [bgView addSubview:sureBtn];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-0);
        make.centerY.mas_equalTo(titleLab.mas_centerY);
        make.width.height.mas_equalTo(adaptWidth(PGTaskListAddCollectionViewTitleHeight));
    }];
    [sureBtn setImage:IMAGEForThemeColor(@"icon_sure", MAIN_COLOR) forState:UIControlStateNormal];

    UIView* titleLine = [UIView new];
    [bgView addSubview:titleLine];
    titleLine.backgroundColor = MAIN_COLOR;
    [titleLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(titleLab.mas_bottom);
        make.height.mas_equalTo(0.75);
    }];
    
    [bgView addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.right.mas_equalTo(-12);
        make.bottom.mas_equalTo(-20);
        make.height.mas_equalTo(adaptWidth(PGTaskListAddCollectionViewCellSize) + adaptWidth(PGTaskListAddCollectionViewCellSize) + adaptWidth(PGTaskListAddCollectionViewCellLineSpacing));
    }];
    
    UITextField* textField = [UITextField new];
    textField.textAlignment = NSTextAlignmentCenter;
    textField.placeholder = NSLocalizedString(@"Please enter", nil);
    textField.font = [UIFont systemFontOfSize:adaptFont(15)];
    [bgView addSubview:textField];
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.collectionView.mas_left);
        make.right.mas_equalTo(self.collectionView.mas_right);
        make.bottom.mas_equalTo(self.collectionView.mas_top).offset(-adaptWidth(15));
        make.height.mas_equalTo(adaptWidth(30));
    }];
    _textField = textField;
    WS(weakSelf)
    [textField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        weakSelf.titleCont = x;
    }];

    UIView* tfLine = [UIView new];
    [bgView addSubview:tfLine];
    tfLine.backgroundColor = LINE_COLOR_GRAY_DARK;
    [tfLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(textField);
        make.top.mas_equalTo(textField.mas_bottom);
        make.height.mas_equalTo(0.75);
    }];
    
    [closeBtn addTarget:self action:@selector(closeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [sureBtn addTarget:self action:@selector(sureButtonClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.colorArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PGTaskListAddCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PGTaskListAddCollectionViewCell" forIndexPath:indexPath];
    UIColor* color = [UIColor colorWithHexStr:self.colorArr[indexPath.item]];
    cell.contView.backgroundColor = color;
    ((CAShapeLayer*)(cell.borderView.layer.sublayers.firstObject)).strokeColor = (_colorIndex == indexPath.item) ? MAIN_COLOR.CGColor:CLEARCOLOR.CGColor;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSIndexPath* lastIndexPath = [NSIndexPath indexPathForItem:_colorIndex inSection:0];
    _colorIndex = indexPath.item;
    self.hexStr = self.colorArr[indexPath.item];
    [self.collectionView reloadItemsAtIndexPaths:@[lastIndexPath,indexPath]];
}

- (void)sureButtonClick:(UIButton*)sender{
    if ([self.delegate respondsToSelector:@selector(addView:sureButtonDidClick:)]) {
        [self.delegate addView:self sureButtonDidClick:sender];
    }
}

- (void)closeButtonClick:(UIButton*)sender{
    if ([self.delegate respondsToSelector:@selector(addView:closeButtonDidClick:)]) {
        [self.delegate addView:self closeButtonDidClick:sender];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    self.titleCont = textField.text;
}

- (void)clearTextField{
    _textField.text = @"";
    _titleCont = @"";
}

@end
