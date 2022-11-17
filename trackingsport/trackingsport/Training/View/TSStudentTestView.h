//
//  TSStudentTestView.h
//  trackingsport
//
//  Created by SZDCMAC15 on 2022/10/13.
//

#import "TSBaseView.h"

NS_ASSUME_NONNULL_BEGIN
typedef void (^TrainingTypeBlock)(UIButton *type);

@class TSStudentTestModel;
@protocol TSStudentTestViewClickDelegate <NSObject>

- (void)click:(TSStudentTestModel *)model index:(NSInteger)index;


@end
@interface TSStudentTestView : TSBaseView

@property (copy, nonatomic) TrainingTypeBlock trainingTypeBlock;

@property (nonatomic,weak)id <TSStudentTestViewClickDelegate>stuTestViewClickDelegate;

- (instancetype)initWithFrame:(CGRect)frame
                    textArray:(NSArray *)textArray
                   dataSource:(NSMutableArray<TSStudentTestModel *> *)dataSource;
@end

NS_ASSUME_NONNULL_END
