//
//  CheckHelper.h
//  trackingsport
//
//  Created by SZDCMAC15 on 2022/10/17.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCrypto.h>

NS_ASSUME_NONNULL_BEGIN

@interface CheckHelper : NSObject

+ (NSString *)md5:(NSString *)inPutText;
+ (BOOL)isValidateEmail:(NSString *)email;
+ (BOOL)isValidateMobile:(NSString *)mobile;
+ (BOOL)isValidateForeignTelphone:(NSString *)string;
+ (BOOL)checkFieldText:(NSString *)text;
+ (NSString *)createDinpayUUID;
+ (NSString *)getSortStrFromDic:(NSDictionary *)dic;
+ (BOOL)isValidatePassword:(NSString *)password;
+ (BOOL)isValidateIdentityCard:(NSString *)card;
+ (BOOL)isValidateInputString:(NSString *)string;
+ (BOOL)isValidateAmount:(NSString *)amount;
+ (BOOL)isValidateTextViewString:(NSString *)string;
+ (BOOL)isValidateLimitString:(NSString *)string;
+ (BOOL)isValidateBankCard:(NSString *)string;
+ (BOOL)isValidateForeginBankCard:(NSString*)string;

// --gyl 4/27  输入密码加密
+ (NSString *)encrypt:(NSString *)sText encryptOrDecrypt:(CCOperation)encryptOperation;
+ (NSMutableDictionary*)post_str_dictionary:(NSString*)str ;

//--1.5.11+

/**
 *   国内验证手机号码的正则,手机号限制在11到15位
 *
 *  @param mobile 手机号码
 *
 *  @return 合法的手机号码, NO 不合法的手机号码
 */
+ (BOOL)isValidateMobileAndLenthOk:(NSString *)mobile;

/**
 *  外国手机号为11到15位纯数字
 *
 *  @param mobile <#mobile description#>
 *
 *  @return <#return value description#>
 */
+ (BOOL) isValidateForeignTelphoneAndLineOk:(NSString*)string;


/**
 *  身份证号18位纯数字或17位纯数字加X或x
 *
 *  @param card <#card description#>
 *
 *  @return <#return value description#>
 */
+ (BOOL)isValidateIdentityCardAndLenthOk:(NSString *)card;

/**
 *  国内银行卡8到25位纯数字
 *
 *  @param string <#string description#>
 *
 *  @return <#return value description#>
 */
+ (BOOL)isValidateBankCardAndLenthOk:(NSString *)string;

/**
 *  国外银行卡8到50位纯数字 国内银行卡8到25位
 *
 *  @param string <#string description#>
 *
 *  @return <#return value description#>
 */
+ (BOOL)isValidateForeignBankCard:(NSString *)string isForeignBankCard:(BOOL)isForeignBankCard;

/**
 *  短信验证码6位纯数字 *
 *  @param string <#string description#>
 *
 *  @return <#return value description#>
 */
+ (BOOL)isValidateSmsCode:(NSString *)string;

/**
 *  校验checkValue
 *
 *  @param checkValue 后台返回的checkValue
 *  @param str        需要校验的数据
 *
 *  @return <#return value description#>
 */
+ (BOOL)checkValue:(NSString *)checkValue andString:(NSString *)str;

@end


NS_ASSUME_NONNULL_END
