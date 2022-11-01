//
//  TSDataCollectionViewCell.h
//  trackingsport
//
//  Created by SZDCMAC15 on 2022/10/31.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class TSDataModel;
@interface TSDataCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) TSDataModel *model;
@end

NS_ASSUME_NONNULL_END
