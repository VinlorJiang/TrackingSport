//
//  CheckHelper.m
//  trackingsport
//
//  Created by SZDCMAC15 on 2022/10/17.
//

#import "CheckHelper.h"
#import "CommonCrypto/CommonDigest.h"
#import "GTMBase64.h"

#define gkey  @"12345678901234567890asdf"     //
//#define gkey  @"0123456789876543210asdfg"   //  
@implementation CheckHelper
/**
 *  生成设备的uuid
 *
 *  @return 生成的uuid
 */
+(NSString*) createDinpayUUID {
    CFUUIDRef puuid = CFUUIDCreate( nil );
    CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
    NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
    CFRelease(puuid);
    CFRelease(uuidString);
    return result;
}
/**
 *  md5签名
 *
 *  @param inPutText 要签名的字符串
 *
 *  @return 签名后的字符串
 */
+ (NSString *)md5:(NSString *)inPutText {
    const char *cStr = [inPutText UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
}

/**
 *  验证邮箱合法性的正则
 *
 *  @param email 邮箱地址
 *
 *  @return YES 合法的邮箱地址 NO 不合法的邮箱地址
 */
+ (BOOL)isValidateEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

/**
 *  验证手机号码的正则
 *
 *  @param mobile 手机号码
 *
 *  @return YES 合法的手机号码, NO 不合法的手机号码
 */
+ (BOOL) isValidateMobile:(NSString *)mobile {

    NSString *phoneRegex = @"^(1[3-9]\\d{9}|861[3-9]\\d{9}|\\+861[3-9]\\d{9})$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    BOOL returnbool = [phoneTest evaluateWithObject:mobile];
    return returnbool ;
}

//外国电话正则。
+ (BOOL) isValidateForeignTelphone:(NSString*)string {
    NSString *phoneRegex = @"(^\\+?\\d{1,3}?(\\(\\d{2,5})\\))(\\d{3,15})(-(\\d{4,8}))?$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    
    return [phoneTest evaluateWithObject:string];
}
/**
 *  对字典的key按a-z排序后，输出对应的值拼接成的字符串
 *
 *  @param dic
 *
 *  @return 排序后拼接的字符串
 */
+ (NSString*)getSortStrFromDic:(NSDictionary*)dic{
    NSMutableString* str = nil;
//    NSDictionary* dic = [self getDicFromOrder];
    if (dic) {
        
        NSSortDescriptor* sort = [NSSortDescriptor sortDescriptorWithKey:@"self" ascending:YES];
        NSMutableArray* array = [NSMutableArray arrayWithArray:[dic allKeys]];
        if (array.count == 0) {
            return str;
        }
        NSArray* tempAry = [array sortedArrayUsingDescriptors:@[sort]];
        //        NSLog(@"tempAry = %@", tempAry);
        str = [[NSMutableString alloc]initWithString:[NSString stringWithFormat:@"%@=%@", tempAry[0], [dic objectForKey:tempAry[0]]]];
        NSUInteger count = tempAry.count;
        
        for (int i = 1; i < count; i++) {
            [str appendString:[NSString stringWithFormat:@"&%@=%@", tempAry[i],[dic objectForKey:tempAry[i]]]];
        }
    }
    return str;
}

+ (BOOL)checkFieldText:(NSString*)text
{
    BOOL ret = NO;
    if (text) {
        NSString* str = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
        if (str.length>0) {
            ret = YES;
        }
    }
    return ret;
}

+ (BOOL)isValidatePassword:(NSString *)password
{
    if (password == nil) {
        return NO;
    }
    NSString *phoneRegex = @"^(?![0-9]+$)(?![a-zA-Z]+$)(?![_]+$)(?=.\\w+).{8,20}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    
    return [phoneTest evaluateWithObject:password];
}
//身份证验证正则。
+ (BOOL)isValidateIdentityCard:(NSString*)card
{
    if (card == nil) {
        return NO;
    }
    NSString *phoneRegex = @"(^\\d{15}$)|(^\\d{18}$)|(^\\d{17}(\\d|X|x)$)";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    
    return [phoneTest evaluateWithObject:card];
}

+ (BOOL)isValidateInputString:(NSString *)string
{
    if (string == nil) {
        return NO;
    }
//    --gyl 5/21 修改了一下输入的正则表达
//    NSString *phoneRegex = @"^[\u4e00-\u9fa5\\w]{1,50}$";
    NSString *phoneRegex = @"^[0-9 A-Za-z_\u4E00-\u9FA5]{1,50}";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    
    return [phoneTest evaluateWithObject:string];
}
//金额验证正则
+ (BOOL)isValidateAmount:(NSString *)amount
{
    if (amount == nil) {
        return NO;
    }
    NSString *phoneRegex = @"^(([1-9]\\d{0,9})|0)(\\.\\d{1,2})?$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:amount];
}
//建议正则
+ (BOOL)isValidateTextViewString:(NSString *)string
{
    if (string == nil) {
        return NO;
    }
    NSString *phoneRegex = @"^[^<>%'\"$=&]{1,200}";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    
    return [phoneTest evaluateWithObject:string];
}

+ (BOOL)isValidateLimitString:(NSString *)string
{
    if (string == nil) {
        return NO;
    }
    NSString *phoneRegex = @"^[\\w]{1,20}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    
    return [phoneTest evaluateWithObject:string];
}
//银行卡
+ (BOOL)isValidateBankCard:(NSString *)string
{
    if (string == nil) {
        return NO;
    }
    NSString *phoneRegex = @"^[1-9][0-9]{7,25}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    
    return [phoneTest evaluateWithObject:string];
}
//国外银行卡
+ (BOOL)isValidateForeginBankCard:(NSString *)string
{
    if (string == nil) {
        return NO;
    }
    NSString *phoneRegex = @"^[0-9A-Za-z]{7,25}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    
    return [phoneTest evaluateWithObject:string];
}

// 加密方法实现
//  3des加密
+ (NSString *)encrypt:(NSString *)sText encryptOrDecrypt:(CCOperation)encryptOperation
{
    const void *dataIn;
    size_t dataInLength;
    
    if (encryptOperation == kCCDecrypt)//传递过来的是decrypt 解码
    {
        //解码 base64
        NSData *decryptData = [GTMBase64 decodeData:[sText dataUsingEncoding:NSUTF8StringEncoding]];//转成utf-8并decode
        dataInLength = [decryptData length];
        dataIn = [decryptData bytes];
    }
    else  //encrypt
    {
        NSData* encryptData = [sText dataUsingEncoding:NSUTF8StringEncoding];
        dataInLength = [encryptData length];
        dataIn = (const void *)[encryptData bytes];
    }
    
    /*
     DES加密 ：用CCCrypt函数加密一下，然后用base64编码下，传过去
     DES解密 ：把收到的数据根据base64，decode一下，然后再用CCCrypt函数解密，得到原本的数据
     */
    CCCryptorStatus ccStatus;
    uint8_t *dataOut = NULL; //可以理解为type/typedef 的缩写（有效的维护了代码，比如：一个人用int，一个人用long。最好用typedef来定义）
    size_t dataOutAvailable = 0; //size_t  是操作符sizeof返回的结果类型
    size_t dataOutMoved = 0;
    
    dataOutAvailable = (dataInLength + kCCBlockSizeDES) & ~(kCCBlockSizeDES - 1);
    dataOut = malloc( dataOutAvailable * sizeof(uint8_t));
    memset((void *)dataOut, 0x0, dataOutAvailable);//将已开辟内存空间buffer的首 1 个字节的值设为值 0
    
    //    NSString *initIv = @"12345678";
    const void *vkey = (const void *) [gkey UTF8String];
    //    const void *iv = (const void *) [initIv UTF8String];
    
    //CCCrypt函数 加密/解密
    ccStatus = CCCrypt(encryptOperation,//  加密/解密
                       kCCAlgorithm3DES,
                       kCCOptionPKCS7Padding|kCCOptionECBMode,
                       vkey,
                       kCCKeySize3DES,
                       nil,
                       dataIn,
                       dataInLength,
                       (void *)dataOut,
                       dataOutAvailable,
                       &dataOutMoved);
    
    NSString *result = nil;
    
    if (encryptOperation == kCCDecrypt)//encryptOperation==1  解码
    {
        //得到解密出来的data数据，改变为utf-8的字符串
        result = [[NSString alloc] initWithData:[NSData dataWithBytes:(const void *)dataOut length:(NSUInteger)dataOutMoved] encoding:NSUTF8StringEncoding] ;
    }
    else //encryptOperation==0  （加密过程中，把加好密的数据转成base64的）
    {
        //编码 base64
        NSData *data = [NSData dataWithBytes:(const void *)dataOut length:(NSUInteger)dataOutMoved];
        result = [data base64EncodedStringWithOptions:0];
    }
    
    return result;
}

+(NSMutableDictionary*)post_str_dictionary:(NSString*)str
{
   // service_type=qr_code_pay&merchant_id=2099121201&dncrypt_data=2bfe92c419e919655e84418889167d2fd091f6c6778d682c
    
   
    NSMutableDictionary *dictMut = [[NSMutableDictionary alloc]initWithCapacity:5 ];
    
    NSArray *strArray=[str componentsSeparatedByString:@"&"];
    NSUInteger count = strArray.count ;
    for (int i = 0; i<count; i++)
    {
        NSString *strdict = [strArray objectAtIndex:i] ;
        NSArray *dictArray = [strdict componentsSeparatedByString:@"="];
        if (dictArray.count==2)
        {
            NSString *key = [dictArray objectAtIndex:0];
            NSString *varl = [dictArray objectAtIndex:1] ;
            [dictMut setObject:varl forKey:key ];
        }
    }
   
    return dictMut ;
}

//1.5.11+

/**
 *   验证手机号码的正则,手机号限制在11到15位
 *
 *  @param mobile 手机号码
 *
 *  @return 合法的手机号码, NO 不合法的手机号码
 */
+ (BOOL)isValidateMobileAndLenthOk:(NSString *)mobile {
    if (mobile == nil) {
        return NO;
    }
    NSString *phoneRegex = @"[0-9]{11,15}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];

    return [phoneTest evaluateWithObject:mobile];
}

//外国手机号正则
+ (BOOL)isValidateForeignTelphoneAndLineOk:(NSString *)string {

    if (string == nil) {
        return NO;
    }
    NSString *phoneRegex = @"[0-9]{11,15}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];

    return [phoneTest evaluateWithObject:string];
}

//身份证号正则
+ (BOOL)isValidateIdentityCardAndLenthOk:(NSString *)card {

    if (card == nil) {
        return NO;
    }
    NSString *phoneRegex = @"(^\\d{18}$)|(^\\d{17}(\\d|X|x)$)";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];

    return [phoneTest evaluateWithObject:card];
}

