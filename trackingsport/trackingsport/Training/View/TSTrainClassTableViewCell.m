//
//  TSTrainClassTableViewCell.m
//  trackingsport
//
//  Created by SZDCMAC15 on 2022/11/16.
//

#import "TSTrainClassTableViewCell.h"

@implementation TSTrainClassTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = WhiteColor;
        [self setupUI];
    }
    return self;
}
- (void)setupUI {
    UILabel *classLB = [UILabel new];
    classLB.frame = CGRectMake(0, 0, 164, 30);
    classLB.textColor = BlueColor;
    [self.contentView addSubview:classLB];
    self.classLB = classLB;
    classLB.textAlignment = NSTextAlignmentCenter;
    classLB.font = [UIFont systemFontOfSize:Kfont10];
}
@end
