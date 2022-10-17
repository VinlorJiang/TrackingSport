//
//  TSNetWorkManager.m
//  trackingsport
//
//  Created by SZDCMAC15 on 2022/10/17.
//
#import "AFHTTPSessionManager+TSConfig.h"
#import "TSNetWorkManage.h"

#define kGetTokenPath @"getToken.htm"
#define kLoginPath @"memberUnifiedLogin.htm"
#define kGetUserPrivs @"revision/getUserPrivs.htm"

static NSString * const LOGIN = @"memberUnifiedLogin.htm";


typedef NS_ENUM(NSUInteger,TSRequestStatus) {
    TSRequestStatusStarter,
    TSRequestStatusEnd
};

@implementation TSNetworkRespose

- (instancetype)initWithTask:(NSURLSessionDataTask *)dataTask status:(TSError)status urlStr:(NSString *)urlString {
    self = [super init];
    if (self) {
//        NSParameterAssert(dataTask);
        _task = dataTask;
        _status = status;
        _urlString = [urlString copy];
    }
    return self;
}

- (instancetype)init {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:[NSString stringWithFormat:@"%@ Failed to call designated initializer. Invoke `initWithTask:` instead.", NSStringFromClass([self class])] userInfo:nil];
}

@end

@interface TSNetWorkManage ()
@property (nonatomic, strong) AFHTTPSessionManager *httpSessionManager;
@property (nonatomic, strong) NSURLSessionConfiguration *configuration;
@property (nonatomic, assign) BOOL networkStatus; //网络状态
@property (nonatomic) BOOL isUpdateButtonStatus;
@property (nonatomic) BOOL drawTimeout; //会画超时
@end


@implementation TSNetWorkManage

+ (TSNetWorkManage *)shareManage {
    static TSNetWorkManage *manage = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manage = [TSNetWorkManage new];
    });
    return manage;
}
+ (TSNetWorkManage *)shareManageNoUpdateButton{
    TSNetWorkManage *manage  = [TSNetWorkManage shareManage];
    manage.isUpdateButtonStatus = YES;
    return manage;
}

+ (TSNetWorkManage *)shareNoMBNoUpdateButton {
    TSNetWorkManage *manage  = [TSNetWorkManage shareNoMB];
    manage.isUpdateButtonStatus = YES;
    return manage;
}

+ (TSNetWorkManage *)shareNoMB {
    static TSNetWorkManage *noMB = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        noMB = [TSNetWorkManage new];
    });
    noMB.isShowMB = NO;
    noMB.isUpdateButtonStatus = NO;
    return noMB;
}
- (instancetype)init {
    self = [super init];
    if (self) {
        _httpSessionManager = [AFHTTPSessionManager ts_createDefaultManager];
        _isShowMB = YES;
        _currentRequestStatue = TSSuccess;
    }
    return self;
}

- (void)rootRequestWithPath:(NSString *)path
                 parameters:(nullable NSDictionary *)parameters
             viewController:(UIViewController *)controller
                    success:(nonnull void (^)(TSNetworkRespose *_Nonnull, id _Nonnull))success
                    failure:(void (^)(TSNetworkRespose *_Nonnull, NSError *_Nonnull))failure {
    
    TSNSLog(path);
    //KNSLog([LanguageTool sharedInstance].getCurrentLanguage);
    
    if (!path) return;

    
    NSDictionary *tempDictionary = [self configurationParameters:parameters];
    
    [self.httpSessionManager POST:path parameters:tempDictionary success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;

            static dispatch_once_t onceToken;
            static dispatch_semaphore_t lock;
            dispatch_once(&onceToken, ^{
                lock = dispatch_semaphore_create(1);
            });

            dispatch_semaphore_wait(lock, DISPATCH_TIME_FOREVER);
            _currentRequestStatue = [TSErrorManager requestIsSuccess:responseObject controller:controller];
            dispatch_semaphore_signal(lock);
            success([[TSNetworkRespose alloc] initWithTask:task status:_currentRequestStatue urlStr:path],responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        
        failure([[TSNetworkRespose alloc] initWithTask:task status:TSErrorOther urlStr:path], error);
        
        TSNSLog(error.debugDescription);
    }];
}

