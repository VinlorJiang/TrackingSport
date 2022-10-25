//
//  TSTaskCompletedCell.m
//  trackingsport
//
//  Created by SZDCMAC15 on 2022/10/25.
//

#import "TSTaskCompletedCell.h"

@interface TSTaskCompletedCell ()
@property (weak, nonatomic) IBOutlet UIImageView *portant;
@property (weak, nonatomic) IBOutlet UILabel *gradeLB;
@property (weak, nonatomic) IBOutlet UILabel *numberLB;
@property (weak, nonatomic) IBOutlet UILabel *typeLB;
@property (weak, nonatomic) IBOutlet UILabel *dateLB;
@property (weak, nonatomic) IBOutlet UILabel *timeLB;
@property (weak, nonatomic) IBOutlet UILabel *bottomLine;


@end

@implementation TSTaskCompletedCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = TSBackgroundColor;
    
    [self setupUI];
}

- (void)setupUI {
    self.gradeLB.textColor = LightGrayColor;
    self.gradeLB.font = [UIFont systemFontOfSize:Kfont16];
    
    self.numberLB.textColor = KRGBColor(26, 166, 243);
    self.numberLB.font = [UIFont systemFontOfSize:Kfont16];
    
    self.typeLB.textColor = BlackColor;
    self.typeLB.font = [UIFont systemFontOfSize:Kfont16];
    
    self.dateLB.textColor = LightGrayColor;
    self.dateLB.font = [UIFont systemFontOfSize:Kfont16];
    
    self.timeLB.textColor = LightGrayColor;
    self.timeLB.font = [UIFont systemFontOfSize:Kfont16];
    
    self.bottomLine.backgroundColor = LightGrayColor;
//    self.bottomLine.height = 1;
    self.bottomLine.text = @"";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
