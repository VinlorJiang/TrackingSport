//
//  NSString+Common.m
//  trackingsport
//
//  Created by SZDCMAC15 on 2022/10/17.
//
//空对象
#define KObjectEmpty(object)                                                                                                                                                                         \
(object == nil || [object isKindOfClass:[NSNull class]] || ([object respondsToSelector:@selector(length)] && [(NSData *) object length] == 0) ||                                                 \
([object respondsToSelector:@selector(count)] && [(NSArray *) object count] == 0))

#import "NSString+Common.h"
#include <CommonCrypto/CommonCrypto.h>
#import <CoreText/CoreText.h>
#include <zlib.h>


@implementation NSString (Common)

+ (void)load {
    [self swizzleInstanceMethod:@selector(stringByAppendingString:) with:@selector(safeStringByAppendingString:)];
}
- (NSString *)safeStringByAppendingString:(NSString *)aString {
    if (!aString) {
        TSNSLog(@"stringByAppendingString: ____________________字符串为空");
        TSNSLog(@"stringByAppendingString: ____________________字符串为空");
        TSNSLog(@"stringByAppendingString: ____________________字符串为空");
        return self;
    }
    return [self safeStringByAppendingString:aString];
}
/** 判断是否可用 */
- (BOOL)isAble {
    return (self && [self isKindOfClass:[NSString class]] && self.length != 0);
}
// size
- (CGSize)size {
    return [self sizeWith_Fonts:[UIFont systemFontSize]];
}
- (CGSize)sizeWith_Fonts:(CGFloat)font {
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.lineSpacing = 0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    
    NSDictionary *dic = @{ NSFontAttributeName: [UIFont systemFontOfSize:font], NSParagraphStyleAttributeName: paraStyle, NSKernAttributeName: @1.5f };
    return [self boundingRectWithSize:CGSizeMake(KScreenWidth - 30, MAXFLOAT)
                              options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                           attributes:dic
                              context:nil].size;
}
//是否是密码
- (BOOL)isPasswordStrength {
    if (KObjectEmpty(self)) return NO;
    if (self.length < 8 || self.length > 25) return NO;

    BOOL isAllCharacter = YES;
    NSString *regex = @"(^[A-Za-z0-9_]{8,20}$)";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    isAllCharacter = [pred evaluateWithObject:self];
    if (isAllCharacter == NO) return NO;

    NSString *regexOther = @"(?!^\\d+$)(?!^[a-zA-Z]+$)(?!^[_]+$).{8,20}";
    NSPredicate *predOther = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexOther];
    return [predOther evaluateWithObject:self];
}
//中文
- (BOOL)isChinese {
    if (KObjectEmpty(self)) return NO;
    NSString *phoneRegex = @"[\u4e00-\u9fa5]";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    return [phoneTest evaluateWithObject:self];
}
//英文字母
- (BOOL)isLetters {
    if (KObjectEmpty(self)) return NO;
    NSString *phoneRegex = @"^[A-Za-z]+$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    return [phoneTest evaluateWithObject:self];
}
// 验证是否是数字
- (BOOL)isNumber {
    if (KObjectEmpty(self)) return NO;
    NSString *isNumber = @"^[0-9]*$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", isNumber];
    return [phoneTest evaluateWithObject:self];
}
//是否有字符
- (BOOL)haveCharacterString {
    if (KObjectEmpty(self)) return NO;
    NSString *phoneRegex = @"<>\"'%/\\&|~￥#*《》^()[]{}【】^@/￡¤￥|§¨「」『』￠￢￣~@#￥&*（）——+《》$_€!:.,，。?";
    NSRange urgentRange = [self rangeOfCharacterFromSet:[NSCharacterSet characterSetWithCharactersInString:phoneRegex]];
    if (urgentRange.location == NSNotFound) return NO;
    return YES;
}
//金额
- (BOOL)isAmount {
    if (KObjectEmpty(self)) return NO;
    NSString *phoneRegex = @"^[0-9]+(.[0-9]{2})?$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    return [phoneTest evaluateWithObject:self];
}
//转化成那个精确到.2位 不带￥
- (NSString *)amountTwoPlace {
    return [NSString stringWithFormat:@"%.2f", self.floatValue];
}
/**转化成那个精确到.2位 带￥*/
- (NSString *)amountSymbol {
    return [NSString stringWithFormat:@"￥%.2f", self.doubleValue];
}
- (NSString *)dollar {
    return [NSString stringWithFormat:@"$ %.2f", self.doubleValue];
}

