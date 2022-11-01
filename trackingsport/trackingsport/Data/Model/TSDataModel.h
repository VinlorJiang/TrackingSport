//
//  TSDataModel.h
//  trackingsport
//
//  Created by SZDCMAC15 on 2022/10/31.
//

#import "TSBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSDataModel : TSBaseModel
@property (strong, nonatomic) NSString *timeStr;
@property (strong, nonatomic) NSString *tyepeStr;
@property (strong, nonatomic) NSString *gradeStr;
@property (strong, nonatomic) NSString *numberStr;
@end


NS_ASSUME_NONNULL_END
