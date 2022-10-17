//
//  TSErrorManager.h
//  trackingsport
//
//  Created by SZDCMAC15 on 2022/10/17.
//

#import <Foundation/Foundation.h>

/**
 *  错误码
 */
typedef NS_ENUM(NSUInteger,TSError) {
    /**
     *  <#Description#>
     */
    TSSuccess = 10000,
    /**
     *  <#Description#>
     */
    TSErrorOther,
    /**
     *  <#Description#>
     */
    TSErrorB00000,
    /**
     *  <#Description#>
     */
    TSErrorC000158,
    /**
     *  <#Description#>
     */
    TSErrorC000051,
    /**
     *  <#Description#>
     */
    TSErrorB00005,
    /**
     *  <#Description#>
     */
    TSErrorF0000079,
    /**
     *  <#Description#>
     */
    TSErrorF000098,
    /**
     *  <#Description#>
     */
    TSErrorC000012,
    /**
     *  <#Description#>
     */
    TSErrorC000090,
    /**
     *  <#Description#>
     */
    TSErrorC000091,
    /**
     *  <#Description#>
     */
    TSErrorC000093,
    /**
     *  <#Description#>
     */
    TSErrorB000098,
    /**
     *  <#Description#>
     */
    TSErrorF0000078,
    /**
     *  <#Description#>
     */
    TSErrorF00000039,
    /**
     *  <#Description#>
     */
    TSErrorF00000040,
    /**
     *  <#Description#>
     */
    TSErrorF0000056,
    /**
     *  <#Description#>
     */
    TSErrorF0000057,
    /**
     *  <#Description#>
     */
    TSErrorF0000058,
    /**
     *  <#Description#>
     */
    TSErrorF0000059,
    /**
     *  <#Description#>
     */
    TSErrorF0000060,
    /**
     *  <#Description#>
     */
    TSErrorF0000061,
    /**
     *  <#Description#>
     */
    TSErrorF0000062,
    /**
     *  <#Description#>
     */
    TSErrorF0000063,
    /**
     *  <#Description#>
     */
    TSErrorF0000064,
    
    /**
     *  版本检测异常
     */
    TSErrorB00009,
    TSErrorB000010,
    /**
     *  二维码已失效
     */
    TSErrorC0000218,
    
};

NS_ASSUME_NONNULL_BEGIN

@interface TSErrorManager : NSObject

/**
 *  请求返回数据检测
 *
 *  @param response <#response description#>
 *  @param vc       <#vc description#>
 *
 *  @return <#return value description#>
 */
+ (TSError)requestIsSuccess:(id)response controller:(UIViewController *)vc;

+ (NSString *)withholdResult:(NSString *)status;
+ (NSString *)withholdResultForPay:(NSString *)status;
+ (NSString *)withholdResultForWartForHandling:(NSString *)status ;
@end

NS_ASSUME_NONNULL_END
