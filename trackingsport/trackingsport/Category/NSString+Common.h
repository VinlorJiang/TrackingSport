//
//  NSString+Common.h
//  trackingsport
//
//  Created by SZDCMAC15 on 2022/10/17.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Common)
@property (nonatomic, assign, readonly) BOOL isAble;
@property (nonatomic, assign, readonly) CGSize size; //计算size+边距
@property (nonatomic, copy, readonly) NSString *md5String;

- (BOOL)isPasswordStrength;  //密码强度 8 - 25位以上 字母下划线
- (BOOL)isChinese;           //中文
- (BOOL)isLetters;           //英文
- (BOOL)isNumber;            //是否是数字
- (BOOL)haveCharacterString; //包含特殊字符

- (BOOL)isAmount;                      //金额 精确到.2位
- (BOOL)isPhoneNumber;                 //手机号
- (BOOL)isIdentityCard;                //身份证
- (BOOL)isE_mail;                      // e-mail
- (BOOL)isUrl;                         // url
- (NSString *)correctUrl;
- (BOOL)isBankCard;                    //银行卡
- (BOOL)isContentSpecialString;        // 过滤字符串，红包祝福语
- (BOOL)isAllCharacterString;          /** 判断是否为纯符号 */
- (BOOL)hasThreeOrMoreDecimalInString; // 小数点后两位

- (NSString *)amountTwoPlace;                                 //转化成那个精确到.2位 不带￥
- (NSMutableAttributedString *)dollarSymbol;                  //美元带$
- (NSString *)dollar;
- (NSString *)amountSymbol;                                   //转化成那个精确到.2位 带￥
- (NSString *)changePinyin;                                   //转化成拼音
+ (NSString *)getClientUUID;                                  //获取UUID
- (NSInteger)getTimestampWithFormatter:(NSString *)formatter; //转换成时间戳
- (NSInteger)getTimestamp;                                    //转换成时间戳
+ (NSString *)getTimeNow;                                     //获取当前时间
- (NSString *)timeForYMDInAmerica;

- (NSDateComponents *)dateComponents;                              //获取日期对象
- (NSString *)timeForTimesTamp;                                    //时间戳转成时间
- (NSString *)timeForYMD;                                          //时间戳转成时间带中文年月日
- (NSString *)timeForTimesTampWithFormatter:(NSString *)formatter; //时间戳转成时间
- (NSString *)formatConversionWithOldFormatter:(NSString *)formatter newFormatter:(NSString *)newmatter; //时间格式转化
- (NSDictionary *)jsonToDictionary;                                                                      // json字符串转字典
- (NSString *)phoneCode;                                           //手机打码

- (NSString *)getBanNameBybanCode;                           //获取银行名字
- (NSString *)substringFromIndex_number:(NSUInteger)_number; // 获取字符串 后面的 _number 位
+ (NSString *)getTenNumber;
- (NSString *)getThreeMonthAgo;                           //获取三个月前今天日期
- (NSString *)weekdayStringFromDate:(NSString *)fromDate; //获取周几
- (NSString *)removeSpace;
- (NSString *)getOneMonthAgo;


/**根据宽度求宽和高 */
- (CGSize)sizeWith_Fonts:(CGFloat)font;
- (CGFloat)getHeightWithFont:(CGFloat)font;
- (CGFloat)getWidthWithFont:(CGFloat)font;
- (CGFloat)getHeightWithFont:(CGFloat)font width:(CGFloat)width;

@end
@interface NSAttributedString (Common)
- (instancetype)initWithString_safe:(NSString *)str;
/**部分换颜色 */
+ (NSMutableAttributedString *)attributedStringWithString:(NSString *)aString Color:(UIColor *)color Range:(NSRange)range;
/**修改字符间距 字与字 */
+ (NSMutableAttributedString *)changeSpaceWithString:(NSString *)aString Space:(CGFloat)space;
/**修改字符行间距距 行与行 */
+ (NSMutableAttributedString *)changeLineSpaceWithString:(NSString *)aString LineSpace:(CGFloat)lineSpace;
/**链接 下划线 */
+ (NSMutableAttributedString *)addLinkWithString:(NSString *)aString Range:(NSRange)range;
@end

NS_ASSUME_NONNULL_END
