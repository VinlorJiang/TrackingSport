//
//  TSSettingViewCell.m
//  trackingsport
//
//  Created by SZDCMAC15 on 2022/10/18.
//

#import "TSSettingViewCell.h"

@implementation TSSettingViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}
- (void)setupUI {
    CGFloat cellW = KScreenWidth-KLeftContentViewW - 60;
    _textLB = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, cellW - 150, 55)];
    _textLB.backgroundColor = ClearColor;
    _textLB.textColor = BlackColor;
    _textLB.font = [UIFont systemFontOfSize:Kfont18];
    [self.contentView addSubview:self.textLB];
    
    _detailLB = [[UILabel alloc] initWithFrame:CGRectMake(cellW - 40 - 120, 0, 120, 55)];
    _detailLB.backgroundColor = ClearColor;
    _detailLB.textColor = BlackColor;
    _detailLB.font = [UIFont systemFontOfSize:Kfont16];
    _detailLB.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.detailLB];
    
    _bottomLine = [[UILabel alloc] initWithFrame:CGRectMake(20, 54.5, cellW -20, 0.5)];
    _bottomLine.backgroundColor = KRGBColor(205, 216, 223);
    [self.contentView addSubview:self.bottomLine];
}

@end
