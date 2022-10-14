//
//  UIButton+Common.h
//  trackingsport
//
//  Created by SZDCMAC15 on 2022/10/12.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (Common)

@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) CGFloat respondTime;
@property (nonatomic, assign) BOOL isRequestting;

/** 点击 block*/
- (void)blockWithControlEventTouchUpInsideWithBlock:(void (^)(void))block;

/** 垂直对齐
    图片字体上下对齐
    先设置frame且图片大小 < button 否则会盖住
 */
- (void)alineImageAndTitle:(CGFloat)space;

/**  左字右图 */
- (void)horizontalCenterTitleAndImage:(CGFloat)space;
- (void)horizontalCenter_Alignmen_Image:(CGFloat)space contentHorizontalAlignment:(UIControlContentHorizontalAlignment)Alignment;

/**  左图右字  space 图片的间隔   T_space 字离图片的距离  */
- (void)horizontalCenter_Alignmen_Image:(CGFloat)space title:(CGFloat)T_space;

/** 扩大Button的点击范围 */
- (void)setEnlargeEdgeWithTop:(CGFloat)top left:(CGFloat)left right:(CGFloat)right bottom:(CGFloat)bottom;

/** 点击效果 */
- (void)setHighlightColor;
@end
@interface UIControl (Common)
/** 点击 block*/
- (void)blockWithControlEventTouchUpInsideWithBlock:(void (^)(void))block;

@end
NS_ASSUME_NONNULL_END