- (NSMutableAttributedString *)dollarSymbol {
    NSString *ab = self;
    if (ab == nil) ab = @"0";
    NSString *string = [NSString stringWithFormat:@"$%.2f", ab.doubleValue];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    long number = 4.5;
    CFNumberRef num = CFNumberCreate(kCFAllocatorDefault, kCFNumberSInt8Type, &number);
    [attributedString addAttribute:(id) kCTKernAttributeName value:(__bridge id) num range:NSMakeRange(0, 1)];

    CFRelease(num);
    return attributedString;
}

//手机
- (BOOL)isPhoneNumber {
    if (KObjectEmpty(self)) return NO;
    //    电信号段:133/149/153/173/177/180/181/189
    //    联通号段:130/131/132/145/155/156/171/175/176/185/186
    //    移动号段:134/135/136/137/138/139/147/150/151/152/157/158/159/178/182/183/184/187/188
    //    虚拟运营商:170
    //    新建号段:199 198 166
    NSString *mobile = @"^1(3[0-9]|4[579]|5[0-35-9]|6[6]|7[0135-8]|8[0-9]|9[98])\\d{8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobile];
    return [regextestmobile evaluateWithObject:self];
}
//身份证
- (BOOL)isIdentityCard {
    if (KObjectEmpty(self)) return NO;
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex2];
    return [identityCardPredicate evaluateWithObject:self];
}
//邮箱
- (BOOL)isE_mail {
    if (KObjectEmpty(self)) return NO;
    NSString *phoneRegex = @"[\\w!#$%&'*+/=?^_`{|}~-]+(?:\\.[\\w!#$%&'*+/=?^_`{|}~-]+)*@(?:[\\w](?:[\\w-]*[\\w])?\\.)+[\\w](?:[\\w-]*[\\w])?";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    return [phoneTest evaluateWithObject:self];
}
// url
- (BOOL)isUrl {
    if (KObjectEmpty(self)) return NO;
    NSString *url = self;
    if (self.length > 4 && [self hasPrefix:@"www."]) url = [@"http://" stringByAppendingString:self];
    NSString *phoneRegex = @"[a-zA-z]+://[^\\s]*";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    return [urlTest evaluateWithObject:url];
}
- (NSString *)correctUrl {
    if (self.length > 4 && [self hasPrefix:@"www."]) return [@"http://" stringByAppendingString:self];
    return self;
}

- (NSString *)changePinyin {
    NSMutableString *mutableString = [NSMutableString stringWithString:self];
    CFStringTransform((__bridge CFMutableStringRef) mutableString, NULL, kCFStringTransformMandarinLatin, NO);   //国语拉丁文
    CFStringTransform((__bridge CFMutableStringRef) mutableString, NULL, kCFStringTransformStripDiacritics, NO); //去音标
    return [mutableString stringByReplacingOccurrencesOfString:@" " withString:@""];
}


//获取UUID
+ (NSString *)getClientUUID {
    static NSString *const kService = @"DinpayPurse";
    static NSString *const kAccount = @"zsl";

    NSString *uuid = [YYKeychain getPasswordForService:kService account:kAccount];
    if (uuid == nil) {
        uuid = [CheckHelper createDinpayUUID];
        if (uuid) {
            YYKeychainItem *item = [[YYKeychainItem alloc] init];
            item.password = uuid;
            item.service = kService;
            item.account = kAccount;
            item.label = @"";
            NSError *error = nil;
            [YYKeychain insertItem:item error:&error];
        }
    }
    NSString *uuidStr = [uuid stringByReplacingOccurrencesOfString:@"-" withString:@""];
    return uuidStr;
}
//获取日期年月日周
- (NSDateComponents *)dateComponents {
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:self.integerValue];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitDay | kCFCalendarUnitWeekOfYear | NSCalendarUnitMonth | NSCalendarUnitYear;
    return [calendar components:unit fromDate:confromTimesp];
}
//转换时间戳
- (NSInteger)getTimestamp {
    return [self getTimestampWithFormatter:@"yyyy-MM-dd"];
}
- (NSInteger)getTimestampWithFormatter:(NSString *)formatter {
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:formatter];
    NSDate *fromDate = [dateformatter dateFromString:self];
    return (long) [fromDate timeIntervalSince1970];
}

