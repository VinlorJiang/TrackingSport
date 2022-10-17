//
//  UIColor+Common.m
//  trackingsport
//
//  Created by SZDCMAC15 on 2022/10/17.
//

#import "UIColor+Common.h"

#define INIT_COLOR(hexStr) \
static UIColor *c = nil; \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
c = color_hex(hexStr) ;\
}); \
return c;

@implementation UIColor (Common)
// ---------------- 改版设计规范 -------------------
+ (UIColor *)MainFontColor {
    INIT_COLOR(@"#313A54");
}
//正文副色 用于事件、摘要文字
+ (UIColor *)DeputyFontColor
{
    INIT_COLOR(@"#6E7587");
}
//未填写数值颜色、部分填写线颜色
+ (UIColor *)UnfilledFontColor
{
    INIT_COLOR(@"#AFB9D3");
}

//部分默认背景颜色
+ (UIColor *)MainBackgroundColor
{
    INIT_COLOR(@"#F5F5F5");
}
//分割线的颜色
+ (UIColor *)NewLineColor {
    INIT_COLOR(@"#D9D9D9");
}

//主色（蓝色）用于App顶部栏标题、文字
+ (UIColor *)MainBlueColor{
    INIT_COLOR(@"#165CDB");
}
//副主色（蓝色）主要使用按钮主功能操作使用
+ (UIColor *)DeputyBlueColor{
    INIT_COLOR(@"#4D88FB");
}

//副主色（红色）、小面积使用
+ (UIColor *)DeputyRedColor{
    INIT_COLOR(@"#EF2231");
}
// ---------------- 改版设计规范 -------------------

+ (UIColor *)buttonDefaultColor {
    INIT_COLOR(@"#bde6fc");
}

+ (UIColor *)buttonEnabledColor {
    INIT_COLOR(@"#26abf4");
}

+ (UIColor *)textOrangeColor {
    INIT_COLOR(@"#f6831d");
}

+ (UIColor *)textDefaultColor {
    INIT_COLOR(@"#313A54");
//    INIT_COLOR(@"#383838");
}

+ (UIColor *)textGrayColor {
     INIT_COLOR(@"#6E7587");
//    INIT_COLOR(@"#a0a0a0");
}

+ (UIColor *)navigationTextColor {
    INIT_COLOR(@"#646464");
}

+ (UIColor *)Line2Color {
    INIT_COLOR(@"#d2d2d2");
}

+ (UIColor *)lineColor {
    INIT_COLOR(@"#0069f3");
}

+ (UIColor *)textRedColor {
//    INIT_COLOR(@"#f84145");
    INIT_COLOR(@"#EF2231");
}
+ (UIColor *)tableViewBackgroundColor {
    INIT_COLOR(@"#f5f4fa");
}
+ (UIColor *)tableViewLineColor {
    INIT_COLOR(@"#e6e6e6");
}

+ (UIColor *)searchBarColor {
    return KRGBColor(223, 223, 226);
}
#undef INIT_COLOR
@end
