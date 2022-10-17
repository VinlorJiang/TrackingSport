//
//  CALayer+Common.h
//  trackingsport
//
//  Created by SZDCMAC15 on 2022/10/17.
//

#import <QuartzCore/QuartzCore.h>

NS_ASSUME_NONNULL_BEGIN

@interface CALayer (Common)
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) CGFloat right;
@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat bottom;
@property (nonatomic, strong) UIImage *image;

+ (CALayer *)layerWithFrame:(CGRect)frame;

/** 去掉隐式动画 */
+ (void)removeImplicitanimationWithBlock:(void (^)(void))block;
/** 线条 */
+ (CALayer *)layerWidthY:(CGFloat)y;
@end
NS_ASSUME_NONNULL_END
