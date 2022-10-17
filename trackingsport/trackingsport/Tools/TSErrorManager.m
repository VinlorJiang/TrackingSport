//
//  TSErrorManager.m
//  trackingsport
//
//  Created by SZDCMAC15 on 2022/10/17.
//

#import "TSErrorManager.h"

static inline TSError errorStatus(NSString *status) {
    if ([status isEqualToString:@"0"])        return TSSuccess;
    if ([status isEqualToString:@"B00000"])   return TSErrorB00000;
    if ([status isEqualToString:@"B00009"])   return TSErrorB00009;
    if ([status isEqualToString:@"B000010"])  return TSErrorB000010;
    if ([status isEqualToString:@"C000158"])  return TSErrorC000158;
    if ([status isEqualToString:@"C000051"])  return TSErrorC000051;
    if ([status isEqualToString:@"B00005"])   return TSErrorB00005;
    if ([status isEqualToString:@"F0000079"]) return TSErrorF0000079;
    if ([status isEqualToString:@"F000098"])  return TSErrorF000098;
    if ([status isEqualToString:@"C000012"])  return TSErrorC000012;
    if ([status isEqualToString:@"C000090"])  return TSErrorC000090;
    if ([status isEqualToString:@"C000091"])  return TSErrorC000091;
    if ([status isEqualToString:@"C000093"])  return TSErrorC000093;
    if ([status isEqualToString:@"B000098"])  return TSErrorB000098;
    if ([status isEqualToString:@"F0000078"]) return TSErrorF0000078;
    if ([status isEqualToString:@"F0000056"]) return TSErrorF0000056;
    if ([status isEqualToString:@"F0000057"]) return TSErrorF0000057;
    if ([status isEqualToString:@"F0000058"]) return TSErrorF0000058;
    if ([status isEqualToString:@"F0000059"]) return TSErrorF0000059;
    if ([status isEqualToString:@"F0000060"]) return TSErrorF0000060;
    if ([status isEqualToString:@"F0000061"]) return TSErrorF0000061;
    if ([status isEqualToString:@"F0000062"]) return TSErrorF0000062;
    if ([status isEqualToString:@"F0000063"]) return TSErrorF0000063;
    if ([status isEqualToString:@"F0000064"]) return TSErrorF0000064;
    if ([status isEqualToString:@"F00000039"]) return TSErrorF00000039;
    if ([status isEqualToString:@"F00000040"]) return TSErrorF00000040;
    if ([status isEqualToString:@"C0000218"])  return TSErrorC0000218;
    return TSErrorOther;
}


@implementation TSErrorManager

+ (TSError)requestIsSuccess:(id)response controller:(nonnull UIViewController *)vc {
    if (!response) return TSErrorOther;
    TSError status = errorStatus(response[@"status"]);
    if (status == TSSuccess) return TSSuccess;
    return status;
}

+ (NSString *)withholdResult:(NSString *)status {
    
    return @"失败";
}

+ (NSString *)withholdResultForPay:(NSString *)status {
    
    return @"失败";
}

+ (NSString *)withholdResultForWartForHandling:(NSString *)status {
   
    return @"失败";
}

@end