//时间戳转成时间
- (NSString *)timeForTimesTampWithFormatter:(NSString *)formatter {
    NSDate *detaildate = [NSDate dateWithTimeIntervalSince1970:[self doubleValue]];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatter];
    return [dateFormatter stringFromDate:detaildate];
}
- (NSString *)formatConversionWithOldFormatter:(NSString *)formatter newFormatter:(NSString *)newmatter {
    NSInteger timestamp = [self getTimestampWithFormatter:formatter];
    return [@(timestamp).stringValue timeForTimesTampWithFormatter:newmatter];
}
//获取三个月前
- (NSString *)getThreeMonthAgo {
    NSDate *mydate = [NSDate dateWithTimeIntervalSince1970:self.integerValue];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = nil;
    comps = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitMonth fromDate:mydate];
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    [adcomps setYear:0];
    [adcomps setMonth:-3];
    [adcomps setDay:0];
    NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:mydate options:0];
    return [dateFormatter stringFromDate:newdate];
}

//获取1个月前
- (NSString *)getOneMonthAgo {
    NSDate *mydate = [NSDate dateWithTimeIntervalSince1970:self.integerValue];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = nil;
    comps = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitMonth fromDate:mydate];
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    [adcomps setYear:0];
    [adcomps setMonth:-1];
    [adcomps setDay:0];
    NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:mydate options:0];
    return [dateFormatter stringFromDate:newdate];
}

//获取周几
- (NSString *)weekdayStringFromDate:(NSString *)fromDate {
    NSDateFormatter * forMatter = [[NSDateFormatter alloc] init];
    [forMatter setDateFormat:fromDate];
    NSDate *inputDate = [forMatter dateFromString:self];
    NSArray *weekdays = [NSArray arrayWithObjects:[NSNull null], @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六",nil];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    [calendar setTimeZone:timeZone];
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];

    NSString *t = [self formatConversionWithOldFormatter:fromDate newFormatter:@"yyyy-MM"];
    if ([t isEqualToString:[KGetCurentTime timeForTimesTampWithFormatter:@"yyyy-MM"]]) {
        NSString *day = [self formatConversionWithOldFormatter:fromDate newFormatter:@"dd"];
        NSString *oherDay = [KGetCurentTime timeForTimesTampWithFormatter:@"dd"];
        if (day && oherDay && [day isEqualToString:oherDay]) return @"今天";
        if (day && oherDay && (day.integerValue == oherDay.integerValue - 1)) return @"昨天";
    }
    return [weekdays objectAtIndex:theComponents.weekday];
}
//时间戳转成时间 yyyy-MM-dd格式
- (NSString *)timeForTimesTamp {
    return [self timeForTimesTampWithFormatter:@"yyyy-MM-dd"];
}
//时间戳转成时间带中文年月日  yyyy年MM月dd日格式
- (NSString *)timeForYMD {
    return [self timeForTimesTampWithFormatter:@"yyyy年MM月dd日"];
}
//时间戳转成时间带英文年月日 英文格式
- (NSString *)timeForYMDInAmerica {
    NSString *year = [self timeForTimesTampWithFormatter:@"yyyy"];
    NSString *month = [self timeForTimesTampWithFormatter:@"MM月"];
    NSString *day = [self timeForTimesTampWithFormatter:@"dd"];
    return [NSString stringWithFormat:@"%@ %@th %@", month, day, year];
}
+ (NSString *)getTimeNow {
    NSString *date;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"ss.SSS"];
    date = [formatter stringFromDate:[NSDate date]];
    return [[NSString alloc] initWithFormat:@"%@", date];
}


