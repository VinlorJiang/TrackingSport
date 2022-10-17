//
//  UIColor+Common.h
//  trackingsport
//
//  Created by SZDCMAC15 on 2022/10/17.
//

#import <UIKit/UIKit.h>



NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Common)
// ---------------- 改版设计规范 -------------------
//主颜色，字体主色、标题、正文、图标
+ (UIColor *)MainFontColor;
//正文副色 用于事件、摘要文字
+ (UIColor *)DeputyFontColor;
//未填写数值颜色、部分填写线颜色
+ (UIColor *)UnfilledFontColor;

//部分默认背景颜色
+ (UIColor *)MainBackgroundColor;
//分割线的颜色
+ (UIColor *)NewLineColor;

//主色（蓝色）用于App顶部栏标题、文字
+ (UIColor *)MainBlueColor;
//副主色（蓝色）主要使用按钮主功能操作使用
+ (UIColor *)DeputyBlueColor;

//副主色（红色）、小面积使用
+ (UIColor *)DeputyRedColor;

// ---------------- 改版设计规范 -------------------


//用于icon及信息选择引导，按钮激活状态底色
+ (UIColor *)buttonEnabledColor;

//用于重要文字信息,小面积使用
+ (UIColor *)textOrangeColor;

//用于大多数文字信息，填写内容和叙述性内容
+ (UIColor *)textDefaultColor;

//用于辅助性文字颜色
+ (UIColor *)textGrayColor;

//用于导航页面大标题及相关icon
+ (UIColor *)navigationTextColor;

//用于分割线及提示性文字
+ (UIColor *)lineColor;

//用于重要提示性文字及错误提示颜色
+ (UIColor *)textRedColor;

//用于按钮默认状态底色
+ (UIColor *)buttonDefaultColor;

// tableView背景色
+ (UIColor *)tableViewBackgroundColor;

// tableView 线条
+ (UIColor *)tableViewLineColor;


+ (UIColor *)Line2Color;

// searchBar 颜色
+ (UIColor *)searchBarColor;
@end

NS_ASSUME_NONNULL_END
