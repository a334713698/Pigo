//
//  PGTaskListCollectionViewCell.m
//  pigoWidget
//
//  Created by quanmai on 2019/1/4.
//  Copyright © 2019 洪冬介. All rights reserved.
//

#import "PGTaskListCollectionViewCell.h"

@implementation PGTaskListCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView{
    self.backgroundColor = [UIColor yellowColor];
    [self addRoundMaskWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadius:5];
    CGFloat labX = 12;
    CGFloat labW = self.frame.size.width - labX * 2;
    CGFloat labH = self.frame.size.height;
    _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(labX, 0, labW, labH)];
    _titleLab.textColor = WHITE_COLOR;
    _titleLab.font = [UIFont systemFontOfSize:adaptFont(14)];
    [self addSubview:_titleLab];
}

- (void)setTaskModel:(PGTaskListModel *)taskModel{
    _taskModel = taskModel;
    self.backgroundColor = [self colorWithHexStr:taskModel.bg_color];
    _titleLab.text = taskModel.task_name;
//    [self setLabelShadow:_titleLab content:taskModel.task_name];
}

//加圆角遮罩。可选择某个角
- (void)addRoundMaskWithRoundedRect:(CGRect)rect byRoundingCorners:(UIRectCorner)corners cornerRadius:(CGFloat)cornerRadius{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = CGRectMake(0, 0, rect.size.width, rect.size.height);
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

- (UIColor*)colorWithHexStr:(NSString*)HexStr{
    UIColor* color = QMColorFromRGB(strtol([HexStr UTF8String],NULL,16));
    return color;
}

- (void)setLabelShadow:(UILabel*)lab content:(NSString*)cont{
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:cont];
    
    NSShadow* shadow = [NSShadow new];
    shadow.shadowBlurRadius = 2;
    shadow.shadowColor = BLACK_COLOR;
    shadow.shadowOffset = CGSizeMake(0, 0);
    [attributedString addAttribute:NSShadowAttributeName value:shadow range:NSMakeRange(0, cont.length)];
    
    [lab setAttributedText:attributedString];
}


@end