- (void)loginRequestFromController:(__kindof UIViewController *)controller
                        parameters:(NSDictionary *)parameters
                           success:(nonnull void (^)(TSNetworkRespose * _Nonnull dataTask, id _Nonnull response,NSDictionary *loginSaveDictionary))success
                           failure:(nonnull void (^)(TSNetworkRespose * _Nonnull dataTask, NSError * _Nonnull error))failure {

    void (^tempSuccessBlock)(TSNetworkRespose *, id) = ^(TSNetworkRespose *task, id response) {

        NSString *dkey = response[@"dkey"];
        NSString *userName = response[@"userName"];
        NSString *serverTime = response[@"serverTime"];

        NSMutableString *uuidd = [NSMutableString stringWithString:[NSString getClientUUID]];
        NSString* uuidStr = [uuidd stringByReplacingOccurrencesOfString:@"-" withString:@""];
        NSString*needStr = [NSString stringWithFormat:@"%@&ios&%@&%@&%@",[TSHelper decrytDataStr:response[@"accountNo"]],[[UIDevice currentDevice] systemVersion],uuidStr,response[@"authCode"]];
        
   
        NSMutableDictionary *saveDic = [NSMutableDictionary dictionary];
        void (^setDict)(NSString *, NSString *) = ^(NSString *value, NSString *key) {
            if (value) [saveDic setObject:value forKey:key];
        };

       
        setDict(task.status == TSSuccess ? @"1" : @"0" , @"keybool");

        void (^block)(NSString *, NSString *) = ^(NSString *value, NSString *key) {
            if (value) [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
        };
        block(serverTime, @"serverTime");
        block(userName, @"userName");
        if (success) success(task, response, saveDic);
    };

    [[TSNetWorkManage shareNoMB] getTokenRequest:controller success:^(TSNetworkRespose * _Nonnull task, NSString * _Nonnull token) {
        TSNSLog(@"");
    } failure:^(TSNetworkRespose * _Nonnull task, NSError * _Nonnull error) { failure(task,error);
        TSNSLog(@"");
    }];
}


/**
 *  请求Token
 *
 *  @param controller <#controller description#>
 *  @param success    <#success description#>
 *  @param failure    <#failure description#>
 *
 *  @return <#return value description#>
 */
- (void)getTokenRequest:(UIViewController *)controller
                success:(nonnull void (^)(TSNetworkRespose * _Nonnull, NSString * _Nonnull))success
                failure:(nonnull void (^)(TSNetworkRespose * _Nonnull, NSError * _Nonnull))failure {
    void(^tempSuccessBlock)(TSNetworkRespose *,id) = ^(TSNetworkRespose *task,id response) {
        success(task,response[@"token"]);
    };
    [self requestWithPath:kGetTokenPath parameters:nil viewController:controller success:tempSuccessBlock failure:failure];
}

/**
 数据请求

 @param path       <#path description#>
 @param parameters <#parameters description#>
 @param controller <#controller description#>
 @param success    <#success description#>
 @param failure    <#failure description#>
 */

- (void)requestWithPath:(NSString *)path
             parameters:(nullable NSDictionary *)parameters
         viewController:(UIViewController *)controller
                success:(nonnull void (^)(TSNetworkRespose *_Nonnull, id _Nonnull))success
                failure:(void (^)(TSNetworkRespose *_Nonnull, NSError *_Nonnull))failure {
    
    
    if (0) {
            
            NSLog(@"key为空~~~~~~~~~~~~~ 接口%@", path);
            static dispatch_once_t onceToken;
            static dispatch_semaphore_t semaphore;
            dispatch_queue_t queque = dispatch_queue_create("GoyakodCreated", DISPATCH_QUEUE_CONCURRENT);
            dispatch_once(&onceToken, ^{semaphore = dispatch_semaphore_create(1);});
            
            dispatch_async(queque, ^{
                dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
                
                //已经请求到key或者请求用户权限的时候 线程不卡住 直接继续请求目标接口
                if ([path isEqualToString:@"revision/getUserPrivs.htm"]) {
                    dispatch_semaphore_signal(semaphore);
                   
                    Kdispatch_async_on_main_queue(^{
                        [self lastSteprequestWithPath:path parameters:parameters viewController:controller success:success failure:failure];
                    });
                    return;
                }
                
                
                //未请求到key的时候
                NSLog(@"未请求到key的时候");
            });
        } else {//正常请求
            [self lastSteprequestWithPath:path parameters:parameters viewController:controller success:success failure:failure];
        }
}

- (void)lastSteprequestWithPath:(NSString *)path
                     parameters:(nullable NSDictionary *)parameters
                 viewController:(UIViewController *)controller
                        success:(nonnull void (^)(TSNetworkRespose *_Nonnull, id _Nonnull))success
                        failure:(void (^)(TSNetworkRespose *_Nonnull, NSError *_Nonnull))failure {
    //语言设置成功才能进行其他请求
   
    [self rootRequestWithPath:path parameters:parameters viewController:controller success:success failure:failure];
}

- (NSDictionary *)configurationParameters:(NSDictionary *)dict {
    if (dict) {
        return @{ @"reqData": [dict JSONRepresentation] };
    } else {
        return nil;
    }
}
@end
