//
//  TSMacros_h.h
//  trackingsport
//
//  Created by SZDCMAC15 on 2022/10/12.
//

#ifndef TSMacros_h_h
#define TSMacros_h_h

// Window AppDelegate 通知中心和UserDefaults
#define KWindow [[[UIApplication sharedApplication] delegate] window]
#define KNotificationCenter [NSNotificationCenter defaultCenter]
#define KUserDefaults [NSUserDefaults standardUserDefaults]


//屏幕宽高
#define KScreenWidth [UIScreen mainScreen].bounds.size.width
#define KScreenHeight [UIScreen mainScreen].bounds.size.height

// 颜色(0xFFFFFF) 不用带 0x 和 @""
#define COLOR_WITH_HEX(hexValue) [UIColor colorWithRed:((float)((0x##hexValue & 0xFF0000) >> 16)) / 255.0 green:((float)((0x##hexValue & 0xFF00) >> 8)) / 255.0 blue:((float)(0x##hexValue & 0xFF)) / 255.0 alpha:1.0f]

//颜色
#define BlackColor       [UIColor blackColor]
#define DarkGrayColor    [UIColor darkGrayColor]
#define LightGrayColor   [UIColor lightGrayColor]
#define WhiteColor       [UIColor whiteColor]
#define RedColor         [UIColor redColor]
#define BlueColor        [UIColor blueColor]
#define GreenColor       [UIColor greenColor]
#define CyanColor        [UIColor cyanColor]
#define YellowColor      [UIColor yellowColor]
#define MagentaColor     [UIColor magentaColor]
#define OrangeColor      [UIColor orangeColor]
#define PurpleColor      [UIColor purpleColor]
#define BrownColor       [UIColor brownColor]
#define ClearColor       [UIColor clearColor]
#define GrayColor        [UIColor grayColor]

//颜色(RGB)
#define KRGBColor(r, g, b) [UIColor colorWithRed:(r) / 255.0f green:(g) / 255.0f blue:(b) / 255.0f alpha:1]
#define KRGBAColor(r, g, b, a) [UIColor colorWithRed:(r) / 255.0f green:(g) / 255.0f blue:(b) / 255.0f alpha:(a)]

//字体  适配的字体
#define KFont(f) ([[NSProcessInfo processInfo] isOperatingSystemAtLeastVersion:(NSOperatingSystemVersion){.majorVersion = 8, .minorVersion = 2, .patchVersion = 0}]) ?\
([UIFont systemFontOfSize:f weight:UIFontWeightRegular]) : \
([UIFont systemFontOfSize:f])
//打印
#ifdef DEBUG
#define __NSLog(FORMAT, ...)                                                                                                                                                                         \
fprintf(stderr, "%s  %d行 ------>:\t%s\n", [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);;

#define TSNSLog(...) __NSLog(@"%@", KMASBoxValue(__VA_ARGS__));;


#else

#define __NSLog(FORMAT, ...) nil;
#define NSLog(...) nil;
#define TSNSLog(...) nil;
#endif


#define KMASBoxValue(value) aMASBoxValue(@encode(__typeof__(value)), (value))

//获取当前语言
#define KCurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])

//沙盒路径
#define KSandboxPath NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject
//Library 路径
#define KLibraryboxPath NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).firstObject

//强弱引用
#define WeakSelf(type) __weak typeof(type) weak##type = type;
#define __WeakSelf WeakSelf(self)

#define StrongSelf(type) __strong typeof(type) type = weak##type;
#define __StrongSelf StrongSelf(self)

//获取当前系统时间戳
#define KGetCurentTime [NSString stringWithFormat:@"%zd", (long)[[NSDate date] timeIntervalSince1970]]

//线程
static inline void Kdispatch_async_on_main_queue(void (^block)()) {
    dispatch_async(dispatch_get_main_queue(), block);
}
static inline void Kdispatch_async_on_global_queue(void (^block)()) {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block);
}
static inline void Kdispatch_after_main_queue(CGFloat t, void (^block)()) {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(t * NSEC_PER_SEC)), dispatch_get_main_queue(), block);
}

//将括号内的类型转化成id类型
static inline id aMASBoxValue(const char *type, ...) {
    va_list v;
    va_start(v, type);
    id obj = nil;
    if (strcmp(type, @encode(id)) == 0) {
        id actual = va_arg(v, id);
        obj = actual;
    } else if (strcmp(type, @encode(CGPoint)) == 0) {
        CGPoint actual = (CGPoint)va_arg(v, CGPoint);
        obj = [NSValue value:&actual withObjCType:type];
    } else if (strcmp(type, @encode(CGSize)) == 0) {
        CGSize actual = (CGSize)va_arg(v, CGSize);
        obj = [NSValue value:&actual withObjCType:type];
    } else if (strcmp(type, @encode(double)) == 0) {
        double actual = (double)va_arg(v, double);
        obj = [NSNumber numberWithDouble:actual];
    } else if (strcmp(type, @encode(float)) == 0) {
        float actual = (float)va_arg(v, double);
        obj = [NSNumber numberWithFloat:actual];
    } else if (strcmp(type, @encode(int)) == 0) {
        int actual = (int)va_arg(v, int);
        obj = [NSNumber numberWithInt:actual];
    } else if (strcmp(type, @encode(long)) == 0) {
        long actual = (long)va_arg(v, long);
        obj = [NSNumber numberWithLong:actual];
    } else if (strcmp(type, @encode(long long)) == 0) {
        long long actual = (long long)va_arg(v, long long);
        obj = [NSNumber numberWithLongLong:actual];
    } else if (strcmp(type, @encode(short)) == 0) {
        short actual = (short)va_arg(v, int);
        obj = [NSNumber numberWithShort:actual];
    } else if (strcmp(type, @encode(char)) == 0) {
        char actual = (char)va_arg(v, int);
        obj = [NSNumber numberWithChar:actual];
    } else if (strcmp(type, @encode(bool)) == 0) {
        bool actual = (bool)va_arg(v, int);
        obj = [NSNumber numberWithBool:actual];
    } else if (strcmp(type, @encode(unsigned char)) == 0) {
        unsigned char actual = (unsigned char)va_arg(v, unsigned int);
        obj = [NSNumber numberWithUnsignedChar:actual];
    } else if (strcmp(type, @encode(unsigned int)) == 0) {
        unsigned int actual = (unsigned int)va_arg(v, unsigned int);
        obj = [NSNumber numberWithUnsignedInt:actual];
    } else if (strcmp(type, @encode(unsigned long)) == 0) {
        unsigned long actual = (unsigned long)va_arg(v, unsigned long);
        obj = [NSNumber numberWithUnsignedLong:actual];
    } else if (strcmp(type, @encode(unsigned long long)) == 0) {
        unsigned long long actual = (unsigned long long)va_arg(v, unsigned long long);
        obj = [NSNumber numberWithUnsignedLongLong:actual];
    } else if (strcmp(type, @encode(unsigned short)) == 0) {
        unsigned short actual = (unsigned short)va_arg(v, unsigned int);
        obj = [NSNumber numberWithUnsignedShort:actual];
    }
    va_end(v);
    return obj;
}

#endif /* TSMacros_h_h */
