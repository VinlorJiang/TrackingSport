//
//  TSHandyColorTool.h
//  trackingsport
//
//  Created by SZDCMAC15 on 2022/10/17.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>




#define Kfont18  18
#define Kfont17  17
#define Kfont16  16
#define Kfont15  15
#define Kfont14  14
#define Kfont13  13
#define Kfont12  12
#define Kfont11  11
#define Kfont10  10

/*!
 *  @author DT
 *
 *  @brief  简便代码写法
 */
#define Kfont18  18
#define Kfont17  17
#define Kfont16  16
#define Kfont15  15
#define Kfont14  14
#define Kfont13  13
#define Kfont12  12
#define Kfont11  11
#define Kfont10  10

#pragma mark - UIColor

#pragma mark 根据rgb获取颜色
/*!
 *  @author DT
 *
 *  @brief  根据rgb获取颜色
 *
 *  @param r 红色值
 *  @param g 绿色值
 *  @param b 蓝色值
 *
 *  @return UIColor
 */
UIColor* color_rgb(NSInteger r, NSInteger g, NSInteger b);

#pragma mark 根据rgb和透明度获取颜色
/*!
 *  @author DT
 *
 *  @brief  根据rgb获取颜色
 *
 *  @param r 红色值
 *  @param g 绿色值
 *  @param b 蓝色值
 *  @param a 透明值
 *
 *  @return UIColor
 */
UIColor* color_rgba(NSInteger r, NSInteger g, NSInteger b, CGFloat a);

#pragma mark 获取黑色
/*!
 *  @author DT
 *
 *  @brief  获取黑色
 *
 *  @return UIColor
 */
UIColor* color_black();

#pragma mark 获取黑色(可以设置透明度)
/*!
 *  @author DT
 *
 *  @brief  获取黑色,可以设置透明度
 *
 *  @param alpha 透明度
 *
 *  @return UIColor
 */
UIColor* color_black_alpha(CGFloat alpha);

#pragma mark 获取灰色
/*!
 *  @author DT
 *
 *  @brief  获取灰色
 *
 *  @return UIColor
 */


UIColor* color_gray();

#pragma mark 获取--背景颜色 （0.5的透明灰色）
/*!
 *  @author DT
 *
 *  @brief  获取灰色
 *
 *  @return UIColor
 */
UIColor* color_gray_toback() ;


#pragma mark 获取灰色(可以设置透明度)
/*!
 *  @author DT
 *
 *  @brief  获取灰色(可以设置透明度)
 *
 *  @param alpha 透明度
 *
 *  @return UIColor
 */
UIColor* color_gray_alpha(CGFloat alpha);

#pragma mark 获取白色
/*!
 *  @author DT
 *
 *  @brief  获取白色
 *
 *  @return UIColor
 */
UIColor* color_white();

#pragma mark 获取白色(可以设置透明度)
/*!
 *  @author DT
 *
 *  @brief  获取白色(可以设置透明度)
 *
 *  @param alpha 透明度
 *
 *  @return UIColor
 */
UIColor* color_white_alpha(CGFloat alpha);

#pragma mark 获取无色
/*!
 *  @author DT
 *
 *  @brief  获取无色
 *
 *  @return UIColor
 */
UIColor* color_clear();

#pragma mark 获取16进制颜色
/*!
 *  @author DT
 *
 *  @brief  获取16进制颜色
 *
 *  @param hex 16进制颜色字符串
 *
 *  @return UIColor
 */
UIColor* color_hex(NSString* hex);
/*!
 *  @author DT
 *
 *  @brief  获取16进制颜色
 *
 *  @param hex 16进制颜色字符串
 *  alpha  透明度
 *  @return UIColor
 
 */
UIColor* color_hex_alpha(NSString* hex, CGFloat aaa );

//1.6.3+
/**
 *  六种颜色规范
 *
 *  @return <#return value description#>
 */
UIColor* color_FirstView();
UIColor* color_selectBlue() ;
UIColor* color_lightBlue();
UIColor* color_red();
UIColor* color_custemGray();
UIColor* color_green();
UIColor* color_blue();
UIColor* color_lightGray();

/**
 *  2.0.0 版本颜色
 *
 *  @param size <#size description#>
 *
 *  @return <#return value description#>
 */
UIColor *color_525252();
// 纯白色
UIColor *color_FFFFFF();
// 分割线灰色
UIColor *color_E6E6E6() ;
// 灰色字体
UIColor *color_A0A0A0() ;
// 右按钮白色
UIColor *color_FEFEFE();
// 首页背景颜色
UIColor *color_F5F5F5();
// 背景颜色
UIColor *color_F4F4F9() ;
// 理财大字体颜色
UIColor *color_383838();

#pragma mark - UIFont



#pragma mark 获取常规字体
/*!
 *  @author DT
 *
 *  @brief  获取字体
 *
 *  @param size 字号
 *
 *  @return UIFont
 */
UIFont* font_sys(CGFloat size);

UIFont* font_bold(CGFloat size);

#pragma mark - UIImage

