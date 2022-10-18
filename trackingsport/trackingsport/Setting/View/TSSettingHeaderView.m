//
//  TSSettingHeaderView.m
//  trackingsport
//
//  Created by SZDCMAC15 on 2022/10/18.
//

#import "TSSettingHeaderView.h"

@interface TSSettingHeaderView ()
@property (strong, nonatomic) UIView *topView;
@property (strong, nonatomic) UIImageView *headerIcon;
@property (strong, nonatomic) UILabel *nameLB;
@property (strong, nonatomic) UILabel *idLabel;
@end


@implementation TSSettingHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}
- (void)setupUI {
    [self addSubview:self.topView];
    [self.topView addSubview:self.headerIcon];
    [self.topView addSubview:self.nameLB];
    [self.topView addSubview:self.idLabel];
}

- (UIView *)topView {
    if (!_topView) {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,self.width, self.height-30)];
        _topView.backgroundColor = KRGBColor(49, 187, 243);
        _topView.cornerRadius = 20;
    }
    return _topView;
}


- (UIImageView *)headerIcon {
    if (!_headerIcon) {
        _headerIcon = [[UIImageView alloc] initWithFrame:CGRectMake(20, (_topView.height - 60)*0.5, 60, 60)];
        _headerIcon.image = [UIImage imageNamed:@"默认头像"];
        _headerIcon.cornerRadius = _headerIcon.width * 0.5;
    }
    return _headerIcon;
}

- (UILabel *)nameLB {
    if (!_nameLB) {
        _nameLB = [[UILabel alloc] init];
        _nameLB.text = @"马小师";;
        _nameLB.textColor = WhiteColor;
        _nameLB.font = [UIFont systemFontOfSize:Kfont12];
        _nameLB.top = self.headerIcon.top;
        _nameLB.left = self.headerIcon.right + 10;
        _nameLB.width = 80;
        _nameLB.height = 20;
    }
    return _nameLB;
}

- (UILabel *)idLabel {
    if (!_idLabel) {
        _idLabel = [[UILabel alloc] init];
        _idLabel.text = @"ID ：635";;
        _idLabel.textColor = WhiteColor;
        _idLabel.font = [UIFont systemFontOfSize:Kfont12];
        _idLabel.top = self.nameLB.bottom + 6;
        _idLabel.left = self.headerIcon.right + 10;
        _idLabel.width = 80;
        _idLabel.height = 20;
    }
    return _idLabel;
}
@end
