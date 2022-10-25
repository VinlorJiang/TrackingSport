//
//  TSTaskViewCell.m
//  trackingsport
//
//  Created by SZDCMAC15 on 2022/10/25.
//

#import "TSTaskViewCell.h"



@interface TSTaskViewCell ()
@property (assign, nonatomic) CGFloat itemW;
@property (assign, nonatomic) CGFloat itemH;
@property (strong, nonatomic) UIView *topView;
@property (strong, nonatomic) UIImageView *projectIcon;
@property (strong, nonatomic) UILabel *gradeLB;
@property (strong, nonatomic) UILabel *contentLB;
@property (strong, nonatomic) UILabel *completedRateLB;
@property (strong, nonatomic) UILabel *latestLB;
@property (strong, nonatomic) UILabel *statusLB;
@property (strong, nonatomic) UIView *bottomView;
@end

@implementation TSTaskViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = WhiteColor;
        self.itemH = 60;
        self.itemW = (KScreenWidth-KLeftContentViewW-kTaskViewLatestCompltedViewW-kTaskViewLeftSpace*2)/6;
        [self setupUI];
    }
    return self;
}
- (void)setupUI {
    [self.contentView addSubview:self.topView];
    [self.contentView addSubview:self.bottomView];
    [self.topView addSubview:self.projectIcon];
    [self.topView addSubview:self.gradeLB];
    [self.topView addSubview:self.contentLB];
    [self.topView addSubview:self.completedRateLB];
    [self.topView addSubview:self.latestLB];
    [self.topView addSubview:self.statusLB];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (UIView *)topView {
    if (!_topView) {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.itemW*6, self.itemH-10)];
        _topView.backgroundColor = TSBackgroundColor;
        _topView.cornerRadius = 10;
    }
    return _topView;
}

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.itemH-10, self.itemW*6, 10)];
        _bottomView.backgroundColor = ClearColor;
    }
    return _bottomView;;
}
- (UIImageView *)projectIcon {
    if (!_projectIcon) {
        UIImage *image = [UIImage imageNamed:@"默认头像"];
        _projectIcon = [[UIImageView alloc] initWithFrame:CGRectMake((self.itemW - 30) / 2, 5, 30, 30)];
        _projectIcon.image = image;
    }
    return _projectIcon;
}
- (UILabel *)gradeLB {
    if (!_gradeLB) {
        _gradeLB = [[UILabel alloc] initWithFrame:CGRectMake(self.itemW, 0, self.itemW, self.itemH)];
        _gradeLB.text = @"四年级一班";
        _gradeLB.textAlignment = NSTextAlignmentCenter;
    }
    return _gradeLB;
}

- (UILabel *)contentLB {
    if (!_contentLB) {
        _contentLB = [[UILabel alloc] initWithFrame:CGRectMake(self.itemW*2, 0, self.itemW, self.itemH)];
        _contentLB.text = @"0min/1个";
        _contentLB.textAlignment = NSTextAlignmentCenter;
    }
    return _contentLB;
}

- (UILabel *)completedRateLB {
    if (!_completedRateLB) {
        _completedRateLB = [[UILabel alloc] initWithFrame:CGRectMake(self.itemW*3, 0, self.itemW, self.itemH)];
        _completedRateLB.text = @"0%";
        _completedRateLB.textAlignment = NSTextAlignmentCenter;
    }
    return _completedRateLB;
}

- (UILabel *)latestLB {
    if (!_latestLB) {
        _latestLB = [[UILabel alloc] initWithFrame:CGRectMake(self.itemW*4, 0, self.itemW, self.itemH)];
        _latestLB.text = @"2022-09-28";
        _latestLB.textAlignment = NSTextAlignmentCenter;
    }
    return _latestLB;
}

- (UILabel *)statusLB {
    if (!_statusLB) {
        _statusLB = [[UILabel alloc] initWithFrame:CGRectMake(self.itemW*5, 0, self.itemW, self.itemH)];
        _statusLB.text = @"未完成";
        _statusLB.textAlignment = NSTextAlignmentCenter;
    }
    return _statusLB;
}
@end