#pragma mark 获取图片
/*!
 *  @author DT
 *
 *  @brief  获取图片
 *
 *  @param name 图片名称
 *
 *  @return UIImage
 */
UIImage* image_name(NSString* name);

#pragma mark 获取纯色图片
/*!
 *  @author DT
 *
 *  @brief  获取纯色图片
 *
 *  @param color 颜色值
 *
 *  @return UIImage
 */
UIImage* image_color(UIColor* color);

#pragma mark - NSString

#pragma mark - int转化为string
NSString *string_i(int x);

#pragma mark - long转化为string
NSString *string_l(long x);

#pragma mark - float转化为string
NSString *string_f(float x);

#pragma mark 拼接字符串
/*!
 *  @author DT
 *
 *  @brief  拼接字符串
 *
 *  @param string,... 字符串值,不固定值,必须nil结尾
 *
 *  @return NSString
 */
NSString* string_format(NSString* string, ...);

#pragma mark 比较字符串是否相等
/*!
 *  @author DT
 *
 *  @brief  比较字符串是否相等
 *
 *  @param string1 字符串1
 *  @param string2 字符串2
 *
 *  @return 相等的话YES,不相等的话NO
 */
BOOL string_equal(NSString* string1, NSString* string2);

#pragma mark - NSNotificationCenter

#pragma mark - 发送通知
/*!
 *  @author DT, 15-09-03 23:09:41
 *
 *  @brief  发送通知
 *
 *  @param name   通知名称
 *  @param object 通知参数
 */
void notification_post(NSString* name, id object);

#pragma mark - 监听通知
/*!
 *  @author DT, 15-09-03 23:09:23
 *
 *  @brief  监听通知
 *
 *  @param observer 监听对象
 *  @param selector 监听事件
 *  @param name     通知名称
 *  @param object   通知参数
 */
void notification_add(id observer, SEL selector, NSString* name, id object);

#pragma mark - 删除通知
/*!
 *  @author DT, 15-09-03 23:09:11
 *
 *  @brief  删除通知
 *
 *  @param observer 监听对象
 *  @param name     通知名称
 *  @param object   通知参数
 */
void notification_remove(id observer, NSString* name, id object);

#pragma mark - NSIndexPath

#pragma mark 创建NSIndexPath对象
/*!
 *  @author DT
 *
 *  @brief  创建NSIndexPath对象
 *
 *  @param row
 *  @param section
 *
 *  @return NSIndexPath
 */
NSIndexPath* indexPath_row_section(NSInteger row, NSInteger section);

#pragma mark - NSArray

#pragma mark 创建NSArray对象
NSArray* Array();

#pragma mark - NSMutableArray

#pragma mark 创建NSMutableArray对象
NSMutableArray* MutableArray();

#pragma mark - NSDictionary

#pragma mark 创建NSDictionary对象
NSDictionary* Dictionary();

#pragma mark - NSMutableArray

#pragma mark 创建NSMutableDictionary对象

NSMutableDictionary* MutableDictionary();

#pragma mark - system

#pragma mark 返回设备屏幕宽度
CGFloat sys_screen_width();

#pragma mark 返回社保屏幕高度
CGFloat sys_screen_height();

#pragma mark 返回设备总的容量大小
/**
 *  @Author DT
 *
 *  @brief  返回设备总的容量大小
 *
 *  @return 容量大小,单位为GB
 */
CGFloat sys_total_disk_space();

#pragma mark 返回设备当前可用的容量大小
/**
 *  @Author DT
 *
 *  @brief  返回设备当前可用的容量大小,跟系统的有点出入
 *
 *  @return 容量大小,单位为MB
 */
CGFloat sys_free_disk_space();

#pragma mark 返回系统可以使用的内存大小
/**
 *  @Author DT
 *
 *  @brief  返回系统可以使用的内存的大小
 *
 *  @return 内存大小,单位为MB
 */
CGFloat sys_available_memory();

#pragma mark 返回应用当前使用的内存的大小
/**
 *  @Author DT
 *
 *  @brief  返回应用当前使用的内存的大小
 *
 *  @return 内存大小,单位为MB
 */
CGFloat sys_used_memory();

#pragma mark 获取应用程序名称
/**
 *  @Author DT
 *
 *  @brief 获取APP名称,使用CFBundleDisplayName
 *
 *  @return 名称
 */
NSString* sys_name();

#pragma mark 获取应用程序APP名称
/**
 *  @Author DT
 *
 *  @brief 获取APP项目名称
 *
 *  @return 项目名称
 */
NSString* sys_project_name();

#pragma mark 获取应用程序包名
/**
 *  @Author DT
 *
 *  @brief 获取APP项目包名
 *
 *  @return 包名
 */
NSString* sys_bundle_name();

#pragma mark 获取应用程序Bundle Identifier
/**
 *  @Author DT
 *
 *  @brief 获取APP项目Bundle Identifier
 *
 *  @return Bundle Identifier
 */
NSString* sys_identifier();