//根据宽度求 height
- (CGFloat)getHeightWithFont:(CGFloat)font {
    return [self getHeightWithFont:font width:MAXFLOAT];
}
//根据宽度求 height
- (CGFloat)getHeightWithFont:(CGFloat)font width:(CGFloat)width {
    if (!font) font = [UIFont systemFontSize];
    CGRect rect = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                     options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                  attributes:@{ NSFontAttributeName: [UIFont systemFontOfSize:font] }
                                     context:nil];
    return rect.size.height;
}
//根据高度度求 width
- (CGFloat)getWidthWithFont:(CGFloat)font {
    if (!font) font = [UIFont systemFontSize];
    CGRect rect = [self boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT)
                                     options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                  attributes:@{ NSFontAttributeName: [UIFont systemFontOfSize:font] }
                                     context:nil];
    return rect.size.width;
}
// json字符串转字典
- (NSDictionary *)jsonToDictionary {
    NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    if (!jsonData) return nil;
    return [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
}
//手机打码
- (NSString *)phoneCode {
    if (self.length < 7) return nil;
    if ([self rangeOfString:@"*"].location != NSNotFound) return self;
    NSInteger length = self.length - 6;
    return [self stringByReplacingCharactersInRange:NSMakeRange(3, length) withString:@"****"];
}
//银行卡
- (BOOL)isBankCard {
    if (KObjectEmpty(self)) return NO;
    NSString *phoneRegex = @"[0-9]{8,25}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    return [phoneTest evaluateWithObject:self];
}
// 过滤特殊字符
- (BOOL)isContentSpecialString {
    NSArray *specialChars = @[@"<", @">", @";", @"%", @"'", @"$", @"=", @"&", @"，", @"。", @"-", @"|", @"@"];
    if ([specialChars containsObject:self]) return YES;
    return NO;
}

/** 判断是否为纯符号 */
- (BOOL)isAllCharacterString {
    BOOL isAllCharacter = YES;
    for (int i = 0; i < self.length; i++) {
        NSString *subStr = [self substringWithRange:NSMakeRange(i, 1)];
        if (subStr.isNumber || subStr.isChinese || self.isLetters) {
            isAllCharacter = NO;break;
        }
    }
    return isAllCharacter;
}
// 小数点后两位
- (BOOL)hasThreeOrMoreDecimalInString{
    if ([self containsString:@"."]) {
        NSRange rang = [self rangeOfString:@"."];
        NSString *decimalString = [self substringFromIndex:rang.location+1];
        
        if ([decimalString containsString:@"."]) {  // 判断是否有两个小数点
            return YES ;
        }
        if ([decimalString length] >= 3) {
            return YES;
        }
    }
    return NO;
}

//md5
- (NSString *)md5String {
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(data.bytes, (CC_LONG) data.length, result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ].lowercaseString;
}
//获取银行名字
- (NSString *)getBanNameBybanCode {
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"bankName"ofType:@"plist"]];
    return [dic objectForKey:[self uppercaseString]];
}

// 获取字符串 后面的 _number 位
- (NSString *)substringFromIndex_number:(NSUInteger)_number{
    if (self == nil || self.length<=_number) {
        return self ;
    }
    NSString *str  = [self substringFromIndex:self.length - _number];
    return str ;
}
//获取十位随机数
+ (NSString *)getTenNumber {
    NSUInteger tenNumber = arc4random() % 8999999999;
    NSString *ten = [NSString stringWithFormat:@"%zd", tenNumber + 1000000000];
    return ten;
}
- (NSString *)removeSpace {
    if (self.isAble == NO) return nil;
    return [self stringByReplacingOccurrencesOfString:@" " withString:@""];
}

@end










@implementation NSAttributedString (DXPCategory)
- (instancetype)initWithString_safe:(NSString *)str {
    if (str == nil) return nil;
    return [self initWithString:str];
}
/**部分换颜色 */
+ (NSMutableAttributedString *)attributedStringWithString:(NSString *)aString Color:(UIColor *)color Range:(NSRange)range {
    @try {
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:aString];
        [attributedString addAttribute:NSForegroundColorAttributeName value:color range:range];
        return attributedString;
    }@catch (NSException *exception) {}@finally {};
}
/**修改字符间距 字与字 */
+ (NSMutableAttributedString *)changeSpaceWithString:(NSString *)aString Space:(CGFloat)space {
    @try {
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:aString];
        long number = space;
        CFNumberRef num = CFNumberCreate(kCFAllocatorDefault, kCFNumberSInt8Type, &number);
        [attributedString addAttribute:(id) kCTKernAttributeName value:(__bridge id) num range:NSMakeRange(0, attributedString.length)];
        CFRelease(num);
        return attributedString;
    }@catch (NSException *exception) {}@finally {};
}
/**修改字符行间距距 行与行 */
+ (NSMutableAttributedString *)changeLineSpaceWithString:(NSString *)aString LineSpace:(CGFloat)lineSpace {
    @try {
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:aString];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:lineSpace];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, attributedString.length)];
        return attributedString;
    }@catch (NSException *exception) {}@finally {};
}
+ (NSMutableAttributedString *)addLinkWithString:(NSString *)aString Range:(NSRange)range {
    @try {
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:aString];
        NSDictionary *attris = @{
            NSFontAttributeName: [UIFont systemFontOfSize:14],
            NSForegroundColorAttributeName: [UIColor redColor],
            NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle),
            NSUnderlineColorAttributeName: [UIColor blackColor]
        };
        [attributedString setAttributes:attris range:range];
        return attributedString;
    } @catch (NSException *exception) {} @finally {};
}

@end

