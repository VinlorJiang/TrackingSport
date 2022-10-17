//
//  UIDevice+Common.m
//  trackingsport
//
//  Created by SZDCMAC15 on 2022/10/17.
//

#import "UIDevice+Common.h"
#include <sys/types.h>
#include <sys/sysctl.h>

@implementation UIDevice (Common)
+ (NSString *)__zsl_platform {
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size * sizeof(char));
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithUTF8String:machine];
    free(machine);
    
    return platform;
    
}
+ (NSString *)currentplatformName {
    NSString *platform = [self __zsl_platform];
    
    // iPhone
    if ([platform isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([platform isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,3"])    return @"Verizon iPhone 4";
    if ([platform isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([platform isEqualToString:@"iPhone5,1"])    return @"iPhone 5 ";
    if ([platform isEqualToString:@"iPhone5,2"])    return @"iPhone 5 ";
    if ([platform isEqualToString:@"iPhone5,3"])    return @"iPhone 5c ";
    if ([platform isEqualToString:@"iPhone5,4"])    return @"iPhone 5c ";
    if ([platform isEqualToString:@"iPhone6,1"])    return @"iPhone 5s ";
    if ([platform isEqualToString:@"iPhone6,2"])    return @"iPhone 5s ";
    if ([platform isEqualToString:@"iPhone7,1"])    return @"iPhone 6+";
    if ([platform isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([platform isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([platform isEqualToString:@"iPhone8,2"])    return @"iPhone 6s+";
    if ([platform isEqualToString:@"iPhone8,4"])    return @"iPhone SE";
    if ([platform isEqualToString:@"iPhone9,1"])    return @"iPhone7";
    if ([platform isEqualToString:@"iPhone9,2"])    return @"iPhone7Plus";
    if ([platform isEqualToString:@"iPhone10,1"])    return @"iPhone8";
    if ([platform isEqualToString:@"iPhone10,2"])    return @"iPhone8Plus";
    if ([platform isEqualToString:@"iPhone10,3"])    return @"iPhone X";
    if ([platform isEqualToString:@"iPhone10,4"])    return @"iPhone8";
    if ([platform isEqualToString:@"iPhone10,5"])    return @"iPhone8Plus";
    if ([platform isEqualToString:@"iPhone10,6"])    return @"iPhone X";
    
    // iPod
    if ([platform isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([platform isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([platform isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([platform isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([platform isEqualToString:@"iPod5,1"])      return @"iPod Touch 5G";
    
    // iPad
    if ([platform isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([platform isEqualToString:@"iPad2,1"])      return @"iPad 2 ";
    if ([platform isEqualToString:@"iPad2,2"])      return @"iPad 2 ";
    if ([platform isEqualToString:@"iPad2,3"])      return @"iPad 2 ";
    if ([platform isEqualToString:@"iPad2,4"])      return @"iPad 2 ";
    if ([platform isEqualToString:@"iPad2,5"])      return @"iPad Mini";
    if ([platform isEqualToString:@"iPad2,6"])      return @"iPad Mini";
    if ([platform isEqualToString:@"iPad2,7"])      return @"iPad Mini ";
    if ([platform isEqualToString:@"iPad3,1"])      return @"iPad 3 ";
    if ([platform isEqualToString:@"iPad3,2"])      return @"iPad 3 ";
    if ([platform isEqualToString:@"iPad3,3"])      return @"iPad 3 ";
    if ([platform isEqualToString:@"iPad3,4"])      return @"iPad 4 ";
    if ([platform isEqualToString:@"iPad3,5"])      return @"iPad 4 ";
    if ([platform isEqualToString:@"iPad3,6"])      return @"iPad 4 ";
    if ([platform isEqualToString:@"iPad4,1"])      return @"iPad Air ";
    if ([platform isEqualToString:@"iPad4,2"])      return @"iPad Air ";
    if ([platform isEqualToString:@"iPad4,3"])      return @"iPad Air";
    if ([platform isEqualToString:@"iPad4,4"])      return @"iPad Mini 2 ";
    if ([platform isEqualToString:@"iPad4,5"])      return @"iPad Mini 2 ";
    if ([platform isEqualToString:@"iPad4,6"])      return @"iPad Mini 2 ";
    if ([platform isEqualToString:@"iPad4,7"])      return @"iPad Mini 3 ";
    if ([platform isEqualToString:@"iPad4,8"])      return @"iPad Mini 3 ";
    if ([platform isEqualToString:@"iPad4,9"])      return @"iPad Mini 3 ";
    if ([platform isEqualToString:@"iPad5,3"])      return @"iPad Air 2 ";
    if ([platform isEqualToString:@"iPad5,4"])      return @"iPad Air 2 )";
    if ([platform isEqualToString:@"iPad5,1"])      return @"iPad Mini 4 )";
    if ([platform isEqualToString:@"iPad5,2"])      return @"iPad Mini 4 )";
    
    if ([platform isEqualToString:@"i386"])         return @"Simulator";
    if ([platform isEqualToString:@"x86_64"])       return @"Simulator";
    
    return platform;

}

+ (double)systemVersion {
    static double version;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        version = [UIDevice currentDevice].systemVersion.doubleValue;
    });
    return version;
}

- (BOOL)isSimulator {
#if TARGET_OS_SIMULATOR
    return YES;
#else
    return NO;
#endif
}
@end