#pragma mark 获取应用程序版本号
/**
 *  @Author DT
 *
 *  @brief 获取APP项目版本
 *
 *  @return Version
 */
NSString* sys_version();

#pragma mark 获取应用程序Build
/**
 *  @Author DT
 *
 *  @brief 获取APP项目Build
 *
 *  @return Build
 */
NSString* sys_build();

#pragma mark 获取设备的硬件名称
/**
 *  @Author DT
 *
 *  @brief  获取设备的硬件名称
 *
 *  @return 硬件名称
 */
NSString* sys_current_device_information();

#pragma mark 获取设备关于本机名称
/**
 *  @Author DT
 *
 *  @brief 获取设备名称(关于本机 - 名称)
 *
 *  @return 名称
 */
NSString* sys_device_name();

#pragma mark 获取设备系统名称
/**
 *  @Author DT
 *
 *  @brief 获取设备系统名称(iPhone OS or iPod OS)
 *
 *  @return 系统名称
 */
NSString* sys_device_system_name();

#pragma mark 获取设备系统版本
/**
 *  @Author DT
 *
 *  @brief 获取设备系统版本
 *
 *  @return 系统版本
 */
NSString* sys_device_version();

#pragma mark 获取设备系统类型
/**
 *  @Author DT
 *
 *  @brief 获取设备系统类型(iPhone os iPod touch)
 *
 *  @return 系统类型
 */
NSString* sys_device_model();

#pragma mark 获取设备系统语言
/**
 *  @Author DT
 *
 *  @brief 获取设备系统语言
 *
 *  @return 语言
 */
NSString* sys_device_language();

#pragma mark 获取设备系统国家
/**
 *  @Author DT
 *
 *  @brief 获取设备系统国家
 *
 *  @return 国家
 */
NSString* sys_device_country();

#pragma mark 获取设备的尺寸
/*
 *  @Author DT
 *
 *  @brief  获取设备的尺寸
 *
 *  @return 返回3.5、4.0、4.7、5.5,未知设备返回-1
 */
CGFloat sys_device_size();

#pragma mark - 当前版本号是否与指定版本号相等
/*!
 *  @author DT, 15-09-03 13:09:56
 *
 *  @brief  判断当前版本号是否相等
 *
 *  @param versoin 指定版本号
 *
 *  @return
 */
BOOL sys_isIOSX(CGFloat versoin);

#pragma mark - 当前版本号是否IOS8
/*!
 *  @author DT, 15-09-03 13:09:16
 *
 *  @brief  当前版本号是否IOS8
 *
 *  @return
 */
BOOL sys_isIOS8();

#pragma mark - 当前版本号是否IOS7
/*!
 *  @author DT, 15-09-03 13:09:27
 *
 *  @brief  当前版本号是否IOS7
 *
 *  @return
 */
BOOL sys_isIOS7();

#pragma mark - UIView

#pragma mark UIView初始化
/*!
 *  @author DT
 *
 *  @brief  UIView初始化,相当于[[UIView alloc] init]
 *
 *  @return UIView
 */
UIView* View();

#pragma mark UIView初始化(有指定frame)
/*!
 *  @author DT
 *
 *  @brief  UIView初始化
 *
 *  @param x      x坐标
 *  @param y      y坐标
 *  @param width  宽度
 *  @param height 高度
 *
 *  @return UIView
 */
UIView* View_Rect(CGFloat x, CGFloat y, CGFloat width, CGFloat height);

#pragma mark - UILabel

#pragma mark - 创建Label
UILabel* Label();

UILabel* Label_Rect(CGFloat x, CGFloat y, CGFloat width, CGFloat height);

#pragma mark - UIButton

#pragma mark 创建UIButton对象
UIButton* Button();

#pragma mark UIButton初始化(有指定frame)
/*!
 *  @author DT
 *
 *  @brief  UIButton初始化
 *
 *  @param x      x坐标
 *  @param y      y坐标
 *  @param width  宽度
 *  @param height 高度
 *
 *  @return UIButton
 */
UIButton* Button_Rect(CGFloat x, CGFloat y, CGFloat width, CGFloat height);

#pragma mark - UITableView;

#pragma mark 创建UITableView对象
/*!
 *  @author DT
 *
 *  @brief  UITableView对象初始化
 *
 *  @param dataSoure dataSoure对象
 *  @param delegate  delegate对象
 *
 *  @return UITableView
 */
UITableView* TableView(id<UITableViewDataSource> dataSoure,
                       id<UITableViewDelegate> delegate);

#pragma mark UITableView初始化(有指定frame)
/*!
 *  @author DT
 *
 *  @brief  UITableView对象初始化
 *
 *  @param x         x坐标
 *  @param y         y坐标
 *  @param width     宽度
 *  @param height    高度
 *  @param dataSoure dataSoure对象
 *  @param delegate  delegate对象
 *
 *  @return <#return value description#>
 */
UITableView* TableView_Rect(CGFloat x, CGFloat y, CGFloat width, CGFloat height,
                            id<UITableViewDataSource> dataSoure,
                            id<UITableViewDelegate> delegate);


