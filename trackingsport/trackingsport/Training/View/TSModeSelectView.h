//
//  TSModeSelectView.h
//  trackingsport
//
//  Created by SZDCMAC15 on 2022/11/17.
//

#import "TSBaseView.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^BackBlock)(void);

@interface TSModeSelectView : TSBaseView
@property (strong, nonatomic) UIButton *backBtn;
@property (copy, nonatomic) BackBlock backBlock;
- (instancetype)initWithFrame:(CGRect)frame;
@end

NS_ASSUME_NONNULL_END
