//
//  TSTaskHeaderModel.h
//  trackingsport
//
//  Created by SZDCMAC15 on 2022/10/24.
//

#import "TSBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSTaskHeaderModel : TSBaseModel
/// 累计作业数
@property (strong, nonatomic) NSString *accumulatedHomework;
/// 累计完成作业数
@property (strong, nonatomic) NSString *accumulatedCompletedHomework;
/// 进行中作业数
@property (strong, nonatomic) NSString *underwayHomework;
/// 进行中完成率
@property (strong, nonatomic) NSString *underwayFinshedRateHomework;
@end

NS_ASSUME_NONNULL_END
