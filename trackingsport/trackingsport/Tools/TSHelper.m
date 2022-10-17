//
//  TSHelper.m
//  trackingsport
//
//  Created by SZDCMAC15 on 2022/10/17.
//

#import "TSHelper.h"
#import "OpenSSLRSAWrapper.h"
#import "NSString+Base64.h"
#import "NSString+Common.h"
#import "GTMBase64.h"

#define kPublicKey @"test123"

@implementation TSHelper

// 银行卡四位就加空格
+ (NSString *)FourTextSpaces:(NSString *)text {
    text = [text stringByReplacingOccurrencesOfString:@" " withString:@""];

    NSString *newString = @"";
    while (text.length > 0) {
        NSString *subString = [text substringToIndex:MIN(text.length, 4)];
        newString = [newString stringByAppendingString:subString];
        text = [text substringFromIndex:MIN(text.length, 4)];
        if (subString.length == 4 && text.length != 0) {
            newString = [newString stringByAppendingString:@" "];
        }
    }
    return newString;
}

// 手机号加空格
+ (NSString *)PhoneTextSpaces:(NSString *)text  number:(NSUInteger)number {
    text = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
    text = [text substringToIndex:MIN(text.length, number)];
    NSString *newString = @"";
    if (text.length >=4) {
        NSString *subString = [text substringToIndex:MIN(text.length, 3)];
        newString = [newString stringByAppendingString:subString];
        text = [text substringFromIndex:MIN(text.length, 3)];
        newString = [newString stringByAppendingString:@" "];
        
        while (text.length > 0) {
            NSString *subString = [text substringToIndex:MIN(text.length, 4)];
            newString = [newString stringByAppendingString:subString];
            text = [text substringFromIndex:MIN(text.length, 4)];
            if (subString.length == 4 && text.length != 0) {
                newString = [newString stringByAppendingString:@" "];
            }
        }
    }
    else  newString = text ;
    
    return newString;
}

+ (NSString *)decrytStr:(NSString *)str {
    NSString *result = nil;
    OpenSSLRSAWrapper *wrapper = [OpenSSLRSAWrapper shareInstance];
    NSString *publickey = [wrapper getPemStr:kPublicKey:KeyTypePublic];
    [wrapper writeKeyToFile:publickey:nil];
    [wrapper importRSAKeyWithType:KeyTypePublic];
    NSData *data = [wrapper decryptRSAKeyWithType:KeyTypePublic paddingType:RSA_PADDING_TYPE_PKCS1 encryptedData:[str base64DecodedData]];
    result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return result;
}

//  解密字典数据  使用base 64
+ (NSString *)decrytDataStr:(NSString *)str {
    // des与md5加密的key
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    NSString *key = [TSHelper decrytStr:delegate.key];
    NSString *data = [OpenSSLRSAWrapper DES:str encryptOrDecrypt:kCCDecrypt encryptOrDecryptKey:key];
    NSString *tempSte = [data base64DecodedString];
    return tempSte;
}

+ (NSString *)decryt_des_Str:(NSString *)str {
    // des与md5加密的key
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    NSString *key = [TSHelper decrytStr:delegate.key];
    NSString *tempSte = [OpenSSLRSAWrapper DES:str encryptOrDecrypt:kCCDecrypt encryptOrDecryptKey:key];
    return tempSte;
}

+ (NSString *)decryt_ens_Str:(NSString *)str {
    // des与md5加密的key
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    NSString *key = [TSHelper decrytStr:delegate.key];
    NSLog(@"key===%@", key);
    // des加密请求的数据
    NSString *dataContent = [OpenSSLRSAWrapper DES:str encryptOrDecrypt:kCCEncrypt encryptOrDecryptKey:key];

    return dataContent;
}

// 1.6.2 deskey 加base64加密
+ (NSString *)decryt_ens_Str_Base64:(NSString *)str {

    // des与md5加密的key
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    NSString *key = [TSHelper decrytStr:delegate.key];
    NSLog(@"key===%@", key);
    // des加密请求的数据
    NSString *tempSte = [str base64EncodedString];
    NSString *dataContent = [OpenSSLRSAWrapper DES:tempSte encryptOrDecrypt:kCCEncrypt encryptOrDecryptKey:key];

    return dataContent;
}

@end
