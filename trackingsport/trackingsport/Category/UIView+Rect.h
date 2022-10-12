//
//  UIView+Rect.h
//  trackingsport
//
//  Created by SZDCMAC15 on 2022/10/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Rect)

/** 获取size的值 */
@property (nonatomic, assign) CGSize size;

/** 获取origin的值 */
@property (nonatomic, assign) CGPoint origin;

/** 获取width宽度 */
@property (nonatomic, assign) CGFloat width;

/** 获取height高度 */
@property (nonatomic, assign) CGFloat height;

/** 获取x的值 */
@property (nonatomic, assign) CGFloat left;

/** 获取y的值 */
@property (nonatomic, assign) CGFloat top;

/** 获取x+width的值 */
@property (nonatomic, assign) CGFloat right;

/** 获取y+height的值 */
@property (nonatomic, assign) CGFloat bottom;

/** centerX */
@property (nonatomic, assign) CGFloat centerX;

/** centerY */
@property (nonatomic, assign) CGFloat centerY;

@property (nonatomic, assign) CGFloat cornerRadius;

@end

NS_ASSUME_NONNULL_END
