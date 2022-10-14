//
//  TSStudentTestCollectionViewCell.h
//  trackingsport
//
//  Created by SZDCMAC15 on 2022/10/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class TSStudentTestModel;
@interface TSStudentTestCollectionViewCell : UICollectionViewCell

@property(nonatomic, strong) TSStudentTestModel *testModel;

@property (weak, nonatomic) IBOutlet UILabel *typeLB;
@property (weak, nonatomic) IBOutlet UILabel *gradeLB;
@property (weak, nonatomic) IBOutlet UIImageView *arrowIV;

@end

NS_ASSUME_NONNULL_END
