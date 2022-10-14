//
//  TSStudentTestView.h
//  trackingsport
//
//  Created by SZDCMAC15 on 2022/10/13.
//

#import "TSBaseView.h"

NS_ASSUME_NONNULL_BEGIN
@class TSStudentTestModel;
@protocol TSStudentTestViewClickDelegate <NSObject>

- (void)click:(TSStudentTestModel *)model index:(NSInteger)index;


@end
@interface TSStudentTestView : TSBaseView

@property (nonatomic,weak)id <TSStudentTestViewClickDelegate>stuTestViewClickDelegate;

- (instancetype)initWithFrame:(CGRect)frame dataSource:(NSMutableArray<TSStudentTestModel *> *)dataSource;
@end

NS_ASSUME_NONNULL_END
