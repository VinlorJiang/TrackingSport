//
//  TSTrainView.h
//  trackingsport
//
//  Created by SZDCMAC15 on 2022/10/13.
//

#import "TSBaseView.h"

NS_ASSUME_NONNULL_BEGIN
typedef void (^TrainingTypeBlock)(UIButton *type);

@interface TSTrainView : TSBaseView

@property (copy, nonatomic) TrainingTypeBlock trainingTypeBlock;

- (instancetype)initWithFrame:(CGRect)frame textArray:(NSArray *)textArray;

@end

NS_ASSUME_NONNULL_END
