//
//  PGStatisticsAnnualActivityViewController.m
//  iOSProjectFramework
//
//  Created by quanmai on 2018/10/19.
//  Copyright © 2018年 洪冬介. All rights reserved.
//

#import "PGStatisticsAnnualActivityViewController.h"

@interface PGStatisticsAnnualActivityViewController ()

@property (nonatomic, strong) UILabel *contLab;

@end

@implementation PGStatisticsAnnualActivityViewController

- (UILabel *)contLab{
    if (!_contLab) {
        _contLab = [UILabel createLabelWithFontSize:adaptFont(12) andTextColor:TEXT_BACKGROUND_COLOR_LIGHT andText:@""];
        [self.view addSubview:_contLab];
        [_contLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(0);
        }];
    }
    return _contLab;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = MAIN_COLOR;
    //修改当前控制器的内容大小，设置好以后，在其他控制器弹出来，就只有这么大
    self.preferredContentSize = CGSizeMake(150, 35);
}

- (void)setContentWithTomatCount:(NSInteger)count andDateStr:(NSString*)dateStr{
    NSString* countStr = [NSString stringWithFormat:@"%ld %@",count,NSLocalizedString(@"Pigos", nil)];
    NSString* text = [NSString stringWithFormat:@"%@ on %@",countStr,dateStr];
    
    CGFloat w = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.contLab.font} context:NULL].size.width;
    self.preferredContentSize = CGSizeMake(w + 2 * 12, 35);
    [self.contLab setLabelText:text Color:WHITE_COLOR Range:NSMakeRange(0, countStr.length)];
}


@end
