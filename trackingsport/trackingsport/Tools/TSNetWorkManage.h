//
//  TSNetWorkManager.h
//  trackingsport
//
//  Created by SZDCMAC15 on 2022/10/17.
//

#import <Foundation/Foundation.h>
#import "TSErrorManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSNetworkRespose : NSObject
@property (nonatomic, strong, readonly) NSURLSessionDataTask *task;
@property (nonatomic, readonly) TSError status;
@property (nonatomic, copy) NSString *statusStr;
@property (nonatomic, copy) NSString *urlString;

- (instancetype)initWithTask:(NSURLSessionDataTask *)dataTask status:(TSError)status urlStr:(NSString *)urlString  NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;

@end

@interface TSNetWorkManage : NSObject

@property (nonatomic, strong) NSString *deskeyLogin;
@property (nonatomic) TSError currentRequestStatue;
@property (nonatomic,assign)NSTimeInterval outTimeInterval; //手动设置超时时间   默认30秒

/**
 *  是否自动show MB 默认  YES
 */
@property(nonatomic)BOOL isShowMB;

+ (TSNetWorkManage *)shareManage;
/** 不显示MB的 */

+ (TSNetWorkManage *)shareNoMB;

+ (TSNetWorkManage *)shareManageNoUpdateButton;

+ (TSNetWorkManage *)shareNoMBNoUpdateButton;


/**
 获取TOKEN

 @param controller <#controller description#>
 @param success    <#success description#>
 @param failure    <#failure description#>
 */
- (void)getTokenRequest:(UIViewController *)controller
                success:(void (^)(TSNetworkRespose * _Nonnull task,NSString *token))success
                failure:(void (^)(TSNetworkRespose * _Nonnull task,NSError *error))failure;


/**
 *  需要Token 的请求
 *
 *  @param path       <#path description#>
 *  @param parameters <#parameters description#>
 *  @param controller <#controller description#>
 *  @param success    <#success description#>
 *  @param failure    <#failure description#>
 */
- (void)needTokenRequestWithPath:(NSString *)path
                             parameters:(nullable NSDictionary *)parameters
                         viewController:(UIViewController *)controller
                                success:(void (^)(TSNetworkRespose * _Nonnull task,id response))success
                         failure:(void (^)(TSNetworkRespose * _Nonnull task,NSError *error))failure;
/**
 加密请求

 @param path       <#path description#>
 @param parameters <#parameters description#>
 @param controller <#controller description#>
 @param success    <#success description#>
 @param failure    <#failure description#>
 */
- (void)encryptionRequestWithPath:(NSString *)path
                       parameters:(NSDictionary *)parameters
                   viewController:(UIViewController *)controller
                          success:(void (^)(TSNetworkRespose *_Nonnull task, id response))success
                          failure:(void (^)(TSNetworkRespose *_Nonnull task, NSError *error))failure;

/** 状态码加密结果加密处理 */
- (void)TS_requestDataWithPath:(NSString *)path
                  isEncryption:(BOOL)encryption
                    parameters:(nullable NSDictionary *)parameters
                viewController:(UIViewController *)controller
                       success:(nonnull void (^)(TSNetworkRespose *_Nonnull task, id _Nonnull response))success
                       failure:(void (^)(TSNetworkRespose *_Nonnull task, NSError *_Nonnull error))failure;

- (void)TS_tokenRequestDataWithPath:(NSString *)path
                       isEncryption:(BOOL)encryption
                         parameters:(nullable NSDictionary *)parameters
                     viewController:(UIViewController *)controller
                            success:(nonnull void (^)(TSNetworkRespose *_Nonnull task, id _Nonnull response))success
                            failure:(void (^)(TSNetworkRespose *task, NSError *error))failure;
/**
 加密请求，返回解密

 @param path       <#path description#>
 @param parameters <#parameters description#>
 @param controller <#controller description#>
 @param success    <#success description#>
 @param failure    <#failure description#>
 */
- (void)encryptionRequestAndResponseDecryptionWithPath:(NSString *)path
                                            parameters:(nullable NSDictionary *)parameters
                                        viewController:(UIViewController *)controller success:(void (^)(TSNetworkRespose * _Nonnull task,id response))success
                                               failure:(void (^)(TSNetworkRespose * _Nonnull task,NSError *error))failure;

- (void)requestWithPath:(NSString *)path
             parameters:(nullable NSDictionary *)parameters
         viewController:(UIViewController *)controller
                success:(void (^)(TSNetworkRespose * _Nonnull task,id response))success
                failure:(void (^)(TSNetworkRespose * _Nonnull task,NSError *error))failure;

/**
 *  检测网络状态
 *
 *  @param block <#block description#>
 */
+ (void)networkStatus:(nullable void (^)(BOOL))block;
+ (BOOL)networkStatus;
+ (NSString *)KURLString;
+ (void)suspendedAllRequestWithSuspended:(BOOL)suspended;//进入后台冻结所有请求

/**
 *  登陆请求
 *
 *  @param controller <#controller description#>
 *  @param success    <#success description#>
 *  @param failure    <#failure description#>
 */
- (void)loginRequestFromController:(__kindof UIViewController *)controller
                        parameters:(NSDictionary *)parameters
                           success:(nonnull void (^)(TSNetworkRespose * _Nonnull dataTask, id _Nonnull response,NSDictionary *loginSaveDictionary))success
                           failure:(nonnull void (^)(TSNetworkRespose * _Nonnull dataTask, NSError * _Nonnull error))failure;



- (NSDictionary *)encryptionParmaeters:(NSDictionary *)parmaeters;
- (void)requestUserPrivs:(UIViewController *)vc;
- (void)loginErrorWithWithResponseObject:(id)responseObject;

/**
 *  请求不加密返回解密
 *
 *  @param path       <#path description#>
 *  @param parameters <#parameters description#>
 *  @param controller <#controller description#>
 *  @param success    <#success description#>
 *  @param failure    <#failure description#>
 */
- (void)requestWithPathResposeDescr:(NSString *)path
                         parameters:(nullable NSDictionary *)parameters
                     viewController:(UIViewController *)controller
                            success:(nonnull void (^)(TSNetworkRespose *_Nonnull, id _Nonnull))success
                            failure:(nonnull void (^)(TSNetworkRespose *_Nonnull, NSError *_Nonnull))failure;

- (NSDictionary *)handleData:(UIViewController *)vc response:(NSDictionary *)response;
@end

NS_ASSUME_NONNULL_END
