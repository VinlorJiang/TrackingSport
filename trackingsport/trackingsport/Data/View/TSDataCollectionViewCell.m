//
//  TSDataCollectionViewCell.m
//  trackingsport
//
//  Created by SZDCMAC15 on 2022/10/31.
//

#import "TSDataCollectionViewCell.h"
#import "TSDataModel.h"

@interface TSDataCollectionViewCell ()

@property (strong, nonatomic) UILabel *timeLB;
@property (strong, nonatomic) UILabel *typeLB;
@property (strong, nonatomic) UILabel *gradeLB;
@property (strong, nonatomic) UILabel *numberLB;

@end

@implementation TSDataCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = KRGBColor(50, 197, 244);
        self.cornerRadius = 12.0;
        [self setupUI];
    }
    return self;;
}
- (void)setupUI {
    [self.contentView addSubview:self.timeLB];
    [self.contentView addSubview:self.typeLB];
    [self.contentView addSubview:self.gradeLB];
    [self.contentView addSubview:self.numberLB];
}

- (UILabel *)timeLB {
    if (!_timeLB) {
        _timeLB = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height/4)];
        _timeLB.textColor = WhiteColor;
        _timeLB.textAlignment = NSTextAlignmentCenter;
    }
    return _timeLB;
}
- (UILabel *)typeLB {
    if (!_typeLB) {
        _typeLB = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height/4, self.frame.size.width, self.frame.size.height/4)];
        _typeLB.textColor = WhiteColor;
        _typeLB.textAlignment = NSTextAlignmentCenter;
        _typeLB.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    }
    return _typeLB;
}

- (UILabel *)gradeLB {
    if (!_gradeLB) {
        _gradeLB = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height/4*2, self.frame.size.width, self.frame.size.height/4)];
        _gradeLB.textColor = WhiteColor;
        _gradeLB.textAlignment = NSTextAlignmentCenter;
        _gradeLB.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    }
    return _gradeLB;
}
- (UILabel *)numberLB {
    if (!_numberLB) {
        _numberLB = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height/4*3, self.frame.size.width, self.frame.size.height/4)];
        _numberLB.textColor = WhiteColor;
        _numberLB.textAlignment = NSTextAlignmentCenter;
    }
    return _numberLB;
}


- (void)setModel:(TSDataModel *)model {
    _model = model;
    self.timeLB.text = _model.timeStr;
    self.typeLB.text = _model.tyepeStr;
    self.gradeLB.text = _model.gradeStr;
    self.numberLB.text = _model.numberStr;
}

@end