//银行卡
+ (BOOL)isValidateBankCardAndLenthOk:(NSString *)string {
    if (string == nil) {
        return NO;
    }
    NSString *phoneRegex = @"[0-9]{8,25}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];

    return [phoneTest evaluateWithObject:string];
}

+ (BOOL)isValidateForeignBankCard:(NSString *)string isForeignBankCard:(BOOL)isForeignBankCard{

    if (string == nil) {
        return NO;
    }
    NSString *phoneRegex = @"[0-9]{8,25}$";
    
    if (isForeignBankCard) {
         phoneRegex = @"[0-9]{8,50}$";
    }
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    
    return [phoneTest evaluateWithObject:string];

}

//短信校验码
+ (BOOL)isValidateSmsCode:(NSString *)string{
    if (string == nil) {
        return NO;
    }
    NSString *phoneRegex = @"[0-9]{6}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    
    return [phoneTest evaluateWithObject:string];
}

+ (BOOL)checkValue:(NSString *)checkValue andString:(NSString *)str{
    
    if (!str) {
        return NO;
    }
    //  des与md5加密的key
    NSMutableString *tempStr = [NSMutableString stringWithString:str];
    AppDelegate* delegate = [UIApplication sharedApplication].delegate;
    NSString* key = [TSHelper decrytStr:delegate.key];
    [tempStr appendString:[NSString stringWithFormat:@"&key=%@", key]];
    str = [self md5:tempStr];
    return [str isEqualToString:checkValue];
}


@end

