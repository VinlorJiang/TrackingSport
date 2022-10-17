//
//  TSHelper.h
//  trackingsport
//
//  Created by SZDCMAC15 on 2022/10/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TSHelper : NSObject

// 银行卡四位就加空格
+ (NSString *)FourTextSpaces:(NSString *)text;
// 手机号加空格
+ (NSString *)PhoneTextSpaces:(NSString *)text  number:(NSUInteger)number ;

+ (NSString *)decrytStr:(NSString *)str;

//  解密字符
+ (NSString *)decryt_des_Str:(NSString *)str;

//  deskey加密1.5.11
+ (NSString *)decryt_ens_Str:(NSString *)str;
/**
 *  deskey+base64加密
 *
 *  @param str <#str description#>
 *
 *  @return <#return value description#>
 */
+ (NSString *)decryt_ens_Str_Base64:(NSString *)str;

//  解密系统返回来的加密数据 //  解密字典 使用base64
+ (NSString *)decrytDataStr:(NSString *)str;
@end

NS_ASSUME_NONNULL_END
