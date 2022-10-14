//
//  TSStudentTestCollectionViewCell.m
//  trackingsport
//
//  Created by SZDCMAC15 on 2022/10/14.
//

#import "TSStudentTestCollectionViewCell.h"
#import "TSStudentTestModel.h"

@implementation TSStudentTestCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
   
    self.backgroundColor = LightGrayColor;
}

- (void)setTestModel:(TSStudentTestModel *)testModel {
    _testModel = testModel;
    self.typeLB.text = testModel.typeStr;
    self.gradeLB.text = testModel.gradeStr;
    
}
- (UICollectionViewLayoutAttributes *)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes{
    [self setNeedsLayout];
    [self layoutIfNeeded];
    CGSize size = [self.contentView systemLayoutSizeFittingSize: layoutAttributes.size];
    CGRect cellFrame = layoutAttributes.frame;
    cellFrame.size.height= size.height;
    layoutAttributes.frame= cellFrame;
    return layoutAttributes;
}
@end
